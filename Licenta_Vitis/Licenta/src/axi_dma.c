#include "axi_dma.h"
#include "xparameters.h"
#include "xil_cache.h"

int AXI_DMA_Init(XAxiDma *AxiDmaInstancePtr) {
    XAxiDma_Config *CfgPtr;
    int Status;

    // Initialize the XAxiDma device.
    CfgPtr = XAxiDma_LookupConfig(XPAR_AXI_DMA_0_DEVICE_ID);
    if (!CfgPtr) {
        return XST_FAILURE;
    }

    Status = XAxiDma_CfgInitialize(AxiDmaInstancePtr, CfgPtr);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // Disable all interrupts.
    XAxiDma_IntrDisable(AxiDmaInstancePtr, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    XAxiDma_IntrDisable(AxiDmaInstancePtr, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

    return XST_SUCCESS;
}

int AXI_DMA_S2MM_Transfer(XAxiDma *AxiDmaInstancePtr, u32 Addr, int Length) {
    int Status;

    // Flush the cache to ensure data coherency
    Xil_DCacheFlushRange(Addr, Length);

    Status = XAxiDma_SimpleTransfer(AxiDmaInstancePtr, Addr, Length, XAXIDMA_DEVICE_TO_DMA);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}

int AXI_DMA_MM2S_Transfer(XAxiDma *AxiDmaInstancePtr, u32 Addr, int Length) {
    int Status;

    // Flush the cache to ensure data coherency
    Xil_DCacheFlushRange(Addr, Length);

    Status = XAxiDma_SimpleTransfer(AxiDmaInstancePtr, Addr, Length, XAXIDMA_DMA_TO_DEVICE);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}
