module register_forward (
    input [4:0] rs1E,
    input [4:0] rs2E,
    input [4:0] rdM,
    input [4:0] rdW,
    input RegWriteM,
    input RegWriteW,
    output [1:0] ForwardAE,
    output [1:0] ForwardBE
);
    assign ForwardAE = (RegWriteM && (rdM != 0) && (rdM == rs1E)) ? 2'b10 :
                       (RegWriteW && (rdW != 0) && (rdW == rs1E)) ? 2'b01 : 2'b00;

    assign ForwardBE = (RegWriteM && (rdM != 0) && (rdM == rs2E)) ? 2'b10 :
                       (RegWriteW && (rdW != 0) && (rdW == rs2E)) ? 2'b01 : 2'b00;

endmodule