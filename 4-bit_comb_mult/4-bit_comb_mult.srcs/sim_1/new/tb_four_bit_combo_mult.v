`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2019 10:11:05 PM
// Design Name: 
// Module Name: tb_four_bit_combo_mult
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


module tb_four_bit_combo_mult;

reg     [3:0]A, B;
wire    [7:0]P;

four_bit_comb_mult DUT (
    .A      (A),
    .B      (B),
    .P      (P)
    );
    
reg [8:0] AB;
reg [8:0] Error = 0;
reg [7:0] expected_out;
initial begin
for(AB = 9'b000000000; AB <= 9'b011111111; AB = AB + 9'b000000001)begin
        A = AB[7:4];
        B = AB[3:0];
        #0.00001;
        expected_out = (A*B);
        #0.002;
        if (P != expected_out) Error = Error + 1;
        #0.5;
        
end


$display ("Simulation Fnished");
$finish;

end
    
endmodule
