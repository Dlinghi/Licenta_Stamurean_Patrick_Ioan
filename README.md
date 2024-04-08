# Project Overview
This project involves the development of a streaming processing system using the **AMD ZYNQ 7000 platform**, incorporating both **FPGA** and **ARM dual-core processor** components. The system leverages **AXI Stream Interfaces** for data streaming and includes **DMA** for efficient data transfer.

## Core Integration Functionality (FPGA)
**IP Components:** ZYNQ Processing System, AXI Traffic Generator, AXI SmarConnect, BRAM, FIFO, GPIO (for soft reset and hold), AXI Timer, AXI Timebase Watchdog Timer, AXI Interconnect, AXI Direct Memory Access.

**Hold, Soft Reset:** Enables pausing operation and resetting the system without hardware reset.

**Timestamp:** Adds time stamps to processed data for tracking and latency measurement.

**Watchdog Timer:** Monitors system for malfunctions and initiates a recovery sequence if necessary.

**AXI Lite Programming:** Facilitates communication with peripheral devices using a simplified version of the AXI protocol.

**Optional Integration Glue Logic:** Includes input **FIFO**, output **FIFO**, and a bypass or software-computed output for flexible system configuration.

**Interrupt Support:** Allows the system to respond to important events in a timely manner.
Embedded Software (ARM Dual Core Processor)

**C Model Processing:** Computes the processing logic for streaming building blocks.

**Multithreading:** Enhances performance by allowing multiple threads of execution to take place concurrently.

**Interrupt Support:** Facilitates responsive system behavior by handling interrupt requests efficiently.

**DMA Configuration Input Stream / Output Stream:** Manages data streaming into and out of the system, ensuring smooth data flow.

## Development Tools
**Vivado:** Utilized for designing, synthesizing, and implementing the hardware architecture.

**Vitis:** Software development platform created by Xilinx, designed to enable the development of embedded software and accelerated applications
