module pipeline_register_FD (
    input clock,
    input reset,
    input [31:0] InstrF,
    input [31:0] PCF,
    input [31:0] PC_NextF,
    input nStallD,
    input FlushD,
    output [31:0] InstrD,
    output [31:0] PCD,
    output [31:0] PC_NextD
);
    wire [31:0] InstrDin;

    mux2 #(.WIDTH(32)) Flush_Instr_Mux
    (
        .d0(InstrF),
        .d1(32'h13),
        .sel(FlushD),
        .y(InstrDin)
    );

    register_n #(.WIDTH(32)) Instr_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(nStallD),
        .D(InstrDin),
        .Q(InstrD)
    );

    register_n #(.WIDTH(32)) PC_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(nStallD),
        .D(PCF),
        .Q(PCD)
    );

    register_n #(.WIDTH(32)) PC_Next_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(nStallD),
        .D(PC_NextF),
        .Q(PC_NextD)
    );
endmodule