`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2019 05:58:53 PM
// Design Name: 
// Module Name: Shift_and_zero_pad
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


module Shift_and_zero_pad(In,Out,Start);

    input       [3:0]In;
    input       [3:0]Start;
    output reg  [7:0]Out = 0;
always @ (In, Start) begin
        case(Start)//I've now realized this can be done with shifts oh well... lol
            4'd3 : begin
                    Out[7:4] <= 4'b0000;
                    Out[3:0] <= In; end
            4'd4 : begin
                    Out[7:5] <= 3'b000;
                    Out[4:1] <= In;
                    Out[0]   <= 1'b0; end
            4'd5 : begin
                    Out[7:6] <= 2'b00;
                    Out[5:2] <= In;
                    Out[1:0] <= 1'b0; end
            4'd6 : begin
                    Out[7]   <= 1'b0;
                    Out[6:3] <= In;
                    Out[2:0] <= 3'b000; end
        endcase
    end
endmodule
