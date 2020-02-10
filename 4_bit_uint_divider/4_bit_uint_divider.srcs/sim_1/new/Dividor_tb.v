`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 12:07:54 AM
// Design Name: 
// Module Name: Dividor_tb
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


module Divider_tb;

reg go, clk, rst;
reg [3:0] in1, in2;
wire done, error;
wire [3:0] Quotient, Remainder;
integer i, j;
integer error_count = 0;
Divider DUT(in1, in2, clk, go, rst, Quotient, Remainder, done, error);

task tick_tock;
begin
    clk = 0;
    #0.5;
    clk = 1;
    #0.5;
    clk = 0;
end
endtask

initial
begin
    clk = 0;
    go = 1;
    rst = 1;
    tick_tock;
    rst = 0;
    for(i = 2; i < 16; i = i + 1)
    begin
        for(j = 2; j < 16; j = j + 1)
        begin
            in1 = i;
            in2 = j;
            if(j == 0)begin while(!error) tick_tock; end
            else
            begin
                while(!done)begin tick_tock; end
                if(Quotient != (in1 / in2) || Remainder != (in1 % in2)) error_count = error_count + 1;
                tick_tock;
            end     
        end//end for inner
    end//end for outer
$display("Test Finished");
$finish;
end//end initial
endmodule
