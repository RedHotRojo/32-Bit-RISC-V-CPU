module alu
 (input  [31:0] A,
  input  [31:0] B,
  input  [3:0] ALUcontrol,
  output reg [31:0] result,
  output [3:0] flags);

  wire [31:0] condinvb, sum;
  wire v, c, n, z;
  wire cout;

  // Overflow conditions
  wire Condition1, Condition2, Condition3;
  assign Condition1 = (~ALUcontrol[2] & ~ALUcontrol[1] |
                        ~ALUcontrol[1] & ALUcontrol[0]); // Addition, Subtraction, or Set on Less Than
  assign Condition2 = (A[31] ^ sum[31]); // different sign between A and result
  assign Condition3 = ~(A[31] ^ B[31] ^ ALUcontrol[0]); // A and B have same sign for addition or different signs for subtraction

  assign condinvb = B ^ {32{ALUcontrol[0]}};
  assign {cout, sum} = A + condinvb + {31'b0, ALUcontrol[0]};
  assign flags = {v, c, n, z};
  assign z = sum == 32'b0;
  assign n = result[31];
  assign c = cout & Condition1;
  assign v = Condition1 & Condition2 & Condition3;

  always @(ALUcontrol, sum, A, B, v, c, cout) begin
    case (ALUcontrol)
      4'b0000: result <= sum;                     // Add
      4'b0001: result <= sum;                     // Subtract
      4'b0010: result <= A & B;                   // and
      4'b0011: result <= A | B;                   // or
      4'b0100: result <= A ^ B;                   // xor
      4'b0101: result <= {31'b0, (sum[31] ^ v)};  // slt
      4'b0110: result <= A << B[4:0];             // sll
      4'b0111: result <= A >> B[4:0];             // srl
      4'b1000: result <= $signed(A) >>> B[4:0];            // sra
      4'b1001: result <= {31'b0, ~cout};          // sltu
      default: result = 32'bx;
    endcase
  end
endmodule