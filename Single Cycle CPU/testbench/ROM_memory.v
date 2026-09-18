module ROM_memory(Addr,RD);
   parameter filename = "riscvtest.txt";

   input [12:0] Addr;
   output [31:0] RD; // read-data
   
   reg [31:0]  ROM[0:2047];
   reg [31:0]  RD_output;
  
   initial
   begin
    $readmemh(filename,ROM);
   end

   always @(Addr)
     begin
    	  RD_output <= ROM[Addr[12:2]]; // word-aligned
     end

   assign RD = RD_output;

endmodule
