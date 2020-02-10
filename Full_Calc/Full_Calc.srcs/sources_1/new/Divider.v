`timescale 1ns / 1ps

module Divider(
    input wire [3:0] in1, in2,
    input wire clk, go, rst,
    output wire [3:0] quotient, remainder,
    output wire done, error
);
wire [2:0] cin;
wire s1, s2, x_lsb, sl_r, sr_r, sl_x, ce, ld_r, ld_x, ld_y, ld_c, rst_out, cout, err_in, lt;

CU DCU(
        .cout       (cout),
        .go         (go),
        .clk        (clk),
        .rst        (rst),
        .lt         (lt),
        .err_in     (err_in),
        .cin        (cin),
        .s1         (s1),
        .s2         (s2),
        .x_lsb      (x_lsb),
        .done       (done),
        .err_out    (error),
        .sl_r       (sl_r),
        .sr_r       (sr_r),
        .sl_x       (sl_x),
        .ce         (ce),
        .ld_r       (ld_r),
        .ld_x       (ld_x),
        .ld_y       (ld_y),
        .ld_c       (ld_c),
        .rst_out    (rst_out)
    );
DP DDP(
        .in1        (in1),
        .in2        (in2),
        .cin        (cin),
        .s1         (s1),
        .s2         (s2),
        .x_lsb      (x_lsb),
        .sl_r       (sl_r),
        .sr_r       (sr_r),
        .sl_x       (sl_x),
        .rst        (rst_out),
        .clk        (clk),
        .ce         (ce),
        .ld_r       (ld_r),
        .ld_x       (ld_x),
        .ld_y       (ld_y),
        .ld_c       (ld_c),
        .quo        (quotient),
        .rem        (remainder),
        .cout       (cout),
        .lt         (lt),
        .err        (err_in)
    );

endmodule