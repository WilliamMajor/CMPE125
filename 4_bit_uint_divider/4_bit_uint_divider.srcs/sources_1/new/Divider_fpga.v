`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 01:20:57 AM
// Design Name: 
// Module Name: Divider_fpga
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


module Divider_fpga(
    input   clk100MHz, go, rst, push_button_input,
    input   [3:0] A_in, B_in,
    output  go_led, done_led, error_led,
    output  [3:0] LEDSEL, A_in_led, B_in_led,
    output  [7:0] LEDOUT
    );
    
supply1 [7:0] vcc;

wire        DONT_USE;
wire        clk_5KHz;

wire        debounced_clock_signal, done, error;
wire [7:0]  out_display0;
wire [7:0]  out_display1;
wire [7:0]  out_display2;   
wire [7:0]  out_display3;
wire [3:0]  Hundreds1, Tens1, Ones1, Hundreds2, Tens2, Ones2, Quotient, Remainder;

assign go_led       = go;
assign A_in_led     = A_in;
assign B_in_led     = B_in;
assign done_led     = done;
assign error_led    = error;

Divider Div(
        .Dividend        (A_in),
        .Divisor        (B_in),
        .clk        (debounced_clock_signal),
        .go         (go),
        .rst        (rst),
        .Quotient   (Quotient),
        .Remainder  (Remainder),
        .done       (done),
        .error      (error)
    );
  
clk_gen CLK (
        .clk100MHz  (clk100MHz), 
        .rst        (rst), 
        .clk_4sec   (DONT_USE),
        .clk_5KHz   (clk_5KHz)
    );


eight_bit_binary_to_decimal EBBD1 (
        .number     (Quotient),
        .hundreds   (Hundreds1),
        .tens       (Tens1), 
        .ones       (Ones1)
    );
   
eight_bit_binary_to_decimal EBBD2 (
        .number     (Remainder),
        .hundreds   (Hundreds2),
        .tens       (Tens2), 
        .ones       (Ones2)
    );
   
bcd_to_7seg BCD (
        .BCD    (Tens1),
        .s      (out_display3)
    );

bcd_to_7seg BCD1 (
        .BCD    (Ones1),
        .s      (out_display2)
   );
   
bcd_to_7seg BCD2 (
       .BCD    (Tens2),
       .s      (out_display1)
   );

bcd_to_7seg BCD3 (
       .BCD    (Ones2),
       .s      (out_display0)
   );
   
led_mux LED (                      
      .clk        (clk_5KHz), 
      .rst        (rst),
      .LED3       (out_display3),
      .LED2       (out_display2),
      .LED1       (out_display1),
      .LED0       (out_display0),
      .LEDSEL     (LEDSEL),
      .LEDOUT     (LEDOUT)
    );

button_debouncer #64 DEBOUNCER(
      .clk                (clk_5KHz), 
      .button             (push_button_input),
      .debounced_button   (debounced_clock_signal)
    );

endmodule
