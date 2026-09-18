module hazard
(
    input [4:0] rs1D,
    input [4:0] rs2D,
    input [4:0] rdE,
    input PC_SrcE,
    input readsRs1D,
    input readsRs2D,
    input isLoadE,
    output stallF,
    output stallD,
    output flushD,
    output flushE
);

    wire rs1Hazard = (rs1D == rdE) & readsRs1D;
    wire rs2Hazard = (rs2D == rdE) & readsRs2D;
    wire lwStall = (rs1Hazard | rs2Hazard) & isLoadE;

    // Hazard Detection for Load-Use
    assign stallF = lwStall;
    assign stallD = lwStall;
    assign flushD = PC_SrcE;
    assign flushE = lwStall | PC_SrcE;
endmodule