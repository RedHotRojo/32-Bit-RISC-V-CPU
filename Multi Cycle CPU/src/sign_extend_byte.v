module SignExtendByte
  (
    input [7:0] in,
    output [31:0] out
  );

  assign out = {{25{in[7]}}, in[6:0]};

endmodule