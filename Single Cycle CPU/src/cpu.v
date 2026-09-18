module cpu
	(input reset, 
	input clock,
	input [31:0] Instr,
	input [31:0] ReadData,
	output [11:0] Addr,
	output [31:0] WriteData,
	output MemWrite,
	output [31:0] PC);

	wire [3:0] ALUControl;
	wire ALUSrcA;
	wire ALUSrcB;
	wire [3:0] flags;
	wire [2:0] funct3;
	wire funct7b5;
	wire [2:0] ImmSrc;
	wire [6:0] op;
	wire RegWrite;
	wire PC_Src;
	wire PC_Target_Src;
	wire Branch;
	wire BranchTaken;
	wire Jump;
	wire [1:0] ResultSrc;
	wire [2:0] LoadType;
	wire [1:0] StoreType;

   controller	b2v_controller_0(
	.op(op),
	.funct3(funct3),
	.funct7b5(funct7b5),
	.flags(flags),
	.ImmSrc(ImmSrc),
	.Jump(Jump),
	.Branch(Branch),
	.PC_Target_Src(PC_Target_Src),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.ResultSrc(ResultSrc),
	.ALUControl(ALUControl),
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
	.ALUControl(ALUControl),
   	.Instr(Instr),
	.RegWrite(RegWrite),
	.LoadType(LoadType),
	.StoreType(StoreType),
	.PC_Src(PC_Src),
	.PC_Target_Src(PC_Target_Src),
	.op(op),
	.funct3(funct3),
	.funct7b5(funct7b5),
	.flags(flags),
   	.ReadData(ReadData),
  	.WriteData(WriteData),
	.PC(PC),
   .Addr(Addr));

   branch_unit	b2v_branch_unit_0
     (
      .branch(Branch),
      .flags(flags),
      .funct3(funct3),
      .taken(BranchTaken));
   
   assign PC_Src = BranchTaken | Jump;

endmodule
