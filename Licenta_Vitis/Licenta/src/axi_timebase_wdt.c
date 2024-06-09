#include "axi_timebase_wdt.h"
#include "xwdttb.h" // Include the watchdog timer header

int AXI_Timebase_WDT_Init(XWdtTb *InstancePtr) {
    int Status;

    Status = XWdtTb_Initialize(InstancePtr, AXI_TIMEBASE_WDT_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    XWdtTb_Start(InstancePtr);

    return XST_SUCCESS;
}

void AXI_Timebase_WDT_Start(XWdtTb *InstancePtr) {
    XWdtTb_Start(InstancePtr);
}

void AXI_Timebase_WDT_Stop(XWdtTb *InstancePtr) {
    XWdtTb_Stop(InstancePtr);
}

void AXI_Timebase_WDT_Restart(XWdtTb *InstancePtr) {
    XWdtTb_RestartWdt(InstancePtr);
}
