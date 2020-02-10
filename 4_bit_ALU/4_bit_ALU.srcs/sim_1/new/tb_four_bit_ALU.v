`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2019 10:16:40 PM
// Design Name: 
// Module Name: tb_four_bit_ALU
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


module tb_four_bit_ALU;

reg m,s1,s0;
reg [3:0] A,B;
wire [3:0] out;
wire zero,overflow;

four_bit_ALU DUT(
    .m          (m),
    .s1         (s1),
    .s0         (s0),
    .A          (A),
    .B          (B),
    .out        (out),
    .zero       (zero),
    .overflow   (overflow)       
    );
    
    reg [3:0] idx;
    initial begin
     
            for(idx = 4'b0000; idx <= 4'b0111; idx = idx + 3'b0001)begin
                m   <= idx[2];
                s1  <= idx[1];
                s0  <= idx[0];
                A   <= 4'b1010;
                B   <= 4'b1101;
                #5;
            end 
        $display ("Simulation Finished");
        $finish; 
        end  

endmodule
