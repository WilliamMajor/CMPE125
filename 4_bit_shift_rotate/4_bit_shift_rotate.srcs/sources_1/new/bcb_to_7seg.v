`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2019 07:28:14 PM
// Design Name: 
// Module Name: bcb_to_7seg
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


module bcb_to_7seg(
        input  wire  BCB,
        output reg  [7:0] s
        );
        
    always @ (BCB) begin
        case (BCB)
                1'b0: s = 8'b11000000;
                1'b1: s = 8'b11111001;
            default: s = 8'b01111111;
        endcase
    end
endmodule
