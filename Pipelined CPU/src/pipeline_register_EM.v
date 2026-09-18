module pipeline_register_EM (
    input clock,
    input reset,
    input [31:0] WriteDataE,
    input [31:0] ResultE,
    input [31:0] PC_TargetE,
    input [31:0] PC_NextE,
    input [31:0] InstrE,
    output [31:0] WriteDataM,
    output [31:0] ResultM,
    output [31:0] PC_TargetM,
    output [31:0] PC_NextM,
    output [31:0] InstrM
);

    register_n #(.WIDTH(32)) WriteData_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(WriteDataE),
        .Q(WriteDataM)
    );

    register_n #(.WIDTH(32)) Result_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(ResultE),
        .Q(ResultM)
    );

    register_n #(.WIDTH(32)) PC_Target_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(PC_TargetE),
        .Q(PC_TargetM)
    );

    register_n #(.WIDTH(32)) PC_Next_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(PC_NextE),
        .Q(PC_NextM)
    );

    register_n #(.WIDTH(32)) Instr_Register
    (
        .reset(reset),
        .clock(clock),
        .enable(1'b1),
        .D(InstrE),
        .Q(InstrM)
    );
endmodule