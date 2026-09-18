module pipeline_register_DE (
    input clock,
    input reset,
    input [31:0] rd1D,
    input [31:0] rd2D,
    input [31:0] PCD,
    input [31:0] ImmExtD,
    input [31:0] PC_NextD,
    input [31:0] InstrD,
    input FlushE,
    output [31:0] rd1E,
    output [31:0] rd2E,
    output [31:0] PCE,
    output [31:0] ImmExtE,
    output [31:0] PC_NextE,
    output [31:0] InstrE
);
    wire [31:0] rd1Ein;
    wire [31:0] rd2Ein;
    wire [31:0] ImmExtEin;
    wire [31:0] InstrEin;

    mux2 #(.WIDTH(32)) Flush_RD1_Mux
    (
        .d0(rd1D),
        .d1(32'b0),
        .sel(FlushE),
        .y(rd1Ein)
    );

    mux2 #(.WIDTH(32)) Flush_RD2_Mux
    (
        .d0(rd2D),
        .d1(32'b0),
        .sel(FlushE),
        .y(rd2Ein)
    );

    mux2 #(.WIDTH(32)) Flush_ImmExt_Mux
    (
        .d0(ImmExtD),
        .d1(32'b0),
        .sel(FlushE),
        .y(ImmExtEin)
    );

    mux2 #(.WIDTH(32)) Instr_Flush_Mux
    (
        .d0(InstrD),
        .d1(32'h13),
        .sel(FlushE),
        .y(InstrEin)
    );

    register_n #(.WIDTH(32)) rd1_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(rd1Ein),
        .Q(rd1E)
    );

    register_n #(.WIDTH(32)) rd2_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(rd2Ein),
        .Q(rd2E)
    );

    register_n #(.WIDTH(32)) PC_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(PCD),
        .Q(PCE)
    );

    register_n #(.WIDTH(32)) ImmExt_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(ImmExtEin),
        .Q(ImmExtE)
    );

    register_n #(.WIDTH(32)) PC_Next_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(PC_NextD),
        .Q(PC_NextE)
    );

    register_n #(.WIDTH(32)) Instr_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(InstrEin),
        .Q(InstrE)
    );
endmodule