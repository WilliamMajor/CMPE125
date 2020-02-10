`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2019 02:29:05 PM
// Design Name: 
// Module Name: tb_FIFO
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


module tb_FIFO;

reg     clk, rst, rw, enable;
reg     [7:0] D_in;
wire    [7:0] D_out;
wire    full, empty;
reg     [7:0] idx;
integer count = 0;
integer counter = 9;
integer error_count = 0;

FIFO DUT (
    .D_in   (D_in),
    .D_out  (D_out),
    .empty  (empty),
    .full   (full),
    .clk    (clk),
    .rst    (rst),
    .rw     (rw),
    .enable (enable)
    );
    
initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    enable <= 1'b0;
    #5;
    enable <= 1'b1;
    rst <= 1'b0;
    forever
    begin
        clk <= !clk; 
        #2;
    end
end

initial begin
    rw <= 1'b0;
    idx <= 10;
    for (count = 0; count < 14; count = count +1)begin
        D_in <= idx[7:0];
        #5;
        idx = idx + 1;
    end 
    rw = 1'b1;
    #100;
    $finish;
end

always @ (D_out) begin
    #0.5;
    if (D_out == counter) error_count = error_count + 1;
    counter = counter + 1;
end

endmodule
