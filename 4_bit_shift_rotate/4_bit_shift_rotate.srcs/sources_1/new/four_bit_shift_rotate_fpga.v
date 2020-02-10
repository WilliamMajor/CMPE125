`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2019 05:58:38 PM
// Design Name: 
// Module Name: four_bit_shift_rotate_fpga
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


module four_bit_shift_rotate_fpga(
        input   wire            clk100MHz,
        input   wire            rst,
        input   [2:0]           Ctrl,
        output  [2:0]           Ctrl_led,
        input   [3:0]           NumIn,
        output  [3:0]           NumOut_led,
        output  wire [3:0]      LEDSEL,
        output  wire [7:0]      LEDOUT
);

    supply1[7:0] vcc;
    
    wire DONT_USE;
    wire clk_5KHz;
    wire [3:0] NumOut;
    wire [7:0] Number0;
    wire [7:0] Number1;
    wire [7:0] Number2;
    wire [7:0] Number3;
    
    //assign out = NumOut;
    assign NumOut_led = NumOut;
    assign Ctrl_led = Ctrl;
    
    four_bit_shift_rotate FBSR (
        .Ctrl   (Ctrl),
        .NumIn  (NumIn),
        .NumOut (NumOut)
    );
    
    clk_gen CLK (
            .clk100MHz  (clk100MHz), 
            .rst        (rst), 
            .clk_4sec   (DONT_USE),
            .clk_5KHz   (clk_5KHz)
     );
     bcb_to_7seg BCB1 (
         .BCB        (NumOut[3]),
         .s          (Number3)
     );
     
     bcb_to_7seg BCB2 (
          .BCB        (NumOut[2]),
          .s          (Number2)
      );
          
      bcb_to_7seg BCB3 (
           .BCB        (NumOut[1]),
           .s          (Number1)
       );
               
       bcb_to_7seg BCB4 (
            .BCB        (NumOut[0]),
            .s          (Number0)
        );
         
     led_mux LED (                      //get binary to work here...
         .clk        (clk_5KHz), 
         .rst        (rst),
         .LED3       (Number3),
         .LED2       (Number2),
         .LED1       (Number1),
         .LED0       (Number0),
         .LEDSEL     (LEDSEL),
         .LEDOUT     (LEDOUT)
     );
    
     
endmodule
