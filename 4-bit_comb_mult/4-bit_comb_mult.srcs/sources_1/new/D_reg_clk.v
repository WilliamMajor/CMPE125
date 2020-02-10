`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2019 03:59:21 PM
// Design Name: 
// Module Name: D_reg_clk
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


module D_reg_clk #(parameter Data_width = 8)(clk,rst,en,d,q);

    input       clk, rst, en;
    input       [Data_width - 1 : 0] d;
    output reg  [Data_width - 1 : 0] q;
    
    
    always @(posedge clk, posedge rst)
        if (rst) begin q <= 4'b0000; end
        else if(en)begin q <= d;end
        else begin q <= q; end
        
endmodule
