module pipeline_control (
    input [31:0] InstrD,
    input [31:0] InstrE,
    input [31:0] InstrM,
    input [31:0] InstrW,
    output [2:0] ImmSrcD,
    output readsRs1D,
    output readsRs2D,
    output [4:0] rs1D,
    output [4:0] rs2D,
    output [4:0] rdE,
    output [2:0] funct3E,
    output [4:0] rs1E,
    output [4:0] rs2E,
    output JumpE,
    output BranchE,
    output PC_Target_SrcE,
    output ALUSrcAE,
    output ALUSrcBE,
    output [3:0] ALUControlE,
    output isLoadE,
    output [1:0] ResultSrcE,
    output RegWriteM,
    output MemWrite,
    output [2:0] LoadTypeM,
    output [1:0] StoreTypeM,
    output [4:0] rdM,
    output [1:0] ResultSrcW,
    output RegWriteW,
    output [4:0] rdW
);
    
   assign rs1D = InstrD[19:15];
   assign rs2D = InstrD[24:20];
   assign funct3E = InstrE[14:12];
   assign rs1E = InstrE[19:15];
   assign rs2E = InstrE[24:20];
	assign rdE = InstrE[11:7];
	assign rdM = InstrM[11:7];
	assign rdW = InstrW[11:7];

   controller ControllerD(
	.op(InstrD[6:0]),
	.funct3(InstrD[14:12]),
	.funct7b5(InstrD[30]),
	.ImmSrc(ImmSrcD),
	.readsRs1(readsRs1D),
	.readsRs2(readsRs2D));

   controller ControllerE(
	.op(InstrE[6:0]),
	.funct3(funct3E),
	.funct7b5(InstrE[30]),
	.Jump(JumpE),
	.Branch(BranchE),
	.PC_Target_Src(PC_Target_SrcE),
	.ALUSrcA(ALUSrcAE),
	.ALUSrcB(ALUSrcBE),
	.ResultSrc(ResultSrcE),
	.ALUControl(ALUControlE),
	.isLoad(isLoadE));

   controller ControllerM(
	.op(InstrM[6:0]),
	.funct3(InstrM[14:12]),
	.funct7b5(InstrM[30]),
	.RegWrite(RegWriteM),
	.MemWrite(MemWrite),
	.LoadType(LoadTypeM),
	.StoreType(StoreTypeM));

   controller ControllerW(
	.op(InstrW[6:0]),
	.funct3(InstrW[14:12]),
	.funct7b5(InstrW[30]),
	.ResultSrc(ResultSrcW),
	.RegWrite(RegWriteW));
endmodule