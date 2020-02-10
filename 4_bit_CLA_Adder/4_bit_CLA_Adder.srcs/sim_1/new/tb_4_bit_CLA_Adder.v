`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 06:07:40 PM
// Design Name: 
// Module Name: tb_4_bit_CLA_Adder
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


module tb_4_bit_CLA_Adder;

reg [3:0] A, B;
reg Cin;
wire [4:0] Cout;
wire [3:0] Sum;

four_bit_CLA_Adder DUT(
    .A      (A),
    .B      (B),
    .Cin    (Cin),
    .Cout   (Cout),
    .Sum    (Sum)
    );
  
reg [8:0] AB;
reg [3:0] expected_out;
reg [3:0] error_count = 0;
reg       expected_carry_out;  
initial begin

    for(AB = 9'b000000000; AB <= 9'b011111111; AB = AB + 9'b000000001)begin
        A = AB[7:4];
        B = AB[3:0];
        Cin = 0;
        #0.00001;
        expected_out = A + B;
        #0.00001;
        if (expected_out < A && expected_out < B) expected_carry_out = 1; else expected_carry_out = 0;
        #0.000001;
        if (Sum != expected_out) error_count = error_count + 1;
        #0.000001;
        if (Cout[4] != expected_carry_out) error_count = error_count + 1;      
        #0.5;
    end

$display ("Simulation Finished");
$finish;

end

endmodule
