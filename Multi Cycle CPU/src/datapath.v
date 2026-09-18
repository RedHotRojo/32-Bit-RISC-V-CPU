module datapath
  (input reset,
   input clock,
   input [2:0] ImmSrc,
   input [1:0] ALUSrcA,
   input [1:0] ALUSrcB,
   input [1:0] ResultSrc,
   input AdrSrc,
   input [3:0] ALUControl,
   input IRWrite,
   input PCWrite,
   input RegWrite,
   input [31:0] ReadData,
   input [2:0] LoadType,
   input [1:0] StoreType,
   output [6:0] op,
   output [2:0] funct3,
   output funct7b5,
   output [3:0] flags,
   output [31:0] Addr,
   output [31:0] WriteData
);

   wire [31:0] A;
   wire [31:0] A_D;
   wire [31:0] ALUOut;
   wire [31:0] ALUresult;
   wire [31:0] B;
   wire [31:0] B_D;
   wire [31:0] Data;
   wire [31:0] ImmExt;
   wire [31:0] Instr;
   wire [31:0] OldPC;
   wire [31:0] PC;
   wire [31:0] PCIncr;
   wire [31:0] Result;
   wire [31:0] ReadDataOut;
   wire [31:0] SrcA;
   wire [31:0] SrcB;
   wire Vcc;
   
   assign	Vcc = 1;

   register_n	b2v_A_register
     (
      .reset(reset),
      .clock(clock),
      .enable(Vcc),
      .D(A_D),
      .Q(A));
   defparam	b2v_A_register.WIDTH = 32;

   alu	b2v_ALU_0
     (
      .A(SrcA),
      .ALUcontrol(ALUControl),
      .B(SrcB),
      .flags(flags),
      .result(ALUresult));

   mux3	b2v_ALUMux
     (
      .d0(ALUOut),
      .d1(Data),
      .d2(ALUresult),
      .sel(ResultSrc),
      .y(Result));
   defparam	b2v_ALUMux.WIDTH = 32;

   register_n	b2v_ALUOut_register
     (
      .reset(reset),
      .clock(clock),
      .enable(Vcc),
      .D(ALUresult),
      .Q(ALUOut));
   defparam	b2v_ALUOut_register.WIDTH = 32;

   register_n	b2v_B_register
     (
      .reset(reset),
      .clock(clock),
      .enable(Vcc),
      .D(B_D),
      .Q(B));
   defparam	b2v_B_register.WIDTH = 32;

   extend_immediate	b2v_extend_0
     (
      .immSrc(ImmSrc),
      .instr(Instr),
      .immExt(ImmExt));
   
   mux2	b2v_InstrDataMemoryMux
     (
      .sel(AdrSrc),
      .d0(PC),
      .d1(Result),
      .y(Addr));
   defparam	b2v_InstrDataMemoryMux.WIDTH = 32;

   register_n	b2v_IR
     (
      .reset(reset),
      .clock(clock),
      .enable(IRWrite),
      .D(ReadData),
      .Q(Instr));
   defparam	b2v_IR.WIDTH = 32;

   register_n	b2v_OldPC_register
     (
      .reset(reset),
      .clock(clock),
      .enable(IRWrite),
      .D(PC),
      .Q(OldPC));
   defparam	b2v_OldPC_register.WIDTH = 32;

   register_n	b2v_PC_register
     (
      .reset(reset),
      .clock(clock),
      .enable(PCWrite),
      .D(Result),
      .Q(PC));
   defparam	b2v_PC_register.WIDTH = 32;

   constant_32bit	b2v_PCIncrement
     (.y(PCIncr));
   defparam	b2v_PCIncrement.value = 4;

   register_n	b2v_Data_register
     (
      .reset(reset),
      .clock(clock),
      .enable(Vcc),
      .D(ReadDataOut),
      .Q(Data));
   defparam	b2v_Data_register.WIDTH = 32;

   register_file	b2v_rf_0
     (
      .reset(reset),
      .clock(clock),
      .we3(RegWrite),
      .a1(Instr[19:15]),
      .a2(Instr[24:20]),
      .a3(Instr[11:7]),
      .wd3(Result),
      .rd1(A_D),
      .rd2(B_D));

   mux4	b2v_SrcAMux
     (
      .d0(PC),
      .d1(OldPC),
      .d2(A),
      .d3(32'b0),
      .sel(ALUSrcA),
      .y(SrcA));
   defparam	b2v_SrcAMux.WIDTH = 32;

   mux3	b2v_SrcBMux
     (
      .d0(B),
      .d1(ImmExt),
      .d2(PCIncr),
      .sel(ALUSrcB),
      .y(SrcB));
   defparam	b2v_SrcBMux.WIDTH = 32;

   ReadData	b2v_read_data_0
     (
      .LoadType(LoadType),
      .Addr(Addr),
      .ReadData(ReadData),
      .ReadDataOut(ReadDataOut));

   WriteData b2v_write_data_0
     (
       .StoreType(StoreType),
       .Addr(Addr),
       .rd2(B_D),
       .ReadData(ReadData),
       .WriteDataOut(WriteData));

   assign	funct7b5 = Instr[30];
   assign	funct3[2:0] = Instr[14:12];
   assign	op[6:0] = Instr[6:0];

endmodule
