`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 10:37:11 PM
// Design Name: 
// Module Name: four_bit_CLA_Adder_fpga
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


module four_bit_CLA_Adder_fpga(
        input   [3:0] A, B,
        input         clk100MHz, rst, Carry_in,
        output  [3:0] A_led, B_led,
        output  [3:0] LEDSEL,
        output  [7:0] LEDOUT
);


supply1 [7:0] vcc;

wire        DONT_USE;
wire        clk_5KHz;
wire [3:0]  P, G;
wire [7:0]  out_display0;
wire [7:0]  out_display1;
wire [7:0]  out_displayCarryIn;
wire [7:0]  out_displayCarryOut;
wire [4:0]  Cout;
wire [3:0]  Sum;

assign A_led = A;
assign B_led = B;

four_bit_CLA_Adder FBCA (
    .A      (A),
    .B      (B),
    .Cin    (Carry_in),
    .Cout   (Cout),
    .Sum    (Sum)
);
clk_gen CLK (
    .clk100MHz  (clk100MHz), 
    .rst        (rst), 
    .clk_4sec   (DONT_USE),
    .clk_5KHz   (clk_5KHz)
 );
 
  bcd_to_7seg BCD (
         .BCD     (Sum),
         .s0      (out_display1),
         .s1      (out_display0)  
 );
     
 bcb_to_7seg BCB (
         .BCB   (Carry_in),
         .s     (out_displayCarryIn)
 );
 
 bcb_to_7seg BCB2 (
          .BCB   (Cout[4]),
          .s     (out_displayCarryOut)
  );
 
 led_mux LED (                      //get binary to work here...
      .clk        (clk_5KHz), 
      .rst        (rst),
      .LED3       (out_displayCarryIn),
      .LED2       (out_displayCarryOut),
      .LED1       (out_display0),
      .LED0       (out_display1),
      .LEDSEL     (LEDSEL),
      .LEDOUT     (LEDOUT)
  );


endmodule
