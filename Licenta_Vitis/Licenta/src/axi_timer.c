#include "axi_timer.h"
#include "xil_exception.h"
#include "xtmrctr_l.h" // Include the low-level header for register offsets

int AXI_Timer_Init(XTmrCtr *TimerInstancePtr) {
    int Status;

    Status = XTmrCtr_Initialize(TimerInstancePtr, AXI_TIMER_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    XTmrCtr_SetHandler(TimerInstancePtr, AXI_Timer_Intr_Handler, TimerInstancePtr);
    XTmrCtr_SetOptions(TimerInstancePtr, 0, XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION);
    XTmrCtr_SetResetValue(TimerInstancePtr, 0, 0xFFFFFFFF - 100000000);  // Assuming 100 MHz clock, set for 1 second

    return XST_SUCCESS;
}

void AXI_Timer_Start(XTmrCtr *TimerInstancePtr) {
    XTmrCtr_Start(TimerInstancePtr, 0);
}

void AXI_Timer_Stop(XTmrCtr *TimerInstancePtr) {
    XTmrCtr_Stop(TimerInstancePtr, 0);
}

void AXI_Timer_Intr_Handler(void *CallBackRef) {
    XTmrCtr *TimerInstancePtr = (XTmrCtr *)CallBackRef;

    // Clear the interrupt
    XTmrCtr_SetControlStatusReg(TimerInstancePtr->BaseAddress, 0,
        XTmrCtr_GetControlStatusReg(TimerInstancePtr->BaseAddress, 0) | XTC_CSR_INT_OCCURED_MASK);
}
