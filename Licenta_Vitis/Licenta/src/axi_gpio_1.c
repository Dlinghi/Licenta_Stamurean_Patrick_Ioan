#include "axi_gpio_1.h"

int AXI_GPIO_1_Init(XGpio *GpioInstancePtr) {
    int Status;

    Status = XGpio_Initialize(GpioInstancePtr, AXI_GPIO_1_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // Set GPIO channel 1 direction to output for LEDs
    XGpio_SetDataDirection(GpioInstancePtr, 1, 0x0);

    return XST_SUCCESS;
}

void AXI_GPIO_1_Write(XGpio *GpioInstancePtr, u32 Value) {
    XGpio_DiscreteWrite(GpioInstancePtr, 1, Value);
}
