`timescale 1ns / 1ps
module DP(
    input wire[3:0] in1, in2,
    input wire[2:0] cin,
    input wire s1, s2, x_lsb,
    input wire sl_r, sr_r, sl_x,
    input wire rst, clk, ce,
    input wire ld_r, ld_x, ld_y, ld_c,
    output wire[3:0] quo, rem,
    output wire cout, lt, err
);
//Power and ground for setting high and low
supply0 gnd;
supply1 vcc;

wire X_to_R;
wire [3:0] R_out, X_out, Y_out, count_to_or;
wire [3:0] R_in;

//Connecting MSB of X to rightin port of R
assign X_to_R = X_out[3];

//Initializing all shift registers
ShftReg #5 R(
        .CLK        (clk),
        .RST        (rst),
        .SL         (sl_r),
        .SR         (sr_r),
        .LD         (ld_r),
        .LeftIn     (gnd),
        .RightIn    (X_to_R),
        .D          ({0, R_in}),
        .Q          (R_out)
    );
    
ShftReg  X(
        .CLK        (clk),
        .RST        (rst),
        .SL         (sl_x),
        .SR         (gnd),
        .LD         (ld_x),
        .LeftIn     (gnd),
        .RightIn    (x_lsb),
        .D          (in1),
        .Q          (X_out)
    );
        
ShftReg  Y(
        .CLK        (clk),
        .RST        (rst),
        .SL         (gnd),
        .SR         (gnd),
        .LD         (ld_y),
        .LeftIn     (gnd),
        .RightIn    (gnd),
        .D          (in2),
        .Q          (Y_out)
    );

//Comparator and subtract blocks
comparator comp(
        .A          (R_out),
        .B          (Y_out),
        .lt         (lt)
    );
    
subtract sub(
        .A          (R_out),
        .B          (Y_out),
        .out        (R_in)
    );

//Two muxes used for output control for remainder and quotient
MUX2 rem_ctrl(
        .in1        (R_out[3:0]),
        .in2        ({gnd, gnd, gnd, gnd}),
        .s2         (s1),
        .m2out      (rem)
    );
    
MUX2 quo_ctrl(
        .in1        (X_out),
        .in2        ({gnd, gnd, gnd, gnd}),
        .s2         (s2),
        .m2out      (quo)
    );

//Initializing up/down counter
UD_CNT_4 counter(
        .D          ({gnd, cin}),
        .LD         (ld_c),
        .UD         (gnd),
        .CE         (ce),
        .CLK        (clk),
        .RST_       (vcc),
        .Q          (count_to_or)
    );

//4 input NOR gate to check for divide by 0 error
nor4 error(
        .A          (Y_out[3]),
        .B          (Y_out[2]),
        .C          (Y_out[1]),
        .D          (Y_out[0]),
        .Y          (err)
    );


//4 input OR gate to check if counter is at 0
or4 count(
        .A          (count_to_or[3]),
        .B          (count_to_or[2]),
        .C          (count_to_or[1]),
        .D          (count_to_or[0]),
        .Y          (cout)
    );

endmodule