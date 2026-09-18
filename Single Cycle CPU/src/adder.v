module adder
 (input  [31:0] A,
  input  [31:0] B,
  output wire [31:0] sum);
  
  assign sum = A + B;
endmodule