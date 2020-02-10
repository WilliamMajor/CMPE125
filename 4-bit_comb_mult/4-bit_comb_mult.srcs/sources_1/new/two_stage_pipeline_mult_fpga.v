`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:34:21 PM
// Design Name: 
// Module Name: two_stage_pipeline_mult_fpga
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


module two_stage_pipeline_mult_fpga(
    input   [3:0] A, B,
    input   clk100MHz, rst ,en , push_button_input,
    output  enable,
    output  [3:0] A_led, B_led,
    output  [3:0] LEDSEL,
    output  [7:0] LEDOUT
    );

supply1 [7:0] vcc;




wire        DONT_USE;
wire        clk_5KHz;

wire        debounced_clock_signal;
wire [7:0]  out_display0;
wire [7:0]  out_display1;
wire [7:0]  out_display2;
wire [7:0]  Sum;
wire [3:0]  Hundreds, Tens, Ones;

assign A_led = A;
assign B_led = B;
assign enable = en;

two_stage_pipeline_mult MLT(
    .A      (A),
    .B      (B),
    .Out    (Sum),
    .clk    (debounced_clock_signal),
    .rst    (rst),
    .en     (en)
    );    

clk_gen CLK (
    .clk100MHz  (clk100MHz), 
    .rst        (rst), 
    .clk_4sec   (DONT_USE),
    .clk_5KHz   (clk_5KHz)
 );
 
eight_bit_binary_to_decimal EBBD (
    .number     (Sum),
    .hundreds   (Hundreds),
    .tens       (Tens), 
    .ones       (Ones)
    );
    
bcd_to_7seg BCD (
    .BCD    (Hundreds),
    .s      (out_display2)
    );
    
bcd_to_7seg BCD1 (
    .BCD    (Tens),
    .s      (out_display1)
    );

bcd_to_7seg BCD2 (
    .BCD    (Ones),
    .s      (out_display0)
    );
     
 
 led_mux LED (                      
      .clk        (clk_5KHz), 
      .rst        (rst),
      .LED3       (vcc),
      .LED2       (out_display2),
      .LED1       (out_display1),
      .LED0       (out_display0),
      .LEDSEL     (LEDSEL),
      .LEDOUT     (LEDOUT)
  );

button_debouncer #64 DEBOUNCER(
.clk (clk_5KHz), 
.button (push_button_input),
.debounced_button (debounced_clock_signal)
);
endmodule
