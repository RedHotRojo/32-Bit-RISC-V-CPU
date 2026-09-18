module register_file
  (input reset,
  input clock,
  input we3,
  input [4:0] a1,
  input [4:0] a2,
  input [4:0] a3,
  input [31:0] wd3,
  output [31:0] rd1,
  output [31:0] rd2);

  reg [31:0] Q [0:31];

  always @(posedge reset, posedge clock)
    begin
      if (reset == 1)
        begin
          Q[0] <= 32'b0;
          Q[1] <= 32'b0;
          Q[2] <= 32'b0;
          Q[3] <= 32'b0;
          Q[4] <= 32'b0;
          Q[5] <= 32'b0;
          Q[6] <= 32'b0;
          Q[7] <= 32'b0;
          Q[8] <= 32'b0;
          Q[9] <= 32'b0;
          Q[10] <= 32'b0;
          Q[11] <= 32'b0;
          Q[12] <= 32'b0;
          Q[13] <= 32'b0;
          Q[14] <= 32'b0;
          Q[15] <= 32'b0;
          Q[16] <= 32'b0;
          Q[17] <= 32'b0;
          Q[18] <= 32'b0;
          Q[19] <= 32'b0;
          Q[20] <= 32'b0;
          Q[21] <= 32'b0;
          Q[22] <= 32'b0;
          Q[23] <= 32'b0;
          Q[24] <= 32'b0;
          Q[25] <= 32'b0;
          Q[26] <= 32'b0;
          Q[27] <= 32'b0;
          Q[28] <= 32'b0;
          Q[29] <= 32'b0;
          Q[30] <= 32'b0;
          Q[31] <= 32'b0;
        end
      else if ((we3 == 1) && (a3 != 0))
        Q[a3] <= wd3;
    end

  assign rd1 = Q[a1];
  assign rd2 = Q[a2];
endmodule