`timescale 1ns / 1ps
module Multiplier(
    input [3:0] x, y,
    output [3:0] ph, pl
    );

reg [7:0] product;

always@(x, y) product = x*y;

assign ph = product[7:4];
assign pl = product[3:0];

endmodule