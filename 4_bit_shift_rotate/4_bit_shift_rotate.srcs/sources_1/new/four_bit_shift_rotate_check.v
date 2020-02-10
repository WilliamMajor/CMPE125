`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2019 09:30:43 PM
// Design Name: 
// Module Name: four_bit_shift_rotate
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


module four_bit_shift_rotate_check(Ctrl, NumIn, Expected);

input       [2:0] Ctrl;
input       [3:0] NumIn;
output reg  [3:0] Expected;

always @ (Ctrl, NumIn) begin
    case (Ctrl)
        3'b000: Expected = NumIn;                         //do nothing
        3'b001: Expected = NumIn >> 1;                    //shift by 1 bit
        3'b010: Expected = NumIn >> 2;                    //shift by 2 bits
        3'b011: Expected = NumIn >> 3;                    //shift by 3 bits
        3'b100: Expected = NumIn >> 4;                    //shift by 4 bits(all 0s)
        3'b101: Expected = {NumIn >> 1, NumIn[3]};        //rotate bits by 1
        3'b110: Expected = {NumIn >> 2, NumIn[3:2]};      // rotate bits by 2
        3'b111: Expected = {NumIn >> 3, NumIn[3:1]};        // rotate bits by 3
    endcase
end
        
endmodule

