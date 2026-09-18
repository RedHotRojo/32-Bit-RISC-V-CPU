module address_decoder (
  input MemWrite,
  input [31:0] Addr,
  output RAM_CS,
  output RAM_WE,
  output ROM_CS
);

  assign ROM_CS = Addr[31:13] == 19'b0000_0000_0000_0000_000 ? 1'b1 : 1'b0;
  assign RAM_CS = Addr[31:12] == 20'b0000_0000_0000_0000_0010 ? 1'b1 : 1'b0;
  assign RAM_WE = RAM_CS & MemWrite;
  
endmodule