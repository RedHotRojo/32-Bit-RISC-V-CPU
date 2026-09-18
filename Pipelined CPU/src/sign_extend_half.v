module SignExtendHalf
  (
    input [15:0] in,
    output [31:0] out
  );

  assign out = {{17{in[15]}}, in[14:0]};

endmodule