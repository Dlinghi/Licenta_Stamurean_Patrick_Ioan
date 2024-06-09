#include "axi_gpio_2.h"

int AXI_GPIO_2_Init(XGpio *GpioInstancePtr) {
    int Status;

    Status = XGpio_Initialize(GpioInstancePtr, AXI_GPIO_2_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // Set the direction for channel 1 to input for switches
    XGpio_SetDataDirection(GpioInstancePtr, 1, 0xFF);  // 8 switches

    // Set the direction for channel 2 to output for freeze control
    XGpio_SetDataDirection(GpioInstancePtr, 2, 0x0);  // 1 output for freeze

    return XST_SUCCESS;
}

u32 AXI_GPIO_2_Read(XGpio *GpioInstancePtr) {
    return XGpio_DiscreteRead(GpioInstancePtr, 1);
}
