#ifndef AXI_GPIO_1_H
#define AXI_GPIO_1_H

#include "xparameters.h"
#include "xgpio.h"
#include "xil_types.h"
#include "xstatus.h"

#define AXI_GPIO_1_DEVICE_ID XPAR_AXI_GPIO_1_DEVICE_ID

// Function prototypes
int AXI_GPIO_1_Init(XGpio *GpioInstancePtr);
void AXI_GPIO_1_Write(XGpio *GpioInstancePtr, u32 Value);

#endif // AXI_GPIO_1_H
