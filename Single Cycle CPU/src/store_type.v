module StoreType (
  input [2:0] funct3,
  output [1:0] StoreType
);

  assign StoreType = (funct3 == 3'b010) ? 2'b00 : // Word
                    (funct3 == 3'b000) ? 2'b01 : // Byte
                    (funct3 == 3'b001) ? 2'b10 : // Half
                    2'bxx; 

endmodule