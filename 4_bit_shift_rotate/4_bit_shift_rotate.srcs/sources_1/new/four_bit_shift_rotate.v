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


module four_bit_shift_rotate(Ctrl, NumIn, NumOut);

input       [2:0] Ctrl;
input       [3:0] NumIn;
output reg  [3:0] NumOut;

always @ (Ctrl, NumIn) begin
    case (Ctrl)
        3'b000: NumOut <= NumIn;                         //do nothing
        3'b001: NumOut <= {NumIn[2:0], 1'b0};            //shift by 1 bit
        3'b010: NumOut <= {NumIn[1:0], 2'b00};           //shift by 2 bits
        3'b011: NumOut <= {NumIn[0], 3'b000};            //shift by 3 bits
        3'b100: NumOut <= 4'b0000;                       //shift by 4 bits(all 0s)
        3'b101: NumOut <= {NumIn[2:0], NumIn[3]};        //rotate bits by 1
        3'b110: NumOut <= {NumIn[1:0], NumIn[3:2]};      // rotate bits by 2
        3'b111: NumOut <= {NumIn[0], NumIn[3:1]};        // rotate bits by 3
    endcase
end
        
endmodule
