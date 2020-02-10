`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 10:51:31 PM
// Design Name: 
// Module Name: comparator
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


module comparator #(parameter data_width = 4)(
        input   wire [data_width-1 : 0] a, b,
        output  wire lessThan
    );
    assign lessThan = (a < b) ? 1 : 0;
    
endmodule
