`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 11:13:59 PM
// Design Name: 
// Module Name: FullCalc_tb
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


module FullCalc_tb;

reg [3:0] x, y;
reg [1:0] f;
reg go, clk;
wire [3:0] out_h, out_l;
wire done, error;
integer i, j, k;
integer mul;
integer error_count = 0;

FullCalc DUT(
        .x      (x),
        .y      (y),
        .f      (f), 
        .go     (go),
        .clk    (clk),
        .out_h  (out_h),
        .out_l  (out_l),
        .done   (done),
        .error  (error)
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
    clk = 0;
    go = 1;
    f = 0;
    x = 0;
    y = 0;
    for (i = 0; i < 4; i = i + 1)
    begin
        f = i;
        for(j = 0; j < 16; j = j + 1)
        begin
            x = j;
            for(k = 0; k < 16; k = k + 1)
            begin
                y = k;
                while(!done) tick_tock;
                mul = j * k;
                case(f)
                    2'b00: if (out_l != x + y) error_count = error_count + 1;
                    2'b01: if (out_l != x - y) error_count = error_count + 1;
                    2'b10: if ((out_h != mul[7:4]) && (out_l != mul[3:0])) error_count = error_count + 1;
                    2'b11: if ((out_h != x % y) && (out_l != x / y)) error_count = error_count + 1;
                endcase
                tick_tock;
            end //y-loop
        end //x-loop
    end //f-loop
$display("finished");
$finish;
end //initial
endmodule
