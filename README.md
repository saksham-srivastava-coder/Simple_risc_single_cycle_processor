# Simple_risc_single_cycle_processor

## Project Overview
This repository contains the Register Transfer Level (RTL) implementation of a synthesizable, non-pipelined RISC processor. The project focuses on the structural design and integration of core functional units, demonstrating a complete execution datapath from instruction fetch to memory write-back within a single clock cycle.
## Architecture and Module Breakdown
The processor is organized into distinct sub-systems, each implemented as a modular Verilog component:

### Instruction and Control Logic
* **ProgramCounter.v**: Manages instruction address sequencing and program flow.
* **InstructionDecoder.v**: Responsible for parsing machine code into register addresses and immediate values.
* **ControlUnit.v**: The central logic hub that generates steering signals (e.g., RegWrite, ALUSrc) to coordinate the datapath.

### Execution and Arithmetic
* **ALU.v**: Implements the arithmetic and logical core, supporting operations such as addition, subtraction, and bitwise logic.
* **BranchUnit.v / Branch.v**: Processes conditional and unconditional jump logic based on ALU status flags.

### Memory and Data Handling
* **RegisterFile.v**: A dual-port register bank enabling simultaneous operand reads for the execution stage.
* **DataMemory.v / MemoryUnit.v**: Handles the interface for load and store operations between the CPU and memory modules.
* **MuxMem.v**: Facilitates data routing between memory stages and functional units.

### System Integration
* **TopModule.v**: The top-level wrapper that integrates all sub-modules into a unified processor core.
* **TestBench.v**: Provides a comprehensive simulation environment to verify instruction set functionality and datapath timing.

## Design and Verification Flow
* **RTL Coding**: Developed using synthesizable Verilog HDL, adhering to logic design principles for SoC integration.
* **Functional Simulation**: All instructions were verified for logical correctness using testbench-driven simulation environments.
* **Waveform Analysis**: Validated signal propagation and critical path timing through Vivado, ensuring the design meets functional requirements before physical synthesis.

---
[cite_start]*This project aligns with the core responsibilities of a Hardware Engineer in SoC/IP development, including research, logic design, and RTL verification[cite: 1, 2, 4].*
