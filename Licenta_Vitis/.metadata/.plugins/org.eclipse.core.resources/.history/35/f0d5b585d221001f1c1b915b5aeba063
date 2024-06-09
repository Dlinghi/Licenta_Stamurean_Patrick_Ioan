#ifndef AXI_TIMER_H
#define AXI_TIMER_H

#include "xparameters.h"
#include "xil_types.h"
#include "xstatus.h"
#include "xtmrctr.h"

#define AXI_TIMER_DEVICE_ID XPAR_AXI_TIMER_0_DEVICE_ID
#define TIMER_INTERRUPT_ID XPAR_FABRIC_AXI_TIMER_0_INTERRUPT_INTR

// Function prototypes
int AXI_Timer_Init(XTmrCtr *TimerInstancePtr);
void AXI_Timer_Start(XTmrCtr *TimerInstancePtr);
void AXI_Timer_Stop(XTmrCtr *TimerInstancePtr);
void AXI_Timer_Intr_Handler(void *CallBackRef);

#endif // AXI_TIMER_H
