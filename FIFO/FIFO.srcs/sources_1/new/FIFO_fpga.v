`timescale 1ns / 1ps

module FIFO_fpga(
    input   clk100MHz, rst, rw, en, push_button_input,
    input   [7:0]D_in,
    output  full, empty, en_led, rw_led,
    output  [7:0] D_in_led,
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
wire [7:0]  D_out;
wire [3:0]  Hundreds, Tens, Ones;

assign D_in_led = D_in;
assign en_led = en;
assign rw_led = rw;

FIFO FIFO(
    .D_in   (D_in),
    .D_out  (D_out),
    .empty  (empty),
    .full   (full),
    .clk    (debounced_clock_signal),
    .rst    (rst),
    .rw     (rw),
    .enable (en)
    );
    
clk_gen CLK (
    .clk100MHz  (clk100MHz), 
    .rst        (rst), 
    .clk_4sec   (DONT_USE),
    .clk_5KHz   (clk_5KHz)
    );
     
 eight_bit_binary_to_decimal EBBD (
     .number     (D_out),
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
    .clk                (clk_5KHz), 
    .button             (push_button_input),
    .debounced_button   (debounced_clock_signal)
    );

endmodule
