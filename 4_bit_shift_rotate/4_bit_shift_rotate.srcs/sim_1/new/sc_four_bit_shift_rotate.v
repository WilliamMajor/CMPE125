`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2019 09:56:45 PM
// Design Name: 
// Module Name: sc_four_bit_shift_rotate
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


module sc_four_bit_shift_rotate;

reg  [2:0] Ctrl;
reg  [3:0] NumIn;
wire [3:0] NumOut;
reg  [3:0] Expected;

four_bit_shift_rotate DUT (
    .Ctrl   (Ctrl),
    .NumIn  (NumIn),
    .NumOut (NumOut)
    );
    
    integer idx;
    integer error_count = 0;
    

    initial begin
    
    NumIn <= 4'b1101;
    for (idx = 0; idx <= 3'b111; idx = idx + 3'b001) begin
        Ctrl = idx;
        
        case (Ctrl)
            3'b000: begin
            #5;
                        Expected <= NumIn;
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
        
            3'b001: begin
                        Expected <= NumIn << 1;
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
            3'b010: begin
                        Expected <= NumIn << 2;
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
            3'b011: begin
                        Expected <= NumIn << 3;
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
            3'b100: begin
                        Expected <= NumIn << 4;
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
                    
            3'b101: begin
                        Expected <= {NumIn[2:0], NumIn[3]};
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
            3'b110: begin
                        Expected <= {NumIn[1:0] , NumIn[3:2]};
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
            3'b111: begin
                        Expected <= {NumIn[0], NumIn[3:1]};
                        if (NumOut != Expected) error_count <= error_count + 1;
                        #50;
                    end
                      
        endcase
    end
    $display ("Simulation Finished");
    $finish;
    end
    
endmodule
