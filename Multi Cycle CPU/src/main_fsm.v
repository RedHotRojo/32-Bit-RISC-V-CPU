module main_fsm
(
 reset,
 clock,
 op,
 ALUSrcA,
 ALUSrcB,
 ResultSrc,
 AdrSrc,
 IRWrite,
 PCUpdate,
 RegWrite, 
 MemWrite,
 ALUOp,
 Branch
 );

   input wire	reset;
   input wire	clock;
   input wire [6:0] op;
   output wire 	    IRWrite;
   output wire 	    AdrSrc;
   output wire 	    RegWrite;
   output wire 	    MemWrite;
   output wire 	    PCUpdate;
   output wire 	    Branch;
   output wire [1:0] ALUOp;
   output wire [1:0] ALUSrcA;
   output wire [1:0] ALUSrcB;
   output wire [1:0] ResultSrc;

   wire BR;
   wire EndInstr;
   wire ExecuteI;
   wire ExecuteR;
   wire JAL;
   wire JALR;
   wire AUIPC;
   wire LUI;
   wire MemAdr;
   wire t0;
   wire t1;
   wire t2;
   wire t3;
   wire t4;
   wire SYNTHESIZED_WIRE_0;

   control_signals_logic	b2v_control_signals
     (
      .T0(t0),
      .T1(t1),
      .T2(t2),
      .T3(t3),
      .T4(t4),
      .MemAdr(MemAdr),
      .ExecuteI(ExecuteI),
      .ExecuteR(ExecuteR),
      .BR(BR),
      .JAL(JAL),
      .opb5(op[5]),
      .AdrSrc(AdrSrc),
      .IR_Write(IRWrite),
      .PC_Update(PCUpdate),
      .RegWrite(RegWrite),
      .MemWrite(MemWrite),
      .Branch(Branch),
      .EndInstr(EndInstr),
      .ALUOp(ALUOp),
      .ALUSrcA(ALUSrcA),
      .ALUSrcB(ALUSrcB),
      .ResultSrc(ResultSrc),
      .JALR(JALR),
      .AUIPC(AUIPC),
      .LUI(LUI));

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

   assign	SYNTHESIZED_WIRE_0 = EndInstr | reset;

   t_counter	b2v_sequencer
     (
      .reset(SYNTHESIZED_WIRE_0),
      .clock(clock),
      .T0(t0),
      .T1(t1),
      .T2(t2),
      .T3(t3),
      .T4(t4));

endmodule
