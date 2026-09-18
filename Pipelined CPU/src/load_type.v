module LoadType (
  input [2:0] funct3,
  output [2:0] LoadType
);

  assign LoadType = (funct3 == 3'b010) ? 3'b000 : // Word
                    (funct3 == 3'b100) ? 3'b001 : // Unsigned Byte
                    (funct3 == 3'b000) ? 3'b010 : // Signed Byte
                    (funct3 == 3'b101) ? 3'b100 : // Unsigned Half
                    (funct3 == 3'b001) ? 3'b101 : // Signed Half
                    3'bxxx; 

endmodule