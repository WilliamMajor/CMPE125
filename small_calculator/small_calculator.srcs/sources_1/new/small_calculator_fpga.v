`timescale 1ns / 1ps

module small_calculator_fpga(
    input   clk100MHz, go, rst, push_button_input,
    input   [1:0] op,
    input   [3:0] A_in, B_in,
    output  go_led, neg_led, done_led,
    output  [1:0] op_led,
    output  [2:0] CS_led,
    output  [3:0] LEDSEL, A_in_led, B_in_led,
    output  [7:0] LEDOUT

    );
    
supply1 [7:0] vcc;

wire        DONT_USE;
wire        clk_5KHz;

wire        debounced_clock_signal, done, neg;
wire [7:0]  out_display0;
wire [7:0]  out_display1;
wire [7:0]  out_display2;
wire [2:0]  CS;
wire [3:0]  Hundreds, Tens, Ones, out;

assign go_led = go;
assign op_led = op;
assign CS_led = CS;
assign A_in_led = A_in;
assign B_in_led = B_in;
assign neg_led = neg;
assign done_led = done;

small_calculator SMCAL (
    .clk    (debounced_clock_signal),
    .go     (go),
    .op     (op),
    .in1    (A_in),
    .in2    (B_in),
    .out    (out),
    .CS     (CS),
    .done   (done),
    .neg    (neg)
    );

clk_gen CLK (
    .clk100MHz  (clk100MHz), 
    .rst        (rst), 
    .clk_4sec   (DONT_USE),
    .clk_5KHz   (clk_5KHz)
    );


eight_bit_binary_to_decimal EBBD (
     .number     (out),
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
