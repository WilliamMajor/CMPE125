`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2019 12:42:11 PM
// Design Name: 
// Module Name: priority_encoder_for
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


module priority_encoder_for(A, Y, Valid);

input [7:0] A;
output reg [2:0] Y;
output reg Valid;

integer N;

always @ (A)
begin
    Valid = 0;
    Y = 3'bX; 
    for (N = 0; N < 8; N = N + 1)
    if(A[N])
        begin
            Valid = 1;
            Y = N;
        end
end
endmodule
