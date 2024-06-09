#ifndef AXI_GPIO_2_H
#define AXI_GPIO_2_H

#include "xparameters.h"
#include "xgpio.h"
#include "xil_types.h"
#include "xstatus.h"

#define AXI_GPIO_2_DEVICE_ID XPAR_AXI_GPIO_2_DEVICE_ID

// Function prototypes
int AXI_GPIO_2_Init(XGpio *GpioInstancePtr);
u32 AXI_GPIO_2_Read(XGpio *GpioInstancePtr);

#endif // AXI_GPIO_2_H
