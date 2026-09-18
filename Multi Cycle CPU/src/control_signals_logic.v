module control_signals_logic
 (input T0, T1, T2, T3, T4, MemAdr, opb5, JAL, BR,
        ExecuteI, ExecuteR, AUIPC, LUI, JALR,
  output [1:0] ALUSrcA, ALUSrcB, ResultSrc, ALUOp,
  output AdrSrc, IR_Write, PC_Update, RegWrite,
         MemWrite, Branch, EndInstr);

  // A more readable approach would be to define instructions and then assign outputs based on instructions
  /*wire Fetch = T0;
  wire Decode = T1;

  wire lw =       T2 & ~opb5 & MemAdr & ~ExecuteI & ~ExecuteR & ~BR & ~JAL;
  wire MemRead =  T3 & ~opb5 & MemAdr & ~ExecuteI & ~ExecuteR & ~BR & ~JAL;
  wire WriteReg = T4 & ~opb5 & MemAdr & ~ExecuteI & ~ExecuteR & ~BR & ~JAL;
  
  wire sw =       T2 & opb5 & MemAdr & ~ExecuteI & ~ExecuteR & ~BR & ~JAL;
  wire WriteMem = T3 & opb5 & MemAdr & ~ExecuteI & ~ExecuteR & ~BR & ~JAL;
  
  wire ALU =      T2 & opb5 & ~MemAdr & ~ExecuteI & ExecuteR & ~BR & ~JAL;
  wire ALUWrite = T3 & opb5 & ~MemAdr & ~ExecuteI & ExecuteR & ~BR & ~JAL;
  
  wire addi =      T2 & opb5 & ~MemAdr & ExecuteI & ~ExecuteR & ~BR & ~JAL;
  wire addiWrite = T3 & opb5 & ~MemAdr & ExecuteI & ~ExecuteR & ~BR & ~JAL;

  wire jump =      T2 & opb5 & ~MemAdr & ~ExecuteI & ~ExecuteR & ~BR & JAL;
  wire jumpWrite = T3 & ~opb5 & ~MemAdr & ~ExecuteI & ~ExecuteR & ~BR & JAL;

  wire beq = T2 & opb5 & ~MemAdr & ~ExecuteI & ~ExecuteR & BR & ~JAL;*/

  assign ALUSrcA[1] = (T2 & MemAdr) | (T2 & ExecuteR) | (T2 & ExecuteI) | (T2 & BR) | (LUI & T2) | (JALR & T2);
  assign ALUSrcA[0] = T1 | (T2 & JAL) | (LUI & T2) | (AUIPC & T2) | (JALR & T3);
  assign ALUSrcB[1] = T0 | (JAL & T2) | (JALR & T3);
  assign ALUSrcB[0] = T1 | (T2 & (MemAdr | ExecuteI | LUI | AUIPC | JALR)); 
  assign ResultSrc[1] = T0 | ((T2 | T3) & JALR);
  assign ResultSrc[0] = T4 & MemAdr;
  assign AdrSrc = T3 & MemAdr;
  assign IR_Write = T0;
  assign PC_Update = T0 | (T2 & JAL) | (T2 & JALR);
  assign RegWrite = ((JAL | ExecuteI | ExecuteR | LUI | AUIPC | JALR) & T3) | T4;
  assign MemWrite = T3 & opb5 & MemAdr;
  assign ALUOp[1] = (T2 & (ExecuteR | ExecuteI));
  assign ALUOp[0] = BR & T2;
  assign Branch = BR;
  assign EndInstr = (MemAdr & opb5 & T4) | (T4 & ExecuteR) | (T4 & ExecuteI) | (T4 & JAL) | (T3 & BR) | (T4 & LUI) | (T4 & AUIPC) | (T4 & JALR);
endmodule