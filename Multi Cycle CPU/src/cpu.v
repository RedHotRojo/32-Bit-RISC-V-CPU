module cpu
  (input reset, 
   input clock, 
   input [31:0] ReadData, 
   output MemWrite, 
   output [31:0] Addr, 
   output [31:0] WriteData);

   wire AdrSrc;
   wire [3:0] ALUControl;
   wire [1:0] ALUSrcA;
   wire [1:0] ALUSrcB;
   wire [3:0] flags;
   wire [2:0] funct3;
   wire funct7b5;
   wire [2:0] ImmSrc;
   wire IRWrite;
   wire [6:0] op;
   wire PCWrite;
   wire RegWrite;
   wire [1:0] ResultSrc;
	 wire [2:0] LoadType;
	 wire [1:0] StoreType;

   controller	b2v_controller_0(
	.reset(reset),
	.clock(clock),
	.op(op),
	.funct3(funct3),
	.funct7b5(funct7b5),
	.flags(flags),
	.ImmSrc(ImmSrc),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.ResultSrc(ResultSrc),
	.AdrSrc(AdrSrc),
	.ALUControl(ALUControl),
	.IRWrite(IRWrite),
	.PCWrite(PCWrite),
	.RegWrite(RegWrite),
	.MemWrite(MemWrite),
	.LoadType(LoadType),
	.StoreType(StoreType));

   datapath	b2v_datapath_0(
	.reset(reset),
	.clock(clock),
	.ImmSrc(ImmSrc),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.ResultSrc(ResultSrc),
	.AdrSrc(AdrSrc),
	.ALUControl(ALUControl),
	.IRWrite(IRWrite),
	.PCWrite(PCWrite),
	.ReadData(ReadData),
	.LoadType(LoadType),
	.StoreType(StoreType),
	.op(op),
	.funct3(funct3),
	.funct7b5(funct7b5),
	.flags(flags),
	.Addr(Addr),
	.RegWrite(RegWrite),
	.WriteData(WriteData));

endmodule
