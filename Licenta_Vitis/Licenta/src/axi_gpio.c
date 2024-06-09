#include "axi_gpio.h"

int AXI_GPIO_Init(XGpio *GpioInstancePtr) {
    int Status;

    Status = XGpio_Initialize(GpioInstancePtr, AXI_GPIO_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // Set the direction for all signals to be inputs
    XGpio_SetDataDirection(GpioInstancePtr, 1, 0xFFFFFFFF);
    XGpio_SetDataDirection(GpioInstancePtr, 2, 0xFFFFFFFF);

    return XST_SUCCESS;
}

u32 AXI_GPIO_Read(XGpio *GpioInstancePtr) {
    return XGpio_DiscreteRead(GpioInstancePtr, 1);
}
