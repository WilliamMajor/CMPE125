`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2019 06:22:13 PM
// Design Name: 
// Module Name: eight_bit_CLA_Adder
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


module eight_bit_CLA_Adder(A, B, Sum);

    input wire [7:0]A, B;
    output wire [7:0] Sum;
     
    wire Cout;
    wire Cout_to_cin;
    
    
    four_bit_CLA_Adder FBCLA (
        .A      (A[3:0]),
        .B      (B[3:0]),
        .Cin    (1'b0),
        .Cout   (Cout_to_cin),
        .Sum    (Sum[3:0])
        );
        
    four_bit_CLA_Adder FBCLA1 (
        .A      (A[7:4]),
        .B      (B[7:4]),
        .Cin    (Cout_to_cin),
        .Cout   (Cout),
        .Sum    (Sum[7:4])
        );
        
endmodule
