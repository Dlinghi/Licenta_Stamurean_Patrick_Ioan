#include "xparameters.h"
#include "xaxidma.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "lwip/init.h"
#include "lwip/netif.h"
#include "lwip/tcpip.h"
#include "netif/xadapter.h"
#include "lwip/udp.h"
#include "platform_config.h"
#include "platform.h"
#include "xil_cache.h"
#include <string.h>

#define DMA_DEV_ID XPAR_AXIDMA_0_DEVICE_ID
#define INTC_DEVICE_ID XPAR_SCUGIC_SINGLE_DEVICE_ID
#define RX_INTR_ID XPAR_FABRIC_AXI_DMA_0_S2MM_INTROUT_INTR
#define TX_INTR_ID XPAR_FABRIC_AXI_DMA_0_MM2S_INTROUT_INTR

XAxiDma AxiDma;
XScuGic Intc;

volatile int TxDone;
volatile int RxDone;
volatile int Error;

struct netif server_netif;
struct netif *echo_netif;

void udp_recv_callback(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port);
int initialize_dma(void);
int init_interrupt_system(void);

void udp_recv_callback(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port) {
    if (p != NULL) {
        void *processed_buffer = malloc(p->len);
        if (processed_buffer == NULL) {
            xil_printf("Memory allocation failed\r\n");
            pbuf_free(p);
            return;
        }

        // Flush the cache to ensure data coherence
        Xil_DCacheFlushRange((UINTPTR)p->payload, p->len);

        // Send the data to DMA
        if (XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)p->payload, p->len, XAXIDMA_DMA_TO_DEVICE) != XST_SUCCESS) {
            xil_printf("DMA transfer to device failed\r\n");
            free(processed_buffer);
            pbuf_free(p);
            return;
        }

        // Wait for the DMA transfer to complete
        while (XAxiDma_Busy(&AxiDma, XAXIDMA_DMA_TO_DEVICE));

        // Read processed data back from the custom IP through DMA
        if (XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)processed_buffer, p->len, XAXIDMA_DEVICE_TO_DMA) != XST_SUCCESS) {
            xil_printf("DMA transfer from device failed\r\n");
            free(processed_buffer);
            pbuf_free(p);
            return;
        }

        // Wait for the DMA transfer to complete
        while (XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA));

        // Flush the cache to ensure data coherence
        Xil_DCacheInvalidateRange((UINTPTR)processed_buffer, p->len);

        // Send processed data back to the PC
        struct pbuf *q = pbuf_alloc(PBUF_TRANSPORT, p->len, PBUF_RAM);
        if (q != NULL) {
            memcpy(q->payload, processed_buffer, p->len);
            udp_sendto(pcb, q, addr, port);
            pbuf_free(q);
        } else {
            xil_printf("pbuf allocation failed\r\n");
        }

        // Free the received packet
        pbuf_free(p);
        free(processed_buffer);
    }
}

int initialize_dma(void) {
    XAxiDma_Config *CfgPtr;
    int Status;

    CfgPtr = XAxiDma_LookupConfig(DMA_DEV_ID);
    if (!CfgPtr) {
        xil_printf("No config found for %d\r\n", DMA_DEV_ID);
        return XST_FAILURE;
    }

    Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
    if (Status != XST_SUCCESS) {
        xil_printf("Initialization failed %d\r\n", Status);
        return XST_FAILURE;
    }

    if (XAxiDma_HasSg(&AxiDma)) {
        xil_printf("Device configured as SG mode \r\n");
        return XST_FAILURE;
    }

    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

    return XST_SUCCESS;
}

int init_interrupt_system(void) {
    XScuGic_Config *IntcConfig;
    int Status;

    IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
    if (IntcConfig == NULL) {
        return XST_FAILURE;
    }

    Status = XScuGic_CfgInitialize(&Intc, IntcConfig, IntcConfig->CpuBaseAddress);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
            (Xil_ExceptionHandler)XScuGic_InterruptHandler,
            &Intc);
    Xil_ExceptionEnable();

    return XST_SUCCESS;
}

int main(void) {
    ip_addr_t ipaddr, netmask, gw;
    struct udp_pcb *pcb;

    // Initializeaza platforma
    init_platform();

    xil_printf("\r\n--- Starting DMA example ---\r\n");

    // Initializeaza DMA
    if (initialize_dma() != XST_SUCCESS) {
        xil_printf("DMA initialization failed\r\n");
        return XST_FAILURE;
    }

    // Initializeaza Interrupt System
    if (init_interrupt_system() != XST_SUCCESS) {
        xil_printf("Interrupt system initialization failed\r\n");
        return XST_FAILURE;
    }

    // Initializeaza IwIP stack
    lwip_init();

    // Seteaza adresa IP, Netmask si Gateway
    IP4_ADDR(&ipaddr,  192, 168,   1, 10);
    IP4_ADDR(&netmask, 255, 255, 255,  0);
    IP4_ADDR(&gw,      192, 168,   1,  1);

    // Adauga Interfata Network
    echo_netif = &server_netif;
    if (!xemac_add(echo_netif, &ipaddr, &netmask, &gw, NULL, PLATFORM_EMAC_BASEADDR)) {
        xil_printf("Error adding N/W interface\r\n");
        return -1;
    }
    netif_set_default(echo_netif);
    netif_set_up(echo_netif);

    xil_printf("Network setup done\r\n");

    // Creaza un UDP PCB (Protocol Control Block) nou
    pcb = udp_new();
    if (!pcb) {
        xil_printf("UDP PCB creation failed\r\n");
        return -1;
    }

    // Bind-uie UDP socket la portul 5001
    if (udp_bind(pcb, IP_ADDR_ANY, 5001) != ERR_OK) {
        xil_printf("UDP bind failed\r\n");
        return -1;
    }

    // UDP Receive Callback
    udp_recv(pcb, udp_recv_callback, NULL);

    // Loop Infinit pentru Procesarea Pachetelor Network
    while (1) {
        xemacif_input(echo_netif);
    }

    // Clean up Platforma la iesire
    cleanup_platform();
    return 0;
}
