module ROM_memory(CS,Addr,RD);
   parameter filename = "riscvtest.txt";

   input CS; // chip-select
   input [12:0] Addr;
   output [31:0] RD; // read-data
   
   reg [31:0]  ROM[0:2047];
   reg [31:0]  RD_output;
  
   initial
   begin
    $readmemh(filename,ROM);
   end

   always @(CS,Addr)
     begin
	if (CS == 1) // Read
	  RD_output <= ROM[Addr[12:2]]; // word-aligned
	else
	  RD_output <= 32'bz;
     end

   assign RD = RD_output;

endmodule
