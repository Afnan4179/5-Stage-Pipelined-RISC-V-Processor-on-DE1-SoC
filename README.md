# 5-Stage-Pipelined-RISC-V-Processor-on-DE1-SoC
This repository contains the design, implementation, and hardware verification of a 32-bit RISC-V (RV32I) processor. The project features a full 5-stage pipeline with integrated Forwarding and Hazard Detection units to optimize performance and ensure data integrity.

## Project Overview
The core objective was to move beyond simulation and deploy a functional RISC-V core on physical silicon. The processor executes a Fibonacci Sequence algorithm, visualizing results in real-time on the FPGA hardware.

## Key Features
Architecture: RISC-V RV32I Base Integer Instruction Set.

Pipeline Stages: Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), and Writeback (WB).

Hazard Management: * Forwarding Unit: Resolves data hazards by bypassing the Register File.

Hazard Detection Unit: Manages Load-Use hazards and Branch mispredictions via pipeline stalls (bubbles).

Hardware Platform: Terasic DE1-SoC (Cyclone V FPGA).

I/O Visualization: * LEDs: Display current Fibonacci values in Binary.

7-Segment Displays (HEX): Display Fibonacci values in Hexadecimal for readability.

## Repository Structure
💻 Software Files (RTL Design)
Control_Unit_New.sv: Centralized control logic for instruction decoding.

alu_logic.sv: Arithmetic and Logical Unit supporting integer operations.

Barrel_Shifter.sv: High-efficiency shifter for SLL, SRL, and SRA instructions.

Reg_file.sv & imm_gen.sv: Register management and immediate value extraction.

pipe_reg.sv: Pipeline registers that separate the 5 execution stages.

fwd_logic.sv & hazard_detection.sv: Logic to handle pipeline data/control conflicts.

## Hardware Implementation Files
DE1_SoC_TOP.sv: The top-level wrapper module that interfaces the RISC-V core with the FPGA's physical pins.

SevenSeg.sv: Decoder module to drive the 7-segment displays.

Clock Management: Includes a clock divider to step down the 50MHz onboard oscillator to a human-viewable frequency (~1.5Hz).

Pin Assignments: Configuration files for mapping the RTL ports to Cyclone V PIN_ locations.

## Verification & Results
Software Simulation (Waveforms)
The included screenshots show the ALU_Out signal successfully calculating the Fibonacci sequence.

Hex Values Observed: d (13), 15 (21), 22 (34), 37 (55), etc.

Analysis: The waveform captures intermediate 0 values, which correctly represent "bubbles" inserted by the Hazard Detection Unit to maintain pipeline synchronization.

## Hardware Demo
The demo_video.mp4 shows the physical DE1-SoC board running the program.

Reset: Pressing KEY[0] resets the sequence.

Execution: The Red LEDs and HEX displays increment through the Fibonacci sequence automatically.

## Challenges Overcome
Combinational Loops & Latches: Resolved always_comb errors by ensuring all signals had default assignments, preventing unintended hardware latches.

Timing & Synchronization: Implemented a clock divider to interface the high-speed FPGA fabric with visual I/O components.

Hardware Mapping: Corrected hierarchy elaboration errors and pin-assignment warnings to ensure successful synthesis in Intel Quartus Prime.
