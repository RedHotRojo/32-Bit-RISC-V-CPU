`timescale 1ns / 1ns

module reset_clock (reset, clock);

   output reg reset;
   output reg clock;
   integer Period = 100;

   // reset generation
   initial
     begin
	reset <= 1;
	#(Period/5);
	reset <= 0;
     end

   // clock generation
   always
     begin
	clock <= 0;
	#(Period/2);
	clock <= 1;
	#(Period/2);
     end

endmodule
