#include "xparameters.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "xil_exception.h"
#include "xscugic.h"
#include "xtmrctr.h"
#include "axi_traffic_gen.h"
#include "axi_dma.h"
#include "axi_gpio.h"
#include "axi_timer.h" // Include the header for AXI Timer
#include "axi_gpio_1.h" // Include the header for AXI GPIO 1
#include "axi_gpio_2.h" // Include the header for AXI GPIO 2
#include "axi_timebase_wdt.h" // Include the header for AXI Timebase Watchdog Timer
#include "xgpio.h"
#include "xtmrctr_l.h" // Include the low-level header for register offsets
#include "xwdttb.h" // Include the watchdog timer header

// Buffer size
#define BUFFER_SIZE 1024
#define PATTERN 0xA5A5A5A5
#define DMA_BUFFER_BASE (XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x01000000)  // Adjust the address according to your system

// Interrupt IDs
#define WDT_INTERRUPT_ID XPAR_FABRIC_AXI_TIMEBASE_WDT_0_WDT_INTERRUPT_INTR

// Instances
XTmrCtr TimerInstance;
XGpio GpioInstance;
XGpio GpioInstance1;  // GPIO instance for axi_gpio_1
XGpio GpioInstance2;  // GPIO instance for axi_gpio_2
XWdtTb WdtInstance;
XScuGic InterruptController;

// Global variables
volatile u32 TimeInSeconds = 0;
volatile u32 WatchdogEnabled = 1;

// Function prototypes
void Timer_Intr_Handler(void *CallBackRef, u8 TmrCtrNumber);
void WDT_Intr_Handler(void *CallBackRef);
int SetupInterruptSystem(XScuGic *IntcInstancePtr, XTmrCtr *TimerInstancePtr, XWdtTb *WdtInstancePtr);

void start_traffic_gen() {
    xil_printf("Starting AXI Traffic Generator...\n");
    AXI_TrafficGen_SetPattern(AXI_TRAFFIC_GEN_BASEADDR, PATTERN);
    AXI_TrafficGen_Start(AXI_TRAFFIC_GEN_BASEADDR);
}

void transfer_data(XAxiDma *AxiDmaInstance, u32 *buffer) {
    xil_printf("Transferring data from Traffic Generator to FIFO via DMA...\n");
    int Status = AXI_DMA_S2MM_Transfer(AxiDmaInstance, (u32)buffer, BUFFER_SIZE * sizeof(u32));
    if (Status != XST_SUCCESS) {
        xil_printf("DMA S2MM transfer failed\n");
        return;
    }

    // Wait for the transfer to complete
    while (XAxiDma_Busy(AxiDmaInstance, XAXIDMA_DEVICE_TO_DMA));

    xil_printf("Transfer complete. Data in buffer: ");
    for (int i = 0; i < BUFFER_SIZE; i++) {
        xil_printf("%08X ", buffer[i]);
    }
    xil_printf("\n");

    xil_printf("Stopping AXI Traffic Generator...\n");
    AXI_TrafficGen_Stop(AXI_TRAFFIC_GEN_BASEADDR);
}

void wait_for_button_press() {
    xil_printf("Waiting for button press to restart traffic generator...\n");
    while (1) {
        if (AXI_GPIO_Read(&GpioInstance) & 0x01) {  // Check if button 0 is pressed
            xil_printf("Button pressed, restarting traffic generator...\n");
            break;
        }
    }
}

void Timer_Intr_Handler(void *CallBackRef, u8 TmrCtrNumber) {
    XTmrCtr *TimerInstancePtr = (XTmrCtr *)CallBackRef;

    // Clear the interrupt
    XTmrCtr_SetControlStatusReg(TimerInstancePtr->BaseAddress, TmrCtrNumber,
        XTmrCtr_GetControlStatusReg(TimerInstancePtr->BaseAddress, TmrCtrNumber) | XTC_CSR_INT_OCCURED_MASK);

    // Increment the time in seconds
    TimeInSeconds++;

    // Write the time in seconds to the LEDs
    AXI_GPIO_1_Write(&GpioInstance1, TimeInSeconds);
}

void WDT_Intr_Handler(void *CallBackRef) {
    XWdtTb *WdtInstancePtr = (XWdtTb *)CallBackRef;

    // Clear the interrupt
    XWdtTb_RestartWdt(WdtInstancePtr);

    // Check if the watchdog is enabled
    if (WatchdogEnabled) {
        // Reset the traffic generator
        AXI_TrafficGen_Reset(AXI_TRAFFIC_GEN_BASEADDR);
        start_traffic_gen();
    }
}

int SetupInterruptSystem(XScuGic *IntcInstancePtr, XTmrCtr *TimerInstancePtr, XWdtTb *WdtInstancePtr) {
    XScuGic_Config *IntcConfig;
    int Status;

    // Initialize the interrupt controller driver
    IntcConfig = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
    if (NULL == IntcConfig) {
        return XST_FAILURE;
    }

    Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig, IntcConfig->CpuBaseAddress);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // Set up the interrupt system
    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                 (Xil_ExceptionHandler)XScuGic_InterruptHandler,
                                 IntcInstancePtr);
    Xil_ExceptionEnable();

    // Connect the timer interrupt handler
    Status = XScuGic_Connect(IntcInstancePtr, TIMER_INTERRUPT_ID,
                             (Xil_InterruptHandler)Timer_Intr_Handler,
                             TimerInstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    // Enable the timer interrupt
    XScuGic_Enable(IntcInstancePtr, TIMER_INTERRUPT_ID);
    XTmrCtr_EnableIntr(TimerInstancePtr->BaseAddress, 0);

    // Connect the watchdog interrupt handler
    Status = XScuGic_Connect(IntcInstancePtr, WDT_INTERRUPT_ID,
                             (Xil_InterruptHandler)WDT_Intr_Handler,
                             WdtInstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    // Enable the watchdog interrupt
    XScuGic_Enable(IntcInstancePtr, WDT_INTERRUPT_ID);

    return XST_SUCCESS;
}

int main() {
    XAxiDma AxiDmaInstance;
    int Status;
    u32 *buffer = (u32 *)DMA_BUFFER_BASE;

    xil_printf("Initializing AXI DMA...\n");
    Status = AXI_DMA_Init(&AxiDmaInstance);
    if (Status != XST_SUCCESS) {
        xil_printf("AXI DMA initialization failed\n");
        return XST_FAILURE;
    }

    xil_printf("Initializing AXI GPIO 0...\n");
    Status = AXI_GPIO_Init(&GpioInstance);
    if (Status != XST_SUCCESS) {
        xil_printf("AXI GPIO 0 initialization failed\n");
        return XST_FAILURE;
    }

    xil_printf("Initializing AXI GPIO 1...\n");
    Status = AXI_GPIO_1_Init(&GpioInstance1);
    if (Status != XST_SUCCESS) {
        xil_printf("AXI GPIO 1 initialization failed\n");
        return XST_FAILURE;
    }

    xil_printf("Initializing AXI GPIO 2...\n");
    Status = AXI_GPIO_2_Init(&GpioInstance2);
    if (Status != XST_SUCCESS) {
        xil_printf("AXI GPIO 2 initialization failed\n");
        return XST_FAILURE;
    }

    xil_printf("Initializing AXI Timer...\n");
    Status = AXI_Timer_Init(&TimerInstance);
    if (Status != XST_SUCCESS) {
        xil_printf("AXI Timer initialization failed\n");
        return XST_FAILURE;
    }

    xil_printf("Initializing AXI Timebase Watchdog Timer...\n");
    Status = AXI_Timebase_WDT_Init(&WdtInstance);
    if (Status != XST_SUCCESS) {
        xil_printf("AXI Timebase Watchdog Timer initialization failed\n");
        return XST_FAILURE;
    }

    xil_printf("Setting up interrupts...\n");
    Status = SetupInterruptSystem(&InterruptController, &TimerInstance, &WdtInstance);
    if (Status != XST_SUCCESS) {
        xil_printf("Interrupt setup failed\n");
        return XST_FAILURE;
    }

    AXI_Timer_Start(&TimerInstance);
    AXI_Timebase_WDT_Start(&WdtInstance);

    while (1) {
        // Check the status of the switch
        u32 switchStatus = AXI_GPIO_2_Read(&GpioInstance2);

        if (switchStatus & 0x01) {  // Check if the switch is on
            XGpio_DiscreteWrite(&GpioInstance2, 2, 1); // Freeze the watchdog timer
        } else {
            XGpio_DiscreteWrite(&GpioInstance2, 2, 0); // Unfreeze the watchdog timer
        }

        start_traffic_gen();
        transfer_data(&AxiDmaInstance, buffer);
        wait_for_button_press();
    }

    return XST_SUCCESS;
}
