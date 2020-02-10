`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 10:39:15 PM
// Design Name: 
// Module Name: Multiplier
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


module Multiplier(
        input [3:0] x, y,
        output [3:0] ph, pl
    );
reg [7:0] product;

always@(x, y) product = x*y;

assign ph = product[7:4];
assign pl = product[3:0];
endmodule