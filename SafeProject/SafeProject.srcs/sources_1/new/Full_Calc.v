`timescale 1ns / 1ps
module Full_Calc(
    input [3:0] x, y,
    input [1:0] f,
    input go, clk,
    output [3:0] out_h, out_l,
    output done, error
    );
    
wire [1:0] out_f;
wire [1:0] op_calc, sel_l;
wire en_in, en_out, go_calc, go_div, sel_h, done_calc, done_div, err;

Full_Calc_DP FCDP(
        .x          (x),
        .y          (y),
        .op_calc    (op_calc),
        .sel_l      (sel_l),
        .in_f       (f),
        .en_in      (en_in),
        .go_calc    (go_calc),
        .go_div     (go_div),
        .sel_h      (sel_h),
        .en_out     (en_out),
        .clk        (clk),
        .rst        (1'b0),
        .out_h      (out_h),
        .out_l      (out_l),
        .out_f      (out_f),
        .done_calc  (done_calc),
        .done_div   (done_div),
        .err_out    (err)
        
    );

Full_Calc_CU FCCU(
        .F          (out_f),
        .go         (go),
        .done_calc  (done_calc),
        .done_div   (done_div),
        .clk        (clk),
        .err_in     (err),
        .sel_l      (sel_l),
        .op_calc    (op_calc),
        .en_in      (en_in),
        .en_out     (en_out),
        .go_calc    (go_calc),
        .go_div     (go_div),
        .sel_h      (sel_h),
        .done       (done),
        .err_out    (error)
    );
endmodule