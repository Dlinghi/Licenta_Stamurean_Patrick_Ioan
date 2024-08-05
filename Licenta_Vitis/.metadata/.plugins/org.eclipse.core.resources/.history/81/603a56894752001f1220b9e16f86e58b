/*========================================[Includes]========================================*/
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



/*========================================[Definitions]========================================*/
#define DMA_DEV_ID XPAR_AXIDMA_0_DEVICE_ID
#define INTC_DEVICE_ID XPAR_SCUGIC_SINGLE_DEVICE_ID
#define RX_INTR_ID XPAR_FABRIC_AXI_DMA_0_S2MM_INTROUT_INTR
#define TX_INTR_ID XPAR_FABRIC_AXI_DMA_0_MM2S_INTROUT_INTR



/*========================================[Variabile Globale]========================================*/
XAxiDma AxiDma;
XScuGic Intc;

volatile int TxDone;
volatile int RxDone;
volatile int Error;

struct netif server_netif;
struct netif *echo_netif;



/*========================================[Internal Function Declaration]========================================*/
void udp_recv_callback(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port);
int initialize_dma(void);
int init_interrupt_system(void);



/******************************************************************************************************************
    Function Name:          udp_recv_callback

    Functionalitate:        UDP Receive Callback
                            -Aceasta functie este apelata ori de cate ori este primit un pachet UDP.
                            -Proceseaza datele primite folosind DMA si trimite inapoi datele procesate.

                            -Aloca memorie pentru datele procesate.
                            -Sterge memoria cache pentru a asigura coerenta datelor.
                            -Trimite date catre DMA.
                            -Asteapta finalizarea transferului DMA.
                            -Citeste datele procesate inapoi de la custom IP-ul prin DMA.
                            -Trimite datele procesate inapoi la PC.
                            -Elibereaza memoria alocata.

******************************************************************************************************************/
void udp_recv_callback(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port) {
    if (p != NULL) {
        void *processed_buffer = malloc(p->len);
        if (processed_buffer == NULL) {
            xil_printf("Memory allocation failed\r\n");
            pbuf_free(p);
            return;
        }

        // Sterge memoria cache pentru a asigura coerenta datelor
        Xil_DCacheFlushRange((UINTPTR)p->payload, p->len);

        // Trimite date catre DMA
        if (XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)p->payload, p->len, XAXIDMA_DMA_TO_DEVICE) != XST_SUCCESS) {
            xil_printf("DMA transfer to device failed\r\n");
            free(processed_buffer);
            pbuf_free(p);
            return;
        }

        // Asteapta finalizarea transferului DMA
        while (XAxiDma_Busy(&AxiDma, XAXIDMA_DMA_TO_DEVICE));

        // Citeste datele procesate inapoi de la IP-ul personalizat prin DMA
        if (XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)processed_buffer, p->len, XAXIDMA_DEVICE_TO_DMA) != XST_SUCCESS) {
            xil_printf("DMA transfer from device failed\r\n");
            free(processed_buffer);
            pbuf_free(p);
            return;
        }

        // Asteapta finalizarea transferului DMA
        while (XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA));

        // Sterge memoria cache pentru a asigura coerenta datelor
        Xil_DCacheInvalidateRange((UINTPTR)processed_buffer, p->len);

        // Trimite datele procesate inapoi la PC
        struct pbuf *q = pbuf_alloc(PBUF_TRANSPORT, p->len, PBUF_RAM);
        if (q != NULL) {
            memcpy(q->payload, processed_buffer, p->len);
            udp_sendto(pcb, q, addr, port);
            pbuf_free(q);
        } else {
            xil_printf("pbuf allocation failed\r\n");
        }

        // Elibereaza memoria alocata
        pbuf_free(p);
        free(processed_buffer);
    }
}



/******************************************************************************************************************
    Function Name:          initialize_dma

    Functionalitate:        Initializare DMA
                            -Aceasta functie initializeaza DMA.

                            -Cauta configuratia DMA.
                            -Initializeaza DMA cu configuratia.
                            -Verifica daca DMA este configurat in modul Scatter-Gather (ceea ce nu ar trebui sa fie).
                            -Dezactiveaza toate intreruperile DMA.

******************************************************************************************************************/
int initialize_dma(void) {
    XAxiDma_Config *CfgPtr;
    int Status;

    // Cauta configuratia DMA
    CfgPtr = XAxiDma_LookupConfig(DMA_DEV_ID);
    if (!CfgPtr) {
        xil_printf("No config found for %d\r\n", DMA_DEV_ID);
        return XST_FAILURE;
    }

    // Initializeaza DMA cu configuratia
    Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
    if (Status != XST_SUCCESS) {
        xil_printf("Initialization failed %d\r\n", Status);
        return XST_FAILURE;
    }

    // Verifica daca DMA este configurat in modul Scatter-Gather (ceea ce nu ar trebui sa fie)
    if (XAxiDma_HasSg(&AxiDma)) {
        xil_printf("Configurat in modul S-G \r\n");
        return XST_FAILURE;
    }

    // Dezactiveaza toate intreruperile DMA
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

    return XST_SUCCESS;
}



/******************************************************************************************************************
    Function Name:          init_interrupt_system

    Functionalitate:        Initializare sistemul de Intreruperi
                            -Aceasta functie initializeaza sistemul de intrerupere.
                            
                            -Cauta configuratia controlerului de intrerupere.
                            -Initializeaza controlerul de intrerupere.
                            -Inregistreaza handlerul de intrerupere si activeaza exceptiile.

******************************************************************************************************************/
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



/******************************************************************************************************************
    Function Name:          main

    Functionalitate:        Functia Main
                            -Functia principala configureaza platforma, initializeaza sistemele DMA si intrerupe, configureaza interfata de retea si leaga socket-ul UDP.

                            -Initializeaza platforma.
                            -Initializeaza DMA.
                            -Initializeaza sistemul de intrerupere.
                            -Initializeaza stiva lwIP.
                            -Configurati adresa IP, masca de retea si gateway-ul.
                            -Adauga interfata de retea.
                            -Creeaza un nou PCB UDP (Protocol Control Block).
                            -Leaga scoket-ul UDP la portul 5001.
                            -Inregistreaza apelul de primire UDP.
                            -Intra intr-o bucla infinita pentru a procesa pachetele de retea primite.
                            -Curata platforma la iesire.

******************************************************************************************************************/
int main(void) {
    ip_addr_t ipaddr, netmask, gw;
    struct udp_pcb *pcb;

    // Initializeaza platforma
    init_platform();

    xil_printf("\r\n--- Starting DMA ---\r\n");

    // Initializeaza DMA
    if (initialize_dma() != XST_SUCCESS) {
        xil_printf("Initializare DMA failed\r\n");
        return XST_FAILURE;
    }

    // Initializeaza Interrupt System
    if (init_interrupt_system() != XST_SUCCESS) {
        xil_printf("Initializare Sistemului de Intreruperi failed\r\n");
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
        xil_printf("Error adaugare interfata Network\r\n");
        return -1;
    }
    netif_set_default(echo_netif);
    netif_set_up(echo_netif);

    xil_printf("Network setup finalizat\r\n");

    // Creaza un UDP PCB (Protocol Control Block) nou
    pcb = udp_new();
    if (!pcb) {
        xil_printf("Creare UDP PCB failed\r\n");
        return -1;
    }

    // Bind-uie UDP socket la portul 5001
    if (udp_bind(pcb, IP_ADDR_ANY, 5001) != ERR_OK) {
        xil_printf("UDP bind failed\r\n");
        return -1;
    }

    // Inregistreaza apelul de primire UDP
    udp_recv(pcb, udp_recv_callback, NULL);

    // Bucla infinita pentru a procesa pachetele de retea primite
    while (1) {
        xemacif_input(echo_netif);
    }

    // Curata platforma la iesire
    cleanup_platform();
    return 0;
}
