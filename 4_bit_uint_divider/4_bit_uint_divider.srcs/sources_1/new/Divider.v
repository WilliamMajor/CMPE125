`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 07:46:20 PM
// Design Name: 
// Module Name: Divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Divider(
    input wire [3:0] Dividend, Divisor,
    input wire clk, go, rst,
    output wire [3:0] Quotient, Remainder,
    output wire done, error
);
wire [2:0] cin;
wire s1, s2, x_leftin, sl_remainder, sr_remainder, sl_x, ce, ld_remainder,
     ld_x, ld_y,ld_c, rst_out, cout, err_in, lessThan;

Control_Unit CU(
        .cout           (cout),
        .go             (go),
        .clk            (clk),
        .rst            (rst),
        .lessThan       (lessThan),
        .err_in         (err_in),
        .cin            (cin),
        .s1             (s1),
        .s2             (s2),
        .x_leftin       (x_leftin),
        .done           (done),
        .err_out        (error),
        .sl_remainder   (sl_remainder),
        .sr_remainder   (sr_remainder),
        .sl_x           (sl_x),
        .ce             (ce),
        .ld_remainder   (ld_remainder),
        .ld_x           (ld_x),
        .ld_y           (ld_y),
        .ld_c           (ld_c),
        .rst_out        (rst_out)
    );

four_bit_uint_divider_DP DP(
        .Dividend       (Dividend),
        .Divisor        (Divisor),
        .cin            (cin),
        .s1             (s1),
        .s2             (s2),
        .x_leftin       (x_leftin),
        .sl_remainder   (sl_remainder),
        .sr_remainder   (sr_remainder),
        .sl_x           (sl_x),
        .rst            (rst_out),
        .clk            (clk),
        .ce             (ce),
        .ld_remainder   (ld_remainder),
        .ld_x           (ld_x),
        .ld_y           (ld_y),
        .ld_c           (ld_c),
        .Quotient       (Quotient),
        .Remainder      (Remainder),
        .cout           (cout),
        .lessThan       (lessThan),
        .err            (err_in)
    );

endmodule
