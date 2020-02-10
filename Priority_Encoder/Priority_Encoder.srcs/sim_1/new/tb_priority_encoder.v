`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2019 02:23:13 PM
// Design Name: 
// Module Name: tb_priority_encoder
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


module tb_priority_encoder;
        
        parameter A_width = 8, Y_width = 3;

        reg  [A_width - 1  : 0] tb_in;
        wire [Y_width - 1 : 0] tb_out;
        wire valid_tb;

    priority_encoder_casez DUT (
        .A(tb_in),
        .Y(tb_out),
        .Valid(valid_tb)
        );

    initial begin
        tb_in = 8'b10000000; #50;
        tb_in = 8'b01000000; #50;
        tb_in = 8'b01100000; #50;
        tb_in = 8'b00100000; #50;
        tb_in = 8'b00010000; #50;
        tb_in = 8'b00001000; #50;
        tb_in = 8'b00000100; #50;
        tb_in = 8'b00000010; #50;
        tb_in = 8'b00000001; #50;
        tb_in = 8'b00000000; #50;
        $display ("Simulation Finished");
        $stop; #20;
        $finish;
    end

endmodule
