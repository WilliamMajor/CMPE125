`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 10:56:51 PM
// Design Name: 
// Module Name: four_bit_uint_divider_DP
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


module four_bit_uint_divider_DP(
        input   wire [3:0] Dividend, Divisor,
        input   wire [2:0] cin,
        input   wire s1, s2, x_leftin, sl_remainder, sr_remainder, sl_x, rst, clk, ce, ld_remainder, ld_x, ld_y, ld_c,
        output  wire [3:0] Quotient, Remainder,
        output  wire cout, lessThan, err
    );
    
    
    wire X_to_R;
    wire [3:0] R_out, X_out, Y_out, count_to_or;
    wire [3:0] R_in;
    
    //Connecting MSB of X to rightin port of R
    assign X_to_R = X_out[3];
    //Initializing all shift registers
    
    ShftReg #5 R(
            .CLK        (clk),
            .RST        (rst),
            .SL         (sl_remainder),
            .SR         (sr_remainder),
            .LD         (ld_remainder),
            .LeftIn     (0),
            .RightIn    (X_to_R),
            .D          ({0, R_in}),
            .Q          (R_out)
            );
    
    ShftReg X(
            .CLK        (clk),
            .RST        (rst),
            .SL         (sl_x),
            .SR         (0),
            .LD         (ld_x),
            .LeftIn     (0),
            .RightIn    (x_leftin),
            .D          (Dividend),
            .Q          (X_out)
            );
            
    ShftReg Y(
            .CLK        (clk),
            .RST        (rst),
            .SL         (0),
            .SR         (0),
            .LD         (ld_y),
            .LeftIn     (0),
            .RightIn    (0),
            .D          (Divisor),
            .Q          (Y_out)
            );
   
    //Comparator and subtract blocks
    comparator comp(
            .a  (R_out),
            .b  (Y_out),
            .lessThan (lessThan)
        );
    
    subtractor sub(
            .a  (R_out),
            .b  (Y_out),
            .c  (R_in)
        );
    //Output control for remainder and quotient
     MUX2 rem_ctrl(
            .sel    (s1),
            .a      (R_out[3 : 0]),
            .b      ({0, 0, 0, 0}),
            .out    (Remainder)
        );
        
    MUX2 quo_ctrl(
            .sel    (s2),
            .a      (X_out),
            .b      ({0, 0, 0, 0}),
            .out    (Quotient)
        );
    
    //Initializing up/down counter
    ud_counter counter(
            .load   (ld_c),
            .updown (0),
            .enable (ce),
            .reset  (1),
            .clk    (clk),
            .D      ({0, cin}),
            .Q      (count_to_or)
        );
        
    //check if the counter is at 0
    or4 count(
            .a  (count_to_or[3]),
            .b  (count_to_or[2]),
            .c  (count_to_or[1]),
            .d  (count_to_or[0]),
            .y  (cout));

    //check for a divide by 0 case
    nor4 error(
            .a  (Y_out[3]),
            .b  (Y_out[2]),
            .c  (Y_out[1]),
            .d  (Y_out[0]),
            .y  (err)
        );
    
endmodule
