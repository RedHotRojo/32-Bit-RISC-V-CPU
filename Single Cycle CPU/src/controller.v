module controller (
   input funct7b5,
   input [3:0] flags,
   input [2:0] funct3,
   input [6:0] op,
   output Jump,
   output Branch,
   output RegWrite,
   output MemWrite,
   output PC_Target_Src,
   output [3:0] ALUControl,
   output ALUSrcA,
   output ALUSrcB,
   output [2:0] ImmSrc,
   output [1:0] ResultSrc,
   output [2:0] LoadType,
   output [1:0] StoreType
);

   wire [1:0] ALUOp;

   wire BR;
   wire ExecuteI;
   wire ExecuteR;
   wire JAL;
   wire JALR;
   wire AUIPC;
   wire LUI;
   wire MemAdr;

   assign Jump = JAL | JALR;
   assign Branch = BR;
   assign PC_Target_Src = JALR;

   instruction_decoder	b2v_instruction_decoder_0
      (
      .op(op),
      .MemAdr(MemAdr),
      .ExecuteI(ExecuteI),
      .ExecuteR(ExecuteR),
      .BR(BR),
      .JAL(JAL),
      .JALR(JALR),
      .AUIPC(AUIPC),
      .LUI(LUI));

   control_signals_logic	b2v_control_signals
      (
      .MemAdr(MemAdr),
      .ExecuteI(ExecuteI),
      .AUIPC(AUIPC),
      .ExecuteR(ExecuteR),
      .LUI(LUI),
      .BR(BR),
      .JAL(JAL),
      .JALR(JALR),
      .opb5(op[5]),

      .ALUSrcA(ALUSrcA),
      .ALUSrcB(ALUSrcB),
      .ResultSrc(ResultSrc),
      .RegWrite(RegWrite),
      .MemWrite(MemWrite),
      .ALUOp(ALUOp));

   alu_decoder	b2v_ALU_decoder_0
     (
      .op_5(op[5]),
      .funct7_5(funct7b5),
      .alu_op(ALUOp),
      .funct3(funct3),
      .alu_ctrl(ALUControl));

   imm_source_decode	b2v_imm_src_decoder_0
     (
      .opcode(op),
      .imm_source(ImmSrc));

   LoadType	b2v_load_type_0
     (
      .funct3(funct3),
      .LoadType(LoadType));
      
   StoreType b2v_store_type_0
      (
      .funct3(funct3),
      .StoreType(StoreType));

endmodule
