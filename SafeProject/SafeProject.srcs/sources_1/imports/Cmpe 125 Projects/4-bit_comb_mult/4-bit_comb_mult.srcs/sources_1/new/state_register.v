`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 06:58:24 PM
// Design Name: 
// Module Name: state_register
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


module state_register(In, Out, clk);

input       clk;
input       [7:0] In;
output reg  [7:0] Out;

always @ (posedge clk)begin
    Out <= In;
    
end

endmodule
