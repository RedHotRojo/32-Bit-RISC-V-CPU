module datapath
(input reset,
input clock,
input [31:0] InstrF,
input [31:0] ReadData,
input [2:0] ImmSrcD,
input readsRs1D,
input readsRs2D,
input [4:0] rs1D,
input [4:0] rs2D,
input [4:0] rdE,
input [4:0] rs1E,
input [4:0] rs2E,
input PC_Target_SrcE,
input PC_SrcE,
input ALUSrcAE,
input ALUSrcBE,
input [3:0] ALUControlE,
input isLoadE,
input [1:0] ResultSrcE,
input RegWriteM,
input [2:0] LoadTypeM,
input [1:0] StoreTypeM,
input [4:0] rdM,
input [1:0] ResultSrcW,
input RegWriteW,
input [4:0] rdW,

output [9:0] Addr,
output [31:0] WriteData,
output [31:0] InstrD,
output [31:0] InstrE,
output [31:0] InstrM,
output [31:0] InstrW,
output [31:0] PCF,
output [3:0] flags
);

  wire [31:0] PC_NextF;
  wire [31:0] PC_D;
  wire [31:0] PCD;
  wire [31:0] PC_NextD;
  wire [31:0] PC_NextE;
  wire [31:0] PC_NextM;
  wire [31:0] PC_NextW;
  wire [31:0] PCE;
  wire [31:0] PC_TargetE;
  wire [31:0] PC_TargetM;
  wire [31:0] PC_TargetW;
  wire [31:0] PC_Target_SumE;
  wire [31:0] ImmExtD;
  wire [31:0] rd1D;
  wire [31:0] rd2D;
  wire [31:0] rd1E;
  wire [31:0] rd2E;
  wire [31:0] ALU_AE;
  wire [31:0] ALU_BE;
  wire [31:0] ALU_ResultE;
  wire [31:0] ImmExtE;
  wire [31:0] ResultE;
  wire [31:0] SrcAE;
  wire [31:0] WriteDataE;
  wire [31:0] WriteDataM;
  wire [31:0] ResultM;
  wire [31:0] ReadDataOutM;
  wire [31:0] ReadDataOutW;
  wire [31:0] ResultW;
  wire [31:0] Result;
  wire [3:0] flagsE;
  wire [1:0] ForwardAE;
  wire [1:0] ForwardBE;
  wire stallF;
  wire stallD;
  wire FlushD;
  wire FlushE;

  assign Addr = ResultM[11:2];

  mux2 Next_PC_Mux
    (
    .d0(PC_NextF),
    .d1(PC_TargetE),
    .sel(PC_SrcE),
    .y(PC_D));
  defparam Next_PC_Mux.WIDTH = 32;

  register_n PC_register
    (
    .reset(reset),
    .clock(clock),
    .enable(~stallF),
    .D(PC_D),
    .Q(PCF));
  defparam PC_register.WIDTH = 32;

  adder PC_Increment_Adder
    (
    .A(PCF),
    .B(4),
    .sum(PC_NextF));

  pipeline_register_FD Fetch_Decode_Register
    (
    .clock(clock),
    .reset(reset),
    .InstrF(InstrF),
    .PCF(PCF),
    .PC_NextF(PC_NextF),
    .nStallD(~stallD),
    .FlushD(FlushD),
    .InstrD(InstrD),
    .PCD(PCD),
    .PC_NextD(PC_NextD));

  register_file	RegisterFile
    (
    .a1(rs1D),
    .a2(rs2D),
    .a3(rdW),
    .wd3(Result),
    .reset(reset),
    .clock(~clock),
    .we3(RegWriteW),
    .rd1(rd1D),
    .rd2(rd2D));

  extend_immediate	ExtendImmediate
    (
    .immSrc(ImmSrcD),
    .instr(InstrD),
    .immExt(ImmExtD));

  pipeline_register_DE Decode_Execute_Register
    (
    .clock(clock),
    .reset(reset),
    .rd1D(rd1D),
    .rd2D(rd2D),
    .PCD(PCD),
    .ImmExtD(ImmExtD),
    .PC_NextD(PC_NextD),
    .InstrD(InstrD),
    .FlushE(FlushE),
    .rd1E(rd1E),
    .rd2E(rd2E),
    .PCE(PCE),
    .ImmExtE(ImmExtE),
    .PC_NextE(PC_NextE),
    .InstrE(InstrE));

  // Pipelined Execute

  register_forward RegisterForward
    (
    .rs1E(rs1E),
    .rs2E(rs2E),
    .rdM(rdM),
    .rdW(rdW),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
    );

  mux3 ForwardA_Mux
    (
    .d0(rd1E),
    .d1(Result),
    .d2(ResultM),
    .sel(ForwardAE),
    .y(SrcAE));
  defparam ForwardA_Mux.WIDTH = 32;

  mux3 ForwardB_Mux
    (
    .d0(rd2E),
    .d1(Result),
    .d2(ResultM),
    .sel(ForwardBE),
    .y(WriteDataE));
  defparam ForwardB_Mux.WIDTH = 32;

  mux2 ALUSrcA_Mux
    (
    .d0(SrcAE),
    .d1(0),
    .sel(ALUSrcAE),
    .y(ALU_AE));
  defparam ALUSrcA_Mux.WIDTH = 32;

  mux2 ALUSrcB_Mux
    (
    .d0(WriteDataE),
    .d1(ImmExtE),
    .sel(ALUSrcBE),
    .y(ALU_BE));
  defparam ALUSrcB_Mux.WIDTH = 32;

  alu ALU
    (
    .A(ALU_AE),
    .B(ALU_BE),
    .ALUcontrol(ALUControlE),
    .flags(flags),
    .result(ALU_ResultE));

  mux4 Result_Mux
    (
    .d0(ALU_ResultE),
    .d1(ALU_ResultE),
    .d2(ALU_ResultE),
    .d3(PC_TargetE),
    .sel(ResultSrcE),
    .y(ResultE));
  defparam Result_Mux.WIDTH = 32;

  adder PC_Target_Adder
    (
    .A(PCE),
    .B(ImmExtE),
    .sum(PC_Target_SumE));

  mux2 PC_Target_Mux
    (
    .d0(PC_Target_SumE),
    .d1(ResultE),
    .sel(PC_Target_SrcE),
    .y(PC_TargetE));
  defparam PC_Target_Mux.WIDTH = 32;

  pipeline_register_EM Execute_Memory_Register
    (
    .clock(clock),
    .reset(reset),
    .WriteDataE(WriteDataE),
    .ResultE(ResultE),
    .PC_TargetE(PC_TargetE),
    .PC_NextE(PC_NextE),
    .InstrE(InstrE),
    .WriteDataM(WriteDataM),
    .ResultM(ResultM),
    .PC_TargetM(PC_TargetM),
    .PC_NextM(PC_NextM),
    .InstrM(InstrM));

  // Pipelined Memory

  LoadData b2v_load_data_0
    (
    .LoadType(LoadTypeM),
    .Addr(ResultM),
    .ReadData(ReadData),
    .ReadDataOut(ReadDataOutM));

  StoreData b2v_store_data_0
    (
    .StoreType(StoreTypeM),
    .Addr(ResultM),
    .rd2(WriteDataM),
    .ReadData(ReadData),
    .WriteDataOut(WriteData)
    );

  pipeline_register_MW Memory_Writeback_Register
    (
    .clock(clock),
    .reset(reset),
    .ReadDataOutM(ReadDataOutM),
    .ResultM(ResultM),
    .PC_TargetM(PC_TargetM),
    .PC_NextM(PC_NextM),
    .InstrM(InstrM),
    .ReadDataOutW(ReadDataOutW),
    .ResultW(ResultW),
    .PC_TargetW(PC_TargetW),
    .PC_NextW(PC_NextW),
    .InstrW(InstrW));

  mux4 Result_WB_Mux
    (
    .d0(ResultW),
    .d1(ReadDataOutW),
    .d2(PC_NextW),
    .d3(PC_TargetW),
    .sel(ResultSrcW),
    .y(Result));
  defparam Result_WB_Mux.WIDTH = 32;

  // Hazards

  hazard HazardUnit
    (
    .rs1D(rs1D),
    .rs2D(rs2D),
    .rdE(rdE),
    .PC_SrcE(PC_SrcE),
    .readsRs1D(readsRs1D),
    .readsRs2D(readsRs2D),
    .isLoadE(isLoadE),
    .stallF(stallF),
    .stallD(stallD),
    .flushD(FlushD),
    .flushE(FlushE));
    
endmodule
