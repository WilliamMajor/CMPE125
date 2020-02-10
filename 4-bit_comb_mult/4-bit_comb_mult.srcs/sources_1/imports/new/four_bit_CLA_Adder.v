`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 06:12:29 PM
// Design Name: 
// Module Name: four_bit_CLA_Adder
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


module four_bit_CLA_Adder(A, B, Cin, Cout, Sum);

input wire [3:0] A, B;
input wire Cin;
output wire Cout;
output wire [3:0] Sum;

wire [3:0] P, G;
wire [2:0] CLA_out;


half_adder HA (
    .A      (A[0]),
    .B      (B[0]),
    .P      (P[0]),
    .G      (G[0])
);  
  
half_adder HA1 (
    .A      (A[1]),
    .B      (B[1]),
    .P      (P[1]),
    .G      (G[1])
);  

half_adder HA2 (
    .A      (A[2]),
    .B      (B[2]),
    .P      (P[2]),
    .G      (G[2])
);  

half_adder HA3 (
    .A      (A[3]),
    .B      (B[3]),
    .P      (P[3]),
    .G      (G[3])
);  

CLA CLA (
    .Cin    (Cin),
    .P      (P),
    .G      (G),
    .out    (CLA_out),
    .Cout   (Cout)
);

XOR XOR (
    .P      (P[0]),
    .Cout   (Cin),
    .Sum    (Sum[0])
);

XOR XOR1 (
    .P      (P[1]),
    .Cout   (CLA_out[0]),
    .Sum    (Sum[1])
);

XOR XOR2 (
    .P      (P[2]),
    .Cout   (CLA_out[1]),
    .Sum    (Sum[2])
);

XOR XOR3 (
    .P      (P[3]),
    .Cout   (CLA_out[2]),
    .Sum    (Sum[3])
);

endmodule

