`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2019 12:34:03 PM
// Design Name: 
// Module Name: regfile2
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


module regfile2(rd1, ra1, rd2, ra2, wd1, wa1, we1, wd2, wa2, we2, clk, err);

input       [3:0] ra1, ra2, wa1, wa2;
input       we1, we2, clk;
input       [31:0] wd1, wd2;
output      [31:0] rd1, rd2;
output reg   err;

reg[31:0] rf[31:0];
integer i;
integer test = 1;
initial begin
    for (i = 0; i < 32; i = i + 1)begin
        rf[i] = 0;
    end
end


always @ (wa1,wa2) begin
    if(wa2 == wa1)begin
        err = 1;
    end
    else begin
        err = 0;
    end
end

always @ (posedge clk) begin

        if(we2) rf[wa2] <= wd2;
        if(we1) rf[wa1] <= wd1;  
end

assign rd1 = ((ra1 != 0) && test) ? rf[ra1] : 0;
assign rd2 = ((ra2 != 0) && test) ? rf[ra2] : 0;

endmodule
