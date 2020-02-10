`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2019 06:32:22 PM
// Design Name: 
// Module Name: dp_tb_small_calculator
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


module dp_tb_small_calculator;
    reg     clk;
    wire    we, rea, reb, s2;
    reg     [3:0] in1, in2, testout;
    wire     [1:0] s1, wa, raa, rab, c;
    wire    [3:0] out;
    reg     [13:0] control;
    reg     [1:0] operation;
    
    integer idx;
    integer error_count = 0;
    
    small_calculator_dp DUT (
        .clk    (clk),
        .in1    (in1),
        .in2    (in2),
        .s1     (s1),
        .wa     (wa),
        .raa    (raa),
        .rab    (rab),
        .c      (c),
        .we     (we),
        .rea    (rea),
        .reb    (reb),
        .s2     (reb),
        .out    (out)
        );
        
task tick;
    begin
        clk = 1'b0;
        #1;
        clk = 1'b1;
        #1;
    end
endtask

parameter IDLE  = 15'b00_00_0_00_0_00_0_00_0,
          LOAD1 = 15'b01_01_1_00_0_00_0_00_0,
          LOAD2 = 15'b10_10_1_00_0_00_0_00_0,
          ADD   = 15'b11_11_1_01_1_10_1_00_0,
          SUB   = 15'b11_11_1_01_1_10_1_01_0,
          AND   = 15'b11_11_1_01_1_10_1_10_0,
          XOR   = 15'b11_11_1_01_1_10_1_11_0,
          DONE  = 15'b00_00_0_11_1_11_1_10_1;

initial begin
    error_count = 0;
    for (idx = 0; idx < 2 ** 10; idx = idx + 1) begin
        control = IDLE;
        tick;
        in1 = $urandom%8;
        in2 = $urandom%8;
        control = LOAD1;
        tick;
        control = LOAD2;
        tick;
        operation = $urandom%4;
        case (operation)
            2'b00: begin
                    control = ADD;
                    testout = in1 + in2;
                 end
            2'b01: begin
                    control = SUB;
                    testout = in1 - in2;
                end
            2'b10: begin
                    control = AND;
                    testout = in1 & in2;
                end
            2'b11: begin
                    control = XOR;
                    testout = in1 ^ in2;
                end
        endcase
        tick; 
        control = DONE;
        tick; 
        if (testout != out) error_count = error_count + 1;
        testout = 0;
    end
    $finish;     
end

assign {s1, wa, we, raa, rea, rab, reb, c, s2} = control;
        
       
        
endmodule
