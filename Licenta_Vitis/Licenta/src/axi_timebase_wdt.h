#ifndef AXI_TIMEBASE_WDT_H
#define AXI_TIMEBASE_WDT_H

#include "xparameters.h"
#include "xil_types.h"
#include "xstatus.h"
#include "xwdttb.h" // Include the watchdog timer header

#define AXI_TIMEBASE_WDT_DEVICE_ID XPAR_AXI_TIMEBASE_WDT_0_DEVICE_ID

// Function prototypes
int AXI_Timebase_WDT_Init(XWdtTb *InstancePtr);
void AXI_Timebase_WDT_Start(XWdtTb *InstancePtr);
void AXI_Timebase_WDT_Stop(XWdtTb *InstancePtr);
void AXI_Timebase_WDT_Restart(XWdtTb *InstancePtr);

#endif // AXI_TIMEBASE_WDT_H
