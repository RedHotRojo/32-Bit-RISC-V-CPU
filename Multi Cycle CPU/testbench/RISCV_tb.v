`timescale 1ns / 1ns

module testbench;

   wire	[31:0] Addr;
   wire        clock;
   wire        MemWrite;
   wire        RAM_CS;
   wire        RAM_WE;
   wire [31:0] ReadData;
   wire        reset;
   wire        ROM_CS;
   wire [31:0] WriteData;

   reset_clock	b2v_reset_clock_0(
	.reset(reset),
	.clock(clock));

   cpu	b2v_RISCV(
	.reset(reset),
	.clock(clock),
	.ReadData(ReadData),
	.MemWrite(MemWrite),
	.Addr(Addr),
	.WriteData(WriteData));

   address_decoder	b2v_address_decoder_0(
	.MemWrite(MemWrite),
	.Addr(Addr),
	.RAM_CS(RAM_CS),
	.RAM_WE(RAM_WE),
	.ROM_CS(ROM_CS));

   ROM_memory	b2v_ROM_0(
	.CS(ROM_CS),
	.Addr(Addr[12:0]),
	.RD(ReadData));
	defparam	b2v_ROM_0.filename = "riscv_asm.txt";

   RAM_memory	b2v_RAM_0(
	.clock(clock),
	.CS(RAM_CS),
	.WE(RAM_WE),
	.Addr(Addr[11:0]),
	.WD(WriteData),
	.RD(ReadData));


endmodule
