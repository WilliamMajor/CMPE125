`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2019 11:03:44 PM
// Design Name: 
// Module Name: four_bit_ALU_fpga
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


module four_bit_ALU_fpga(
        input   wire        clk100MHz, rst, m, s1, s0,
        input   [3:0]       A, B,
        output  [3:0]       out_led,
        output              zero_led, overflow_led, m_led, s1_led, s0_led,
        output  [3:0]       LEDSEL,
        output  [7:0]       LEDOUT
    );
    
    supply1[7:0] vcc;
    
    wire        DONT_USE;
    wire        clk_5KHz;
    wire [3:0]  out;
    wire [7:0]  out_display0;
    wire [7:0]  out_display1;
    wire [7:0]  out_display2;
    wire [7:0]  out_display3;
    wire        zero, overflow;
    
    assign out_led = out;
    assign m_led        = m;
    assign s1_led       = s1;
    assign s0_led       = s0;
    assign zero_led     = zero;
    assign overflow_led = overflow;
    
    four_bit_ALU FBALU (
        .m          (m),
        .s1         (s1),
        .s0         (s0),
        .A          (A),
        .B          (B),
        .out        (out),
        .zero       (zero),
        .overflow   (overflow)
        );
        
    clk_gen CLK (
        .clk100MHz  (clk100MHz), 
        .rst        (rst), 
        .clk_4sec   (DONT_USE),
        .clk_5KHz   (clk_5KHz)
     );
     bcb_to_7seg BCB1 (
         .BCB        (out[3]),
         .s          (out_display0)
     );
     
     bcb_to_7seg BCB2 (
          .BCB        (out[2]),
          .s          (out_display1)
      );
          
      bcb_to_7seg BCB3 (
           .BCB        (out[1]),
           .s          (out_display2)
       );
               
       bcb_to_7seg BCB4 (
            .BCB        (out[0]),
            .s          (out_display3)
        );
         
     led_mux LED (                      //get binary to work here...
         .clk        (clk_5KHz), 
         .rst        (rst),
         .LED3       (out_display0),
         .LED2       (out_display1),
         .LED1       (out_display2),
         .LED0       (out_display3),
         .LEDSEL     (LEDSEL),
         .LEDOUT     (LEDOUT)
             );
    
    
endmodule
