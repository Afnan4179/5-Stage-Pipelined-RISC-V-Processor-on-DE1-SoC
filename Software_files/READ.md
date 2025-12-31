# 📂 Software Files (RTL Design)

This folder contains the SystemVerilog source code for the **32-bit RISC-V (RV32I)** pipelined core.

## 🏗️ Core Architecture
The design utilizes a **5-stage pipeline** (Fetch, Decode, Execute, Memory, Writeback) to improve instruction throughput.

### 🧩 Logic Modules
* **`Control_Unit.sv`**: Decodes instructions and generates control signals.
* **`alu_logic.sv`**: Performs arithmetic and logical operations.
* **`Barrel_Shifter.sv`**: Handles high-speed SLL, SRL, and SRA shifts.
* **`Reg_file.sv`**: 32-bit register file (x0-x31).
* **`imm_gen.sv`**: Extracts immediate values from instructions.

### ⚠️ Hazard Management
* **`fwd_logic.sv`**: Resolves Data Hazards by forwarding results directly to the ALU.
* **`hazard_detection.sv`**: Manages Load-Use hazards and branch flushes by inserting "stalls".
* **`pipe_reg.sv`**: Registers that isolate each of the 5 pipeline stages.



## 🛠️ Verification
Logic was verified via **EPWave simulation**, confirming correct execution of the Fibonacci algorithm and proper handling of pipeline bubbles.
