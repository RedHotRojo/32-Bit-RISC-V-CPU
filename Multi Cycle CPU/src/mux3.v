module mux3
  #(parameter WIDTH = 8)
   (
    input [WIDTH-1:0] d0,
    input [WIDTH-1:0] d1,
    input [WIDTH-1:0] d2,
    input [1:0] sel,
    output [WIDTH-1:0] y
   );

   wire [WIDTH-1:0] di;

   mux2 #(.WIDTH(WIDTH)) mux2_0(.d0(d0), .d1(d1), .sel(sel[0]), .y(di));
   mux2 #(.WIDTH(WIDTH)) mux2_out(.d0(di), .d1(d2), .sel(sel[1]), .y(y));
endmodule