module t_counter
(input reset,
 input clock,
 output T0,
 output T1,
 output T2,
 output T3,
 output T4);

  reg [2:0] t_count;
  reg [2:0] t_count_ns;

  // current state
  always @(posedge reset, posedge clock)
    if (reset)
      t_count <= 3'b0;
    else
      t_count <= t_count_ns;

  // next state
  always @(t_count)
    if (t_count == 3'b100)
      t_count_ns <= 3'b0;
    else
      t_count_ns <= t_count + 3'b1;

  // output logic
  assign T0 = ~t_count[2] & ~t_count[1] & ~t_count[0];
  assign T1 = ~t_count[2] & ~t_count[1] &  t_count[0];
  assign T2 = ~t_count[2] &  t_count[1] & ~t_count[0];
  assign T3 = ~t_count[2] &  t_count[1] &  t_count[0];
  assign T4 =  t_count[2] & ~t_count[1] & ~t_count[0];

endmodule