`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2019 10:35:35 PM
// Design Name: 
// Module Name: priority_encoder_fpga
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


module priority_encoder_fpga(
        input   wire            clk100MHz,
        input   wire            rst,
        input   [7:0]           A,
        output  [7:0]           A_led,
        output  wire [3:0]      LEDSEL,
        output  wire [7:0]      LEDOUT
    );
    parameter A_width = 8, Y_width = 4;
    
    assign A_led = A;

    
    supply1[7:0] vcc;
    
    wire DONT_USE;
    wire clk_5KHz;
 
    wire [Y_width - 1 : 0]  sw_out;
    wire [7:0]              Number;
    wire                    Valid;
    
    priority_encoder_casez PECZ (
        .A      (A),
        .Y      (sw_out),
        .Valid  (Valid)
    );
    
    clk_gen CLK (
        .clk100MHz  (clk100MHz), 
        .rst        (rst), 
        .clk_4sec   (DONT_USE),
        .clk_5KHz   (clk_5KHz)
    );
    
    bcd_to_7seg BCD (
        .BCD        (sw_out),
        .s          (Number)
    );
        
    led_mux LED (
        .clk        (clk_5KHz), 
        .rst        (rst),
        .LED3       (vcc),
        .LED2       (vcc),
        .LED1       (vcc),
        .LED0       (Number),
        .LEDSEL     (LEDSEL),
        .LEDOUT     (LEDOUT)
    );
    
         
endmodule
