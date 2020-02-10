`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2019 12:42:11 PM
// Design Name: 
// Module Name: priority_encoder_casez
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


module priority_encoder_casez(A, Y, Valid);


input       [7:0]A;
output reg  [3:0]Y;
output reg  Valid;

always @ (A)
begin
    Valid <= 1;
    casez (A)
        8'b1???????: Y <= 7;
        8'b01??????: Y <= 6;
        8'b001?????: Y <= 5;
        8'b0001????: Y <= 4;
        8'b00001???: Y <= 3;
        8'b000001??: Y <= 2;
        8'b0000001?: Y <= 1;
        8'b00000001: Y <= 0;
        default:
            begin
                Valid <= 0;
                Y = 3'bX;
            end
    endcase
end
endmodule


