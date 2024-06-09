#ifndef AXI_TRAFFIC_GEN_H
#define AXI_TRAFFIC_GEN_H

#include "xparameters.h"
#include "xil_types.h"
#include "xstatus.h"

#define AXI_TRAFFIC_GEN_BASEADDR 0x43C00000

// Function prototypes
void AXI_TrafficGen_Start(u32 baseaddr);
void AXI_TrafficGen_Stop(u32 baseaddr);
void AXI_TrafficGen_SetPattern(u32 baseaddr, u32 pattern);
void AXI_TrafficGen_Reset(u32 baseaddr);

#endif // AXI_TRAFFIC_GEN_H
