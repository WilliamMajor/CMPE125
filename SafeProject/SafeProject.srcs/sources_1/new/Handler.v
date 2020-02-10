`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2019 04:45:12 AM
// Design Name: 
// Module Name: Handler
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


module Handler(A, OP, Out_h, Out_l);

    input   [3:0] A;
    input   [1:0] OP;
    output  [3:0] Out_h, Out_l;
    
    reg [7:0] Out;
    
    parameter 
        op0 = 2'b00,
        op1 = 2'b01,
        op2 = 2'b10;
    
    assign Out_l = Out[3:0];
    assign Out_h = Out[7:4];
    
always @ (OP, A) begin
    case (OP)
        op0: Out = A + 1;
        op1: Out = A - 1;
        op2: Out = A * A;
    endcase
 end
        

endmodule
