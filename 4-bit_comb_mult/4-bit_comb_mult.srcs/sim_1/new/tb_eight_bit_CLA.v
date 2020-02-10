`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2019 04:24:14 PM
// Design Name: 
// Module Name: tb_eight_bit_CLA
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


module tb_eight_bit_CLA;

reg     [7:0]A, B;
wire    [7:0]Sum;


eight_bit_CLA_Adder DUT (
    .A      (A),
    .B      (B),
    .Sum    (Sum)
    );
 
 reg [15:0] idx;
 reg [7:0] error = 0;
 reg [7:0] expected;

initial begin
for (idx = 16'b0000000000000000; idx < 16'b0111111111111111; idx = idx + 1)begin
        A = idx[7:0];
        B = idx[15:8];
        #0.00001;
        expected = (A + B);
        #0.00010;
        if (A + B != Sum) error = error + 1;
        #50;
//A = 8'b00001100;
//B = 8'b00011000;
//#50;

end


$display ("Simulation Fnished");
$finish;

end

endmodule
