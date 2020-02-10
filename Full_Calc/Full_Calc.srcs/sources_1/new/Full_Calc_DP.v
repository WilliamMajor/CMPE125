`timescale 1ns / 1ps

module Full_Calc_DP(
    input [3:0] x, y,
    input [2:0] op_calc,
    input [1:0] sel_l,
    input [2:0] in_f,
    input en_in, go_calc, go_div, sel_h, en_out, clk, rst,
    output [3:0] out_h, out_l,
    output [2:0] out_f,
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

calculator Calc(
        .go         (go_calc),
        .clk        (clk),
        .op         (op_calc),
        .in1        (x_out),
        .in2        (y_out),
        .done       (done_calc),
        .out        (calc_out),
        .cs         (calc_cs)
    );

two_stage_pipeline_mult Mult(
        .A          (x_out),
        .B          (y_out),
        .SOut_h      (ph),
        .SOut_l      (pl),
        .clk        (clk),
        .rst        (rst),
        .en         (1'b1)
    );

Divider Div(
        .in1        (x_out),
        .in2        (y_out),
        .clk        (clk),
        .go         (go_div),
        .rst        (rst),
        .quotient   (Q),
        .remainder  (R),
        .done       (done_div),
        .error      (err_out)
    );


MUX1 MUX_L(
        .in1        (4'b0000),
        .in2        (calc_out),
        .in3        (pl),
        .in4        (Q),
        .s1         (sel_l),
        .m1out      (mux_l_out)
    );

MUX2 MUX_H(
        .in1        (ph),
        .in2        (R),
        .s2         (sel_h),
        .m2out      (mux_h_out)
    );

register OUT_H(
        .in         (mux_h_out),
        .en         (en_out),
        .clk        (clk),
        .out        (out_h)
    );

register OUT_L(
        .in         (mux_l_out),
        .en         (en_out),
        .clk        (clk),
        .out        (out_l)
    );
endmodule

module register(
    input [3:0] in,
    input en, clk,
    output reg [3:0] out
    );
always@(posedge clk)
begin
    if (en) begin out = in; $display("out: ",out); end
end
endmodule