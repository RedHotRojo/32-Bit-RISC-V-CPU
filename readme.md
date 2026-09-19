# 32-Bit RISC-V CPU Design

This was a semester long project for ECE 4435: Computer Architecture and Design.

## Overview

Over the course of a semester, I designed a 32-Bit CPU with a RISC-V architecture. The CPU was designed in Verilog, synthesized in Intel Quartus II, and tested in ModelSim Altera.
- The first half of the semester was spent designing the components necessary for a multi-cycle design
- Then, we combined the components to design a multi-cycle RISC-V processor
- Next, we spent a few weeks designing a single-cycle processor
- Finally, we designed a pipelined processor for our final project

## Testing
- To test a processor, a testbench connected the processor to simulated RAM and ROM modules
- The ROM contained the RISC-V instructions 
- The RISC-V instructions were generated from Assembly programs
- Each Assembly program was tested in [RARS](https://github.com/TheThirdOne/rars) to verify its functionality
- The register and RAM outputs from ModelSim were compared to the outputs from RARS
- Equal values for each output verified that the designed processor worked as intended

## Notes
- Each folder contains a verification document. I made minor adjustments to some documents, but preserved the original documentation to show my improvement over the semester.
- Each folder can be opened in Intel Quartus II Lite, version 20.1. I have not verified each project's functionality in other versions or software.
- The `testbench/*.s` file contains the assembly program. The `simulation/modelsim/riscv_asm.txt` file contains the compiled program.
- The `src` folder contains all the Verilog modules required to synthesize the CPU
- To test the processor, you can open the project in Quartus, synthesize the design, start an RTL Simulation, and run the command `do testbench.do` in ModelSim
