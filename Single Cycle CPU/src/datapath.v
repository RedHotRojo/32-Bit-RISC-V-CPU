module datapath
(input reset,
input clock,
input [31:0] Instr,
input [31:0] ReadData,
input [2:0] ImmSrc,
input ALUSrcA,
input ALUSrcB,
input [1:0] ResultSrc,
input [3:0] ALUControl,
input RegWrite,
input [2:0] LoadType,
input [1:0] StoreType,
input PC_Src,
input PC_Target_Src,
output [11:0] Addr,
output [31:0] WriteData,
output [6:0] op,
output [2:0] funct3,
output funct7b5,
output [3:0] flags,
output [31:0] PC
);

  wire [31:0] PC_Next;
  wire [31:0] PC_Target;
  wire [31:0] PC_D;
  wire [31:0] Result;
  wire [31:0] rd1;
  wire [31:0] rd2;
  wire [31:0] ImmExt;
  wire [31:0] SrcA;
  wire [31:0] SrcB;
  wire [31:0] ALU_Result;
  wire [31:0] PC_Target_Sum;
  wire [31:0] ReadDataOut;

  wire [4:0] rd;
  wire [4:0] rs1;
  wire [4:0] rs2;

  assign Addr = ALU_Result[11:0];

  assign op[6:0] = Instr[6:0];
  assign rd[4:0] = Instr[11:7];
  assign funct3[2:0] = Instr[14:12];
  assign rs1[4:0] = Instr[19:15];
  assign rs2[4:0] = Instr[24:20];
  assign funct7b5 = Instr[30];
  
  mux2	Next_PC_Mux
    (
    .d0(PC_Next),
    .d1(PC_Target),
    .sel(PC_Src),
    .y(PC_D));
  defparam	Next_PC_Mux.WIDTH = 32;

  register_n	PC_register
    (
    .reset(reset),
    .clock(clock),
    .enable(1'b1),
    .D(PC_D),
    .Q(PC));
  defparam	PC_register.WIDTH = 32;

  adder PC_Increment_Adder
    (
    .A(PC),
    .B(4),
    .sum(PC_Next));

  register_file	b2v_rf_0
    (
    .a1(rs1),
    .a2(rs2),
    .a3(rd),
    .wd3(Result),
    .reset(reset),
    .clock(clock),
    .we3(RegWrite),
    .rd1(rd1),
    .rd2(rd2));

  extend_immediate	b2v_extend_0
    (
    .immSrc(ImmSrc),
    .instr(Instr),
    .immExt(ImmExt));

  mux2 ALUSrcA_Mux
    (
    .d0(rd1),
    .d1(32'b0),
    .sel(ALUSrcA),
    .y(SrcA));
  defparam	ALUSrcA_Mux.WIDTH = 32;

  mux2 ALUSrcB_Mux
    (
    .d0(rd2),
    .d1(ImmExt),
    .sel(ALUSrcB),
    .y(SrcB));
  defparam	ALUSrcB_Mux.WIDTH = 32;

  alu b2v_ALU_0
    (
    .A(SrcA),
    .B(SrcB),
    .ALUcontrol(ALUControl),
    .flags(flags),
    .result(ALU_Result));

  adder PC_Target_Adder
    (
    .A(PC),
    .B(ImmExt),
    .sum(PC_Target_Sum));

  mux2	PC_Target_Mux
    (
    .d0(PC_Target_Sum),
    .d1(ALU_Result),
    .sel(PC_Target_Src),
    .y(PC_Target));
  defparam	PC_Target_Mux.WIDTH = 32;

  WriteData b2v_write_data_0
    (
    .StoreType(StoreType),
    .Addr(ALU_Result),
    .rd2(rd2),
    .ReadData(ReadData),
    .WriteDataOut(WriteData));

  ReadData b2v_read_data_0
    (
    .LoadType(LoadType),
    .Addr(ALU_Result),
    .ReadData(ReadData),
    .ReadDataOut(ReadDataOut));

  mux4 Result_Mux
    (
    .d0(ALU_Result),
    .d1(ReadDataOut),
    .d2(PC_Next),
    .d3(PC_Target),
    .sel(ResultSrc),
    .y(Result));
  defparam	Result_Mux.WIDTH = 32;

endmodule
