module pipeline_register_MW (
    input clock,
    input reset,
    input [31:0] ReadDataOutM,
    input [31:0] ResultM,
    input [31:0] PC_TargetM,
    input [31:0] PC_NextM,
    input [31:0] InstrM,
    output [31:0] ReadDataOutW,
    output [31:0] ResultW,
    output [31:0] PC_TargetW,
    output [31:0] PC_NextW,
    output [31:0] InstrW
);

    register_n #(.WIDTH(32)) ReadDataOut_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(ReadDataOutM),
        .Q(ReadDataOutW)
    );

    register_n #(.WIDTH(32)) Result_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(ResultM),
        .Q(ResultW)
    );

    register_n #(.WIDTH(32)) PC_Target_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(PC_TargetM),
        .Q(PC_TargetW)
    );

    register_n #(.WIDTH(32)) PC_Next_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(PC_NextM),
        .Q(PC_NextW)
    );

    register_n #(.WIDTH(32)) Instr_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(InstrM),
        .Q(InstrW)
    );
endmodule