/*========================================[Includes]========================================*/
// Bibliotecile Xilinx si lwIP
#include "xparameters.h"     // Parametrii hardware Xilinx
#include "xaxidma.h"         // Driver AXI DMA
#include "xscugic.h"         // Driver pentru controlerul de intreruperi
#include "xwdttb.h"          // Driver pentru temporizatorul Watchdog
#include "xil_exception.h"   // Gestionarea exceptiilor
#include "xil_printf.h"      // Functionalitate pentru afisare
#include "xil_io.h"          // Functii de I/O
#include "lwip/init.h"       // Initializarea lwIP
#include "lwip/netif.h"      // Interfata de retea
#include "lwip/tcpip.h"      // Stiva TCP/IP
#include "netif/xadapter.h"  // Interfata adaptorului de retea
#include "lwip/udp.h"        // Functii UDP
#include "platform_config.h" // Configuratie specifica platformei
#include "platform.h"        // Configurare si curatare platforma
#include "xil_cache.h"       // Controlul cache-ului
#include <string.h>          // Functii pentru siruri de caractere
#include <stdlib.h>          // Biblioteca standard pentru malloc si free
#include "xgpio.h"           // Driver GPIO Xilinx

/*========================================[Definitii]========================================*/
#define DMA_DEV_ID          XPAR_AXIDMA_0_DEVICE_ID
#define INTC_DEVICE_ID      XPAR_SCUGIC_SINGLE_DEVICE_ID
#define RX_INTR_ID          XPAR_FABRIC_AXI_DMA_0_S2MM_INTROUT_INTR
#define TX_INTR_ID          XPAR_FABRIC_AXI_DMA_0_MM2S_INTROUT_INTR
#define WDT_DEV_ID          XPAR_AXI_TIMEBASE_WDT_0_DEVICE_ID
#define WDT_INTR_ID         XPAR_FABRIC_AXI_TIMEBASE_WDT_0_WDT_INTERRUPT_INTR
#define WDT_TIMEOUT         500000000  // Timeout-ul pentru 5 secunde bazat pe un clock de 100MHz

#define GPIO_DEVICE_ID      XPAR_AXI_GPIO_0_DEVICE_ID  // ID dispozitiv GPIO
#define SWITCH_CHANNEL      1  // Canal pentru intrerupatoare
#define FIFO_TREADY_CHANNEL 2  // Canal pentru FIFO tready

/*========================================[Variabile Globale]========================================*/
XAxiDma AxiDma;          // Instanta DMA pentru transferuri de date
XScuGic Intc;            // Instanta pentru controlerul de intreruperi
XWdtTb WdtTb;            // Instanta pentru temporizatorul watchdog
XGpio Gpio;              // Instanta GPIO

volatile int TxDone;     // Indicator pentru completarea transmisiei DMA
volatile int RxDone;     // Indicator pentru completarea receptiei DMA
volatile int Error;      // Indicator de eroare

struct netif server_netif;  // Instanta interfata de retea
struct netif *echo_netif;   // Pointer catre interfata de retea

/*========================================[Declaratii de Functii]========================================*/
void udp_recv_callback(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port);
int initialize_dma(void);
int init_interrupt_system(void);
int initialize_watchdog(void);
int initialize_gpio(void);
void WdtTb_IntrHandler(void *CallBackRef);
void check_switches_and_control_fifo(void);

/******************************************************************************************************************
    Nume Functie:          udp_recv_callback

    Functionalitate:       Callback pentru Receptia UDP
                           - Aceasta functie este apelata de fiecare data cand un pachet UDP este primit.
                           - Proceseaza datele primite utilizand DMA si trimite inapoi datele procesate.
******************************************************************************************************************/
void udp_recv_callback(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr, u16_t port) {
    if (p != NULL) {
        // Aloca buffer pentru datele procesate
        void *processed_buffer = malloc(p->len);
        if (processed_buffer == NULL) {
            xil_printf("Alocarea memoriei a esuat\r\n");
            pbuf_free(p);
            return;
        }

        // Golire cache pentru asigurarea coerentei datelor
        Xil_DCacheFlushRange((UINTPTR)p->payload, p->len);

        // Verifica starea intrerupatoarelor si controleaza FIFO
        check_switches_and_control_fifo();

        // Trimite datele catre DMA
        if (XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)p->payload, p->len, XAXIDMA_DMA_TO_DEVICE) != XST_SUCCESS) {
            xil_printf("Transfer DMA catre dispozitiv a esuat\r\n");
            free(processed_buffer);
            pbuf_free(p);
            return;
        }

        // Asteapta finalizarea transferului DMA
        while (XAxiDma_Busy(&AxiDma, XAXIDMA_DMA_TO_DEVICE));

        // Citeste datele procesate din custom IP-ul prin DMA
        if (XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)processed_buffer, p->len, XAXIDMA_DEVICE_TO_DMA) != XST_SUCCESS) {
            xil_printf("Transfer DMA de la dispozitiv a esuat\r\n");
            free(processed_buffer);
            pbuf_free(p);
            return;
        }

        // Asteapta finalizarea transferului DMA
        while (XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA));

        // Invalidare cache pentru asigurarea coerentei datelor
        Xil_DCacheInvalidateRange((UINTPTR)processed_buffer, p->len);

        // Trimite datele procesate inapoi catre PC
        struct pbuf *q = pbuf_alloc(PBUF_TRANSPORT, p->len, PBUF_RAM);
        if (q != NULL) {
            memcpy(q->payload, processed_buffer, p->len);
            udp_sendto(pcb, q, addr, port);
            pbuf_free(q);
        } else {
            xil_printf("Alocarea pbuf (Packet Buffer) a esuat\r\n");
        }

        // Elibereaza memoria alocata
        pbuf_free(p);
        free(processed_buffer);

        // Reporneste temporizatorul watchdog dupa procesarea cu succes
        XWdtTb_RestartWdt(&WdtTb);
    }
}

/******************************************************************************************************************
    Nume Functie:          WdtTb_IntrHandler

    Functionalitate:       Handler pentru Interruptia Temporizatorului Watchdog
                           - Aceasta functie este apelata cand temporizatorul watchdog expira.
                           - Va afisa un mesaj indicand expirarea watchdog-ului.
******************************************************************************************************************/
void WdtTb_IntrHandler(void *CallBackRef) {
    XWdtTb *WdtTbPtr = (XWdtTb *)CallBackRef;
    xil_printf("Temporizatorul Watchdog a expirat! Nicio activitate de transfer de date pentru 5 secunde.\r\n");
    
    // Repornirea temporizatorului watchdog
    XWdtTb_RestartWdt(WdtTbPtr);
}

/******************************************************************************************************************
    Nume Functie:          init_interrupt_system

    Functionalitate:       Initializeaza Sistemul de Intreruperi
                           - Initializeaza controlerul de intreruperi si conecteaza handlerii de intreruperi.
******************************************************************************************************************/
int init_interrupt_system(void) {
    XScuGic_Config *IntcConfig;
    int Status;

    // Initializeaza driverul controlerului de intreruperi
    IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
    if (IntcConfig == NULL) {
        xil_printf("XScuGic_LookupConfig a esuat\r\n");
        return XST_FAILURE;
    }

    Status = XScuGic_CfgInitialize(&Intc, IntcConfig, IntcConfig->CpuBaseAddress);
    if (Status != XST_SUCCESS) {
        xil_printf("XScuGic_CfgInitialize a esuat\r\n");
        return XST_FAILURE;
    }

    // Conecteaza intreruperea DMA TX
    Status = XScuGic_Connect(&Intc, TX_INTR_ID, (Xil_ExceptionHandler)XAxiDma_SimpleTransfer, &AxiDma);
    if (Status != XST_SUCCESS) {
        xil_printf("Conectarea intreruperii DMA TX a esuat\r\n");
        return XST_FAILURE;
    }

    // Conecteaza intreruperea DMA RX
    Status = XScuGic_Connect(&Intc, RX_INTR_ID, (Xil_ExceptionHandler)XAxiDma_SimpleTransfer, &AxiDma);
    if (Status != XST_SUCCESS) {
        xil_printf("Conectarea intreruperii DMA RX a esuat\r\n");
        return XST_FAILURE;
    }

    // Conecteaza handlerul pentru intreruperea temporizatorului watchdog
    Status = XScuGic_Connect(&Intc, WDT_INTR_ID, (Xil_ExceptionHandler)WdtTb_IntrHandler, (void *)&WdtTb);
    if (Status != XST_SUCCESS) {
        xil_printf("Conectarea intreruperii temporizatorului watchdog a esuat\r\n");
        return XST_FAILURE;
    }

    // Activeaza intreruperile
    XScuGic_Enable(&Intc, TX_INTR_ID);
    XScuGic_Enable(&Intc, RX_INTR_ID);
    XScuGic_Enable(&Intc, WDT_INTR_ID);

    // Initializeaza tabelul de exceptii si inregistreaza handlerul controlerului de intreruperi
    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XScuGic_InterruptHandler, &Intc);
    Xil_ExceptionEnable();

    return XST_SUCCESS;
}

/******************************************************************************************************************
    Nume Functie:          initialize_dma

    Functionalitate:       Initializeaza DMA
                           - Initializeaza AXI DMA.
******************************************************************************************************************/
int initialize_dma(void) {
    XAxiDma_Config *CfgPtr;
    int Status;

    // Initializeaza dispozitivul XAxiDma.
    CfgPtr = XAxiDma_LookupConfig(DMA_DEV_ID);
    if (!CfgPtr) {
        xil_printf("Niciun config gasit pentru %d\r\n", DMA_DEV_ID);
        return XST_FAILURE;
    }

    Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
    if (Status != XST_SUCCESS) {
        xil_printf("Initializarea a esuat %d\r\n", Status);
        return XST_FAILURE;
    }

    // Verifica modul scatter-gather
    if (XAxiDma_HasSg(&AxiDma)) {
        xil_printf("Dispozitivul configurat ca mod SG\r\n");
        return XST_FAILURE;
    }

    // Dezactiveaza intreruperile
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

    return XST_SUCCESS;
}

/******************************************************************************************************************
    Nume Functie:          initialize_watchdog

    Functionalitate:       Initializeaza Temporizatorul Watchdog
                           - Configureaza si porneste temporizatorul AXI Watchdog.
******************************************************************************************************************/
int initialize_watchdog(void) {
    XWdtTb_Config *WdtConfig;
    int Status;

    // Cauta configuratia WDT
    WdtConfig = XWdtTb_LookupConfig(WDT_DEV_ID);
    if (WdtConfig == NULL) {
        xil_printf("Niciun config gasit pentru WDT %d\r\n", WDT_DEV_ID);
        return XST_FAILURE;
    }

    // Initializeaza temporizatorul Watchdog
    Status = XWdtTb_CfgInitialize(&WdtTb, WdtConfig, WdtConfig->BaseAddr);
    if (Status != XST_SUCCESS) {
        xil_printf("Initializarea WDT a esuat\r\n");
        return XST_FAILURE;
    }

    // Seteaza temporizatorul Watchdog pentru un timeout de 5 secunde
    // Presupunand ca 1 tick = 1 ciclu de clock, Timeout = 500.000.000 cicluri pentru 5 secunde la 100MHz
    XWdtTb_WriteReg(WdtConfig->BaseAddr, XWT_TWCSR0_OFFSET, 0x00000000); // Dezactiveaza WDT
    XWdtTb_WriteReg(WdtConfig->BaseAddr, XWT_TBR_OFFSET, WDT_TIMEOUT);   // Seteaza valoarea timeout-ului
    XWdtTb_WriteReg(WdtConfig->BaseAddr, XWT_TWCSR0_OFFSET, 0x00000001); // Activeaza WDT

    // Porneste temporizatorul Watchdog
    XWdtTb_Start(&WdtTb);

    return XST_SUCCESS;
}

/******************************************************************************************************************
    Nume Functie:          initialize_gpio

    Functionalitate:       Initializeaza GPIO
                           - Initializeaza AXI GPIO pentru intrarea intrerupatoarelor si controlul FIFO.
******************************************************************************************************************/
int initialize_gpio(void) {
    int Status;

    // Initializeaza driverul GPIO
    Status = XGpio_Initialize(&Gpio, GPIO_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        xil_printf("Initializarea GPIO a esuat\r\n");
        return XST_FAILURE;
    }

    // Seteaza directia pentru canalul de intrerupatoare ca intrare
    XGpio_SetDataDirection(&Gpio, SWITCH_CHANNEL, 0xFF); // Toate intrarile

    // Seteaza directia pentru canalul FIFO tready ca iesire
    XGpio_SetDataDirection(&Gpio, FIFO_TREADY_CHANNEL, 0x00); // Toate iesirile

    return XST_SUCCESS;
}

/******************************************************************************************************************
    Nume Functie:          check_switches_and_control_fifo

    Functionalitate:       Verifica Intrerupatoarele si Controleaza FIFO
                           - Citeste starea intrerupatoarelor si seteaza semnalul FIFO tready corespunzator.
******************************************************************************************************************/
void check_switches_and_control_fifo(void) {
    u32 switch_status;

    // Citeste starea intrerupatoarelor
    switch_status = XGpio_DiscreteRead(&Gpio, SWITCH_CHANNEL);

    // Verifica primul intrerupator si controleaza FIFO tready
    if (switch_status & 0x01) { // Daca primul intrerupator este activ
        XGpio_DiscreteWrite(&Gpio, FIFO_TREADY_CHANNEL, 0x01); // Seteaza tready activ
    } else {
        XGpio_DiscreteWrite(&Gpio, FIFO_TREADY_CHANNEL, 0x00); // Seteaza tready inactiv
    }
}

/******************************************************************************************************************
    Nume Functie:          main

    Functionalitate:       Functia Principala
                           - Initializeaza platforma, DMA, sistemul de intreruperi si interfata de retea.
                           - Configureaza callback-ul UDP si intra intr-un ciclu infinit pentru a procesa pachetele primite.
******************************************************************************************************************/
int main(void) {
    ip_addr_t ipaddr, netmask, gw;
    struct udp_pcb *pcb;

    // Initializeaza platforma
    init_platform();

    xil_printf("\r\n--- Pornirea Procesarii Fluxului Video cu Watchdog ---\r\n");

    // Initializeaza DMA
    if (initialize_dma() != XST_SUCCESS) {
        xil_printf("Initializarea DMA a esuat\r\n");
        return XST_FAILURE;
    }

    // Initializeaza Sistemul de Intreruperi
    if (init_interrupt_system() != XST_SUCCESS) {
        xil_printf("Initializarea Sistemului de Intreruperi a esuat\r\n");
        return XST_FAILURE;
    }

    // Initializeaza Temporizatorul Watchdog
    if (initialize_watchdog() != XST_SUCCESS) {
        xil_printf("Initializarea Temporizatorului Watchdog a esuat\r\n");
        return XST_FAILURE;
    }

    // Initializeaza GPIO
    if (initialize_gpio() != XST_SUCCESS) {
        xil_printf("Initializarea GPIO a esuat\r\n");
        return XST_FAILURE;
    }

    // Initializeaza stiva lwIP
    lwip_init();

    // Seteaza adresa IP, masca de retea si gateway-ul
    IP4_ADDR(&ipaddr, 192, 168, 1, 10);
    IP4_ADDR(&netmask, 255, 255, 255, 0);
    IP4_ADDR(&gw, 192, 168, 1, 1);

    // Adauga interfata de retea
    echo_netif = &server_netif;
    if (!xemac_add(echo_netif, &ipaddr, &netmask, &gw, NULL, PLATFORM_EMAC_BASEADDR)) {
        xil_printf("Eroare la adaugarea interfetei de retea\r\n");
        return -1;
    }
    netif_set_default(echo_netif);
    netif_set_up(echo_netif);

    xil_printf("Configuratia retelei a fost finalizata\r\n");

    // Creeaza un nou PCB UDP (Protocol Control Block)
    pcb = udp_new();
    if (!pcb) {
        xil_printf("Eroare la crearea PCB-ului UDP\r\n");
        return -1;
    }

    // Asociaza socketul UDP la portul 5001
    if (udp_bind(pcb, IP_ADDR_ANY, 5001) != ERR_OK) {
        xil_printf("Asocierea UDP a esuat\r\n");
        return -1;
    }

    // Inregistreaza callback-ul pentru receptia UDP
    udp_recv(pcb, udp_recv_callback, NULL);

    // Ciclul infinit pentru a procesa pachetele primite
    while (1) {
        xemacif_input(echo_netif);
    }

    // Curatarea platformei la iesire
    cleanup_platform();
    return 0;
}
