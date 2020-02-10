`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 10:34:34 PM
// Design Name: 
// Module Name: ud_counter
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


module ud_counter(
       input    wire load, updown, enable, reset, clk,
       input    wire [3:0] D,
       output   reg [3:0] Q
       
);

always @ (posedge clk, negedge reset) begin
    if(!reset) Q = 4'b0;
    else if(enable)
    begin
        if (load) Q = D;
        else if (updown) Q = Q + 4'b0001;
        else Q = Q - 4'b0001;
    end
    else Q = Q;
end
endmodule
