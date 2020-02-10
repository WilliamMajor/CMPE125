`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 05:11:57 PM
// Design Name: 
// Module Name: CLA
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


module CLA(Cin, P, G, out, Cout);

input wire          Cin;
input wire [3:0]    P, G;
output wire [2:0]    out;
output wire          Cout;

    assign out[0] = (G[0] | P[0] & Cin);                                                    
    assign out[1] = (G[1] | P[1] & G[0] | P[1] & P[0] & Cin);                               
    assign out[2] = (G[2] | P[2] & G[1] | P[2] & P[1] & G[0] | P[2] & P[1] & P[0] & Cin);   
    assign Cout   = (G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3] & P[2] & P[1] & G[0] | P[3] & P[2] & P[1] & P[0] & Cin);

endmodule