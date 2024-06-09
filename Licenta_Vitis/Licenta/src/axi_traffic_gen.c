#include "axi_traffic_gen.h"
#include "xil_io.h"

void AXI_TrafficGen_Start(u32 baseaddr) {
    Xil_Out32(baseaddr, 0x1);  // Start the traffic generator
}

void AXI_TrafficGen_Stop(u32 baseaddr) {
    Xil_Out32(baseaddr, 0x0);  // Stop the traffic generator
}

void AXI_TrafficGen_SetPattern(u32 baseaddr, u32 pattern) {
    Xil_Out32(baseaddr + 0x4, pattern);  // Set the pattern for generated traffic
}

void AXI_TrafficGen_Reset(u32 baseaddr) {
    Xil_Out32(baseaddr + 0x8, 0x1);  // Reset the traffic generator
    Xil_Out32(baseaddr + 0x8, 0x0);  // Release reset
}
