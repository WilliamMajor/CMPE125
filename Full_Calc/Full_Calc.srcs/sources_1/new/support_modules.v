`timescale 1ns / 1ps

module ShftReg (CLK, RST, SL, SR, LD, LeftIn, RightIn, D, Q);

parameter Data_width = 4;
input wire CLK, RST, SL, SR, LD, LeftIn, RightIn;
input wire [Data_width-1:0] D;
output reg [Data_width-1:0] Q;

always @(posedge CLK)
begin
    if (RST) Q = 0;
    else if (LD) Q = D;
    else if (SL) // shift left
    begin
        Q [Data_width-1:1] = Q [Data_width-2:0];
        Q [0] = RightIn;
    end
    else if (SR) // shift right
    begin
        Q [Data_width-2:0] = Q [Data_width-1:1];
        Q [Data_width -1] = LeftIn;
    end
    else Q [Data_width-1:0] = Q [Data_width-1:0];
end
endmodule

module comparator#(parameter data_width = 4)(
    input wire[data_width - 1:0] A, B,
    output wire lt
    );
    
assign lt = A < B;

endmodule

module subtract#(parameter data_width = 4)(
    input wire[data_width - 1:0] A, B,
    output wire[data_width - 1:0] out
    );
    
    assign out = A - B;
    
endmodule

//module mux2#(parameter data_width = 4)(
//    input wire[data_width - 1:0] A, B,
//    input wire sel,
//    output wire [data_width - 1:0] out
//    );
    
//assign out = sel ? A : B;

//endmodule

module nor4(
    input wire A, B, C, D,
    output wire Y
    );
    
assign Y = !(A|B|C|D);

endmodule

module or4(
    input wire A, B, C, D,
    output wire Y
    );
    
assign Y = A|B|C|D;

endmodule

module UD_CNT_4 (D, LD, UD, CE, CLK, RST_, Q);
input [3:0] D;
input wire LD, UD, CE, CLK, RST_;
output reg [3:0] Q;

always @ (posedge CLK, negedge RST_)
begin
    if (!RST_) Q = 4'b0;
    else if (CE)
    begin
        if (LD) Q = D;
        else if (UD) Q = Q + 4'b0001;
        else Q = Q - 4'b0001;
    end
    else Q = Q;
end
endmodule