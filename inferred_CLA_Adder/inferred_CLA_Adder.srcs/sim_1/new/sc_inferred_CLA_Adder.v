`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 04:40:40 PM
// Design Name: 
// Module Name: sc_inferred_CLA_Adder
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


module sc_inferred_CLA_Adder;

reg [3:0] A, B, expected_out;
wire [3:0]s;
reg [4:0] error_count = 0;

inferred_CLA_Adder DUT (
    .A      (A),
    .B      (B),
    .s      (s)
    );
reg [8:0] idx;
reg overflow;
initial begin
    for (idx  = 0; idx <= 9'b011111111; idx = idx + 1)begin
        A = idx[7:4];
        B = idx[3:0];
         #0.0000001;
        expected_out = A + B;
        if (s < A && s < B) overflow = 1; else overflow = 0;
        if (s != expected_out) error_count = error_count + 1; 
        #0.05;
    end
$display("Simulation Finished");
$finish;
end
    
endmodule
