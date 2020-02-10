`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 10:10:06 PM
// Design Name: 
// Module Name: FullCalcDP
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


module FullCalcDP(
        input [3:0] x, y,
        input [1:0] op_calc, sel_l, in_f,
        input en_in, go_calc, go_div, sel_h, en_out, clk, rst,
        output [3:0] out_h, out_l,
        output [1:0] out_f,
        output done_calc, done_div, err_out
    );
wire [3:0] y_out, x_out, calc_out, ph, pl, R, Q, mux_h_out, mux_l_out, calc_cs;

register X(
        .in     (x),
        .en     (en_in),
        .clk    (clk),
        .out    (x_out)
    );
    
register Y(
        .in     (y),
        .en     (en_in),
        .clk    (clk),
        .out    (y_out)
    );
    
register F(
        .in     (in_f),
        .en     (en_in),
        .clk    (clk),
        .out    (out_f)
    );
    
small_calculator Calc(
        .clk    (clk),
        .go     (go_calc),
        .op     (op_calc),
        .in1    (x_out),
        .in2    (y_out),
        .out    (calc_out),
        .CS     (calc_cs),
        .done   (done_calc)
    );

Multiplier Mult(
        .x      (x_out),
        .y      (y_out),
        .ph     (ph),
        .pl     (pl)
    );
    
Divider Div(
        .Dividend   (x_out),
        .Divisor    (y_out),
        .clk        (clk),
        .go         (go_div),
        .rst        (rst),
        .Quotient   (Q),
        .Remainder  (R),
        .done       (done_div),
        .error      (err_out)
    );
 
MUX1 MUX_L(
        .sel    (sel_l),
        .in0    (4'b0000),
        .in1    (calc_out),
        .in2    (pl),
        .in3    (Q),
        .out    (mux_l_out)
    );    

MUX2 MUX_H(
        .sel    (sel_h),
        .a      (ph),
        .b      (R),
        .out    (mux_h_out)
    );

register OUT_H(
        .in     (mux_h_out),
        .en     (en_out),
        .clk    (clk),
        .out    (out_h)
    );
register OUT_L(
        .in     (mux_l_out),
        .en     (en_out),
        .clk    (clk),
        .out    (out_l)
    );
endmodule

module register(
        input [3:0] in,
        input en, clk,
        output reg [3:0] out
    );
always@(posedge clk)
begin
    if (en) out = in;
end
endmodule