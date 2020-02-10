`timescale 1ns / 1ps

module calculator(
    input go, clk,
    input [2:0] op,
    input [3:0] in1, in2,
    output done,
    output [3:0] out,
    output [3:0] cs
    );
wire we, rea, reb, s2;
wire [1:0] s1, wa, raa, rab;
wire [2:0] c;

Calculator_CU CCU(
        .go     (go),
        .clk    (clk),
        .op     (op),
        .we     (we),
        .rea    (rea),
        .reb    (reb),
        .s2     (s2),
        .done   (done),
        .s1     (s1),
        .wa     (wa),
        .raa    (raa),
        .rab    (rab),
        .c      (c),
        .cs     (cs)
    );

Calculator_DP CDP(
        .in1    (in1),
        .in2    (in2),
        .s1     (s1),
        .clk    (clk),
        .wa     (wa),
        .we     (we),
        .raa    (raa),
        .rea    (rea),
        .rab    (rab),
        .reb    (reb),
        .c      (c),
        .s2     (s2),
        .out    (out)
    );

endmodule