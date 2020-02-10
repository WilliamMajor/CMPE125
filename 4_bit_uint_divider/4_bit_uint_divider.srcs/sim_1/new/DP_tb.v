`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 08:21:58 PM
// Design Name: 
// Module Name: DP_tb
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


module DP_tb;

reg     clk;
reg     [3:0] in1, in2;
reg     [2:0] cin;
reg     s1, s2, x_lsb, sl_r, sr_r, sl_x, rst, ce, ld_r, ld_x, ld_y, ld_c;
wire    [3:0] quo, rem;
wire    lt, err, cout;
integer i, error_count = 0;

four_bit_uint_divider_DP DUT(
        .Dividend   (in1),
        .Divisor    (in2),
        .cin        (cin),
        .s1         (s1),
        .s2         (s2),
        .x_lsb      (x_lsb),
        .sl_r       (sl_r),
        .sr_r       (sr_r),
        .sl_x       (sl_x),
        .rst        (rst),
        .clk        (clk),
        .ce         (ce),
        .ld_r       (ld_r),
        .ld_x       (ld_x),
        .ld_y       (ld_y),
        .ld_c       (ld_c),
        .Quotient   (quo),
        .Remainder  (rem),
        .cout       (cout),
        .lt         (lt),
        .err        (err)
    );

task tick_tock;
begin
    clk = 0;
    #2;
    clk = 1;
    #2;
    clk = 0;
end
endtask
           
initial
begin
    rst = 1;
    clk = 0;
    ce = 0;
    cin = 2'b00;
    s1 = 0;
    s2 = 0;
    x_lsb = 0;
    sl_x = 0;
    sl_r = 0;
    sr_r = 0;
    ld_r = 0;
    ld_x = 1;
    ld_y = 1;
    ld_c = 0;
    
    tick_tock;
    
    in1 = 4'b1111;
    in2 = 4'b0110;
    rst = 0;
    
    tick_tock;
    
    ld_x = 0;
    ld_x = 0;
    sl_r = 1;
    sl_x = 1;
    
    tick_tock;
    
    for( i = 3; i >= 0; i = i - 1)
    begin
        if(lt)
        begin
            x_lsb   = 0;
            sl_r    = 1;
            sl_x    = 1;
            tick_tock;
        end
        else
        begin
            ld_r = 1;
            sl_r = 0;
            sl_x = 0;
            tick_tock;
            
            ld_r = 0;
            x_lsb = 1;
            sl_r = 1;
            sl_x = 1;
            tick_tock;
        end
    end
    
    x_lsb   = 0;
    ld_r    = 0;
    sl_r    = 0;
    sl_x    = 0;
    sr_r    = 1;
    s1      = 1;
    s2      = 1;
    tick_tock;
    
    if(quo != 4'b0010 || rem != 4'b0011) $display("Divide error");
    
   //Check error flag
    in2 = 4'b0000;
    ld_y = 1;
    tick_tock;
    if(!err) $display("Error error");
    //Check counter
    cin = 3'b011;
    ce = 1;
    ld_c = 1;
    tick_tock; //clock should be at 3
    ld_c = 0;
    ce = 0;
    tick_tock; //clock should still be at 3
    if(!cout) $display("Clock enable failed");
    ce = 1;
    tick_tock; //clock should be at 2
    tick_tock; //clock should be at 1
    tick_tock; //clock should be at 0
    if(cout) $display("Clock count down failed");
    $display("Finished");
    $finish;
end //end initial
endmodule
