module controller
  (input reset,
   input clock,
   input funct7b5,
   input [3:0] flags,
   input [2:0] funct3,
   input [6:0] op,
   output IRWrite,
   output AdrSrc,
   output RegWrite,
   output MemWrite,
   output PCWrite,
   output [3:0] ALUControl,
   output [1:0] ALUSrcA,
   output [1:0] ALUSrcB,
   output [2:0] ImmSrc,
   output [1:0] ResultSrc,
   output [2:0] LoadType,
   output [1:0] StoreType
);

   wire [1:0] ALUOp;
   wire Branch;
   wire BranchTaken;
   wire PCUpdate;

   alu_decoder	b2v_ALU_decoder_0
     (
      .op_5(op[5]),
      .funct7_5(funct7b5),
      .alu_op(ALUOp),
      .funct3(funct3),
      .alu_ctrl(ALUControl));

   branch_unit	b2v_branch_unit_0
     (
      .branch(Branch),
      .flags(flags),
      .funct3(funct3),
      .taken(BranchTaken));

   imm_source_decode	b2v_imm_src_decoder_0
     (
      .opcode(op),
      .imm_source(ImmSrc));

   main_fsm	b2v_main_fsm_0
     (
      .reset(reset),
      .clock(clock),
      .op(op),
      .AdrSrc(AdrSrc),
      .IRWrite(IRWrite),
      .PCUpdate(PCUpdate),
      .RegWrite(RegWrite),
      .MemWrite(MemWrite),
      .Branch(Branch),
      .ALUOp(ALUOp),
      .ALUSrcA(ALUSrcA),
      .ALUSrcB(ALUSrcB),
      .ResultSrc(ResultSrc));

   LoadType	b2v_load_type_0
     (
      .funct3(funct3),
      .LoadType(LoadType));
      
   StoreType b2v_store_type_0
       (
         .funct3(funct3),
         .StoreType(StoreType));
   
   assign	PCWrite = BranchTaken | PCUpdate;

endmodule
