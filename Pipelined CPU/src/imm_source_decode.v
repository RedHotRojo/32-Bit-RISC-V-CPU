module imm_source_decode
(input [6:0] opcode, output [2:0] imm_source);
  assign imm_source = (opcode == 7'b0000011 || opcode == 7'b0010011 || opcode == 7'b1100111) ? 3'b000 : // Load, ALU immediate, jalr
                      (opcode == 7'b0100011) ? 3'b001 : // Store instructions
                      (opcode == 7'b1100011) ? 3'b010 : // Branch instructions
                      (opcode == 7'b1101111) ? 3'b011 : // jal
                      (opcode == 7'b0010111) ? 3'b100 : // auipc
                      (opcode == 7'b0110111) ? 3'b100 : // lui
                      3'bxxx;
endmodule