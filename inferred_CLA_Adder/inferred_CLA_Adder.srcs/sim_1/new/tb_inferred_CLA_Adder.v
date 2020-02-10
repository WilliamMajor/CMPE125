`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 03:50:49 PM
// Design Name: 
// Module Name: tb_inferred_CLA_Adder
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


module tb_inferred_CLA_Adder;

reg [3:0] A, B;
wire [3:0]s;

inferred_CLA_Adder DUT (
    .A      (A),
    .B      (B),
    .s      (s)
    );
reg [8:0] idx;
reg overflow;
initial begin
    for (idx  = 0; idx < 9'b011111111; idx = idx + 1)begin
        A = idx[7:4];
        B = idx[3:0];
        if (s < A && s < B) overflow = 1; else overflow = 0;
        #5;
    end
$display("Simulation Finished");
$finish;
end
    
endmodule
