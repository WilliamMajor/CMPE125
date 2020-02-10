`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2019 08:03:07 PM
// Design Name: 
// Module Name: sc_tb_priority_encoder
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


module sc_tb_priority_encoder;
        
        parameter A_width = 8, Y_width = 3;

        reg  [A_width - 1  : 0] tb_in;
        wire [Y_width - 1 : 0] tb_out;
        wire valid_tb;
        

    priority_encoder_casez DUT (
        .A(tb_in),
        .Y(tb_out),
        .Valid(valid_tb)
        );
        
        integer  idx;
        integer  pos;
        integer  first = 0;
        integer error_count = 0;

    initial begin
        
        tb_in = 8'b00000000;
        for (idx = 0; idx < 2 ** 8; idx = idx + 1)begin
                for (pos = 7; pos >= 0; pos = pos -1)begin
                    if( tb_in[pos] == 1) begin
                        first = pos;
                        pos = 0;
                    end                  
                end
            if (first != tb_out) begin
                error_count = error_count+1; 
            end
            tb_in = tb_in + 8'b00000001; # 1;
        end
            
            
        $display ("Simulation Finished");
        $finish;
    end
endmodule
