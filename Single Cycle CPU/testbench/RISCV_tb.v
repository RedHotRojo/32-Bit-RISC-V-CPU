`timescale 1ns / 1ns

module testbench;

   wire clock;
   wire reset;
   wire [31:0] PC;
   wire [31:0] Instr;
   wire [31:0] ReadData;
   wire [31:0] WriteData;
   wire [11:0] Addr;
   wire MemWrite;
   
   reset_clock	b2v_reset_clock_0(
	.reset(reset),
	.clock(clock));

   cpu	b2v_RISCV(
	.reset(reset),
	.clock(clock),
   .Instr(Instr),
   .ReadData(ReadData),
   .WriteData(WriteData),
   .MemWrite(MemWrite),
   .PC(PC),
   .Addr(Addr));

  RAM_memory b2v_RAM_0
    (
      .Addr(Addr),
      .WD(WriteData),
      .WE(MemWrite),
      .clock(clock),
      .RD(ReadData));

   ROM_memory	b2v_ROM_0
    (
    .Addr(PC[12:0]),
    .RD(Instr));
    defparam	b2v_ROM_0.filename = "riscv_asm.txt";

endmodule
