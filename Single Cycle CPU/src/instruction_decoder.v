module instruction_decoder
 (input [6:0] op,
  output MemAdr,
  output ExecuteI,
  output ExecuteR,
  output BR,
  output JAL,
  output JALR,
  output AUIPC,
  output LUI);

  wire isLoad;
  wire isStore;

  assign MemAdr = (isLoad | isStore);
  assign isLoad = (op == 7'h03);
  assign isStore = (op == 7'h23);
  
  assign ExecuteI = (op == 7'h13);
  assign ExecuteR = (op == 7'h33);
  assign BR = (op == 7'h63);
  assign JAL = (op == 7'h6F);
  assign JALR = (op == 7'h67);
  assign LUI = (op == 7'h37);
  assign AUIPC = (op == 7'h17);
endmodule