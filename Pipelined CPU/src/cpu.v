module cpu
	(input reset, 
	input clock,
	input [31:0] Instr,
	input [31:0] ReadData,
	output [9:0] Addr,
	output [31:0] WriteData,
	output MemWrite,
	output [31:0] PC);

	wire [31:0] InstrM;
	wire [31:0] InstrE;
	wire [31:0] InstrD;
	wire [31:0] InstrW;
	wire [2:0] ImmSrcD;
	wire readsRs1D;
	wire readsRs2D;
	wire [4:0] rs1D;
	wire [4:0] rs2D;
	wire [4:0] rdE;
	wire [2:0] funct3E;
	wire [4:0] rs1E;
	wire [4:0] rs2E;
	wire JumpE;
	wire BranchE;
	wire PC_Target_SrcE;
	wire ALUSrcAE;
	wire ALUSrcBE;
	wire [3:0] ALUControlE;
	wire isLoadE;
	wire [1:0] ResultSrcE;
	wire RegWriteM;
	wire [2:0] LoadTypeM;
	wire [1:0] StoreTypeM;
	wire [4:0] rdM;
	wire [1:0] ResultSrcW;
	wire RegWriteW;
	wire [4:0] rdW;
	wire PC_SrcE;
	wire BranchTaken;
	wire [3:0] flags;

	pipeline_control Pipeline_Control_Unit (
	.InstrD(InstrD),
	.InstrE(InstrE),
	.InstrM(InstrM),
	.InstrW(InstrW),
	.ImmSrcD(ImmSrcD),
	.readsRs1D(readsRs1D),
	.readsRs2D(readsRs2D),
	.rs1D(rs1D),
	.rs2D(rs2D),
	.rdE(rdE),
	.funct3E(funct3E),
	.rs1E(rs1E),
	.rs2E(rs2E),
	.JumpE(JumpE),
	.BranchE(BranchE),
	.PC_Target_SrcE(PC_Target_SrcE),
	.ALUSrcAE(ALUSrcAE),
	.ALUSrcBE(ALUSrcBE),
	.ALUControlE(ALUControlE),
	.isLoadE(isLoadE),
	.ResultSrcE(ResultSrcE),
	.RegWriteM(RegWriteM),
	.MemWrite(MemWrite),
	.LoadTypeM(LoadTypeM),
	.StoreTypeM(StoreTypeM),
	.rdM(rdM),
	.ResultSrcW(ResultSrcW),
	.RegWriteW(RegWriteW),
	.rdW(rdW));

   datapath	b2v_datapath_0(
	.reset(reset),
	.clock(clock),
	.InstrF(Instr),
	.ReadData(ReadData),
	.ImmSrcD(ImmSrcD),
	.readsRs1D(readsRs1D),
	.readsRs2D(readsRs2D),
	.rs1D(rs1D),
	.rs2D(rs2D),
	.rdE(rdE),
	.rs1E(rs1E),
	.rs2E(rs2E),
	.PC_Target_SrcE(PC_Target_SrcE),
	.PC_SrcE(PC_SrcE),
	.ALUSrcAE(ALUSrcAE),
	.ALUSrcBE(ALUSrcBE),
	.ALUControlE(ALUControlE),
	.isLoadE(isLoadE),
	.ResultSrcE(ResultSrcE),
	.RegWriteM(RegWriteM),
	.LoadTypeM(LoadTypeM),
	.StoreTypeM(StoreTypeM),
	.rdM(rdM),
	.ResultSrcW(ResultSrcW),
	.RegWriteW(RegWriteW),
	.rdW(rdW),

	.Addr(Addr),
	.WriteData(WriteData),
	.InstrD(InstrD),
	.InstrE(InstrE),
	.InstrM(InstrM),
	.InstrW(InstrW),
	.PCF(PC),
	.flags(flags));

   branch_unit	b2v_branch_unit_0
     (
      .branch(BranchE),
      .flags(flags),
      .funct3(funct3E),
      .taken(BranchTaken));
   
   assign PC_SrcE = BranchTaken | JumpE;

endmodule
