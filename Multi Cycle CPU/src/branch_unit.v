module branch_unit (
  input branch,
  input [2:0] funct3,
  input [3:0] flags,
  output taken
);
  
  // flags = {v, c, n, z}
  wire beq =  (funct3 == 3'b000) &   flags[0];
  wire bne =  (funct3 == 3'b001) & ~ flags[0];
  wire blt =  (funct3 == 3'b100) &  (flags[3] ^ flags[1]);
  wire bge =  (funct3 == 3'b101) & ~(flags[3] ^ flags[1]);
  wire bltu = (funct3 == 3'b110) & ~ flags[2];
  wire bgeu = (funct3 == 3'b111) &   flags[2];

  assign taken = branch & (beq | bne | blt | bge | bltu | bgeu);

endmodule