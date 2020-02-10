`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 10:58:57 PM
// Design Name: 
// Module Name: shift_register
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



module ShftReg (CLK, RST, SL, SR, LD, LeftIn, RightIn, D, Q);
    parameter Data_width = 4;
    
    input wire CLK, RST, SL, SR, LD, LeftIn, RightIn;
    input wire [Data_width-1:0] D;
    output reg [Data_width-1:0] Q;
always @(posedge CLK)
begin
    if (RST) Q = 0;
    else if (LD) Q = D;
    else if (SL) // shift left
    begin
    Q [Data_width-1:1] = Q [Data_width-2:0];
    Q [0] = RightIn;
    end
    else if (SR) // shift right
    begin
    Q [Data_width-2:0] = Q [Data_width-1:1];
    Q [Data_width -1] = LeftIn;
    end
    else Q [Data_width-1:0] = Q [Data_width-1:0];
end
endmodule