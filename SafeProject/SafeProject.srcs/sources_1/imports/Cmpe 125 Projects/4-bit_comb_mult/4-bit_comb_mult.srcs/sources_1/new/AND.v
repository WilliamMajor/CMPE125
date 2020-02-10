`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2019 03:59:21 PM
// Design Name: 
// Module Name: AND
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


module AND( A, B, AB);

input [3:0]A;
input B;
output reg [3:0] AB;

always @ (A,B) begin
    AB[0] <= A[0] & B;
    AB[1] <= A[1] & B;
    AB[2] <= A[2] & B;
    AB[3] <= A[3] & B;
end
    
endmodule
