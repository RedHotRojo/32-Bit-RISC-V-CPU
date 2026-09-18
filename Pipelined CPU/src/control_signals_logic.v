module control_signals_logic
 (input MemAdr, opb5, JAL, BR,
        ExecuteI, ExecuteR, AUIPC, LUI, JALR,
  output [1:0] ResultSrc, ALUOp,
  output ALUSrcA, ALUSrcB, RegWrite, MemWrite);

  assign ALUSrcA = LUI;
  assign ALUSrcB = MemAdr | ExecuteI | LUI | AUIPC | JALR | JAL; 
  assign ResultSrc[1] = JALR | AUIPC;
  assign ResultSrc[0] = MemAdr | AUIPC;
  assign RegWrite = JAL | ExecuteI | ExecuteR | LUI | AUIPC | JALR | MemAdr & ~opb5;
  assign MemWrite = opb5 & MemAdr;
  assign ALUOp[1] = ExecuteR | ExecuteI;
  assign ALUOp[0] = BR;
endmodule