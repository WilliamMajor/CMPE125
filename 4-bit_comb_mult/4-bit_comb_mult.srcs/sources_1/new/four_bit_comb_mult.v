`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2019 05:56:56 PM
// Design Name: 
// Module Name: four_bit_comb_mult
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


module four_bit_comb_mult(A, B, P);

input           [3:0]A, B;
output wire      [7:0]P;

wire [7:0]PP3, PP2, PP1, PP0, Sum1, Sum2;
wire [3:0]AO1, AO2, AO3, AO4;

AND AND1 (
    .A      (A),
    .B      (B[0]),
    .AB     (AO1)
    );
    
AND AND2 (
    .A      (A),
    .B      (B[1]),
    .AB     (AO2)
    );
    
AND AND3 (
    .A      (A),
    .B      (B[2]),
    .AB     (AO3)
    );
    
AND AND4 (
    .A      (A),
    .B      (B[3]),
    .AB     (AO4)
    );
    
Shift_and_zero_pad SZP1 (
    .In     (AO1),
    .Out    (PP0),
    .Start  (4'd3)
    );
    
Shift_and_zero_pad SZP2 (
    .In     (AO2),
    .Out    (PP1),
    .Start  (4'd4)
    );
        
Shift_and_zero_pad SZP3 (
    .In     (AO3),
    .Out    (PP2),
    .Start  (4'd5)
    );
            
Shift_and_zero_pad SZP4 (
    .In     (AO4),
    .Out    (PP3),
    .Start  (4'd6)
    );
    
eight_bit_CLA_Adder EBCLA1 (
    .A      (PP0),
    .B      (PP1),
    .Sum    (Sum1)  
    );  
    
eight_bit_CLA_Adder EBCLA2 (
    .A      (PP2),
    .B      (PP3),
    .Sum    (Sum2)
    );
    
eight_bit_CLA_Adder EBCLA3 (
    .A      (Sum1),
    .B      (Sum2),
    .Sum    (P)
    );        
endmodule
