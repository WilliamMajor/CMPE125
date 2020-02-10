`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 08:03:15 PM
// Design Name: 
// Module Name: CU_tb
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


module CU_tb;

reg go, clk, rst, lt, err_in, cout;
wire [2:0] cin;
wire s1, s2, x_lsb, done, err_out;
wire sl_r, sr_r, sl_x, ce;
wire ld_r, ld_x, ld_y, ld_c, rst_out;
wire [16:0] ctrl = {cin, s1, s2, x_lsb, done, err_out, sl_r, sr_r, sl_x,
                    ce, ld_r, ld_x, ld_y, ld_c, rst_out};
                    
integer error_count = 0;
                    
Control_Unit DUT(
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
        .err_out    (err_out),
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
task tik_tok;
begin
    clk = 0;
    #2;
    clk = 1;
    #2;
    clk = 0;
end
endtask
//Outputs for each state
parameter   idle = 17'b100_0_0_0_0_0_0_0_0_0_0_0_0_0_1,
            load = 17'b100_0_0_0_0_0_0_0_0_0_0_1_1_0_0,
            step2 = 17'b100_0_0_0_0_0_1_0_1_1_0_0_0_1_0,
            dec_lt = 17'b100_0_0_0_0_0_0_0_0_1_0_0_0_0_0,
            dec = 17'b100_0_0_0_0_0_0_0_0_1_1_0_0_0_0,
            less_than = 17'b100_0_0_0_0_0_1_0_1_0_0_0_0_0_0,
            not_less_than = 17'b100_0_0_1_0_0_1_0_1_0_0_0_0_0_0,
            shift_right = 17'b100_0_0_0_0_0_0_1_0_0_0_0_0_0_0,
            finished = 17'b100_1_1_0_1_0_0_0_0_0_0_0_0_0_0;
initial
begin
    go = 0;
    rst = 1;
    cout = 1;
    tik_tok;
    
    //Should be in state 0
    if(ctrl != idle) error_count = error_count + 1;
    go = 1;
    rst = 0;
    tik_tok;
    
    //Should be in state 1
    if(ctrl != load) error_count = error_count + 1;
    tik_tok;
    
    if(ctrl != step2) error_count = error_count + 1;
    err_in = 1;
    tik_tok;
    
    if(ctrl != idle) error_count = error_count + 1;
    
    //In idle state right now
    tik_tok; //S1
    tik_tok; //S2
    err_in = 0;
    lt = 0;
    tik_tok;
    
    if(ctrl != dec) error_count = error_count + 1;
    lt = 1;
    #2;
    
    if(ctrl != dec_lt) error_count = error_count + 1;
    tik_tok; //Should be in state 4
    
    if(ctrl != less_than) error_count = error_count + 1;
    lt = 0;
    tik_tok; //Back in S3
    tik_tok; //In S5
    
    if(ctrl != not_less_than) error_count = error_count + 1;
    cout = 0;
    tik_tok;
    
    if(ctrl != shift_right) error_count = error_count + 1;
    tik_tok;
    
    if(ctrl != finished) error_count = error_count + 1;
    tik_tok;
    
    if(ctrl != idle) error_count = error_count + 1;
    $display("Finished");
    $finish;
end
endmodule
