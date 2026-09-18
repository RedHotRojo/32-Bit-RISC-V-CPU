module alu_decoder (
  input [1:0] alu_op,
  input [2:0] funct3,
  input funct7_5,
  input op_5,
  output [3:0] alu_ctrl
);

  assign alu_ctrl = (alu_op == 2'b00 || (alu_op == 2'b10 && funct3 == 3'b000 && ~(funct7_5 == 1 && op_5 == 1))) ? 4'b0000 : // add
                    (alu_op == 2'b01 || (alu_op == 2'b10 && funct3 == 3'b000 && funct7_5 == 1 && op_5 == 1)) ? 4'b0001 : // sub
                    (alu_op == 2'b10 && funct3 == 3'b111) ? 4'b0010 : // and
                    (alu_op == 2'b10 && funct3 == 3'b110) ? 4'b0011 : // or
                    (alu_op == 2'b10 && funct3 == 3'b100) ? 4'b0100 : // slt
                    (alu_op == 2'b10 && funct3 == 3'b010) ? 4'b0101 : // slt
                    (alu_op == 2'b10 && funct3 == 3'b001) ? 4'b0110 : // sll
                    (alu_op == 2'b10 && funct3 == 3'b101 && funct7_5 == 0) ? 4'b0111 : // srl
                    (alu_op == 2'b10 && funct3 == 3'b101 && funct7_5 == 1) ? 4'b1000 : // sra
                    (alu_op == 2'b10 && funct3 == 3'b011) ? 4'b1001 : // sltu
                    3'bxxx; // undefined
  
endmodule