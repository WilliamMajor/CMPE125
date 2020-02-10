`timescale 1ns / 1ps

module two_stage_pipeline_mult(A, B,Out_h, Out_l, clk, rst, en);

parameter       Width1 = 4;
parameter       Width2 = 8;
input           clk,rst, en;
input           [3:0]A, B;
output wire     [3:0]Out_l;
output wire     [3:0]Out_h;

wire [7:0]PP3, PP2, PP1, PP0, Sum1, Sum2,Q3 ,Q4, P, Out;
wire [3:0]AO1, AO2, AO3, AO4, Q1, Q2;

assign Out_l = Out[3:0];
assign Out_h = Out[7:4];

D_reg_clk #(Width1) D1(
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .d      (A),
    .q      (Q1)
    );
    
D_reg_clk #(Width1) D2(
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .d      (B),
    .q      (Q2)
    ); 

AND AND1 (
    .A      (Q1),
    .B      (Q2[0]),
    .AB     (AO1)
    );
    
AND AND2 (
    .A      (Q1),
    .B      (Q2[1]),
    .AB     (AO2)
    );
    
AND AND3 (
    .A      (Q1),
    .B      (Q2[2]),
    .AB     (AO3)
    );
    
AND AND4 (
    .A      (Q1),
    .B      (Q2[3]),
    .AB     (AO4)
    );
    
Shift_and_zero_pad SZP1 (
    .In     (AO1),
    .Out    (PP0),
    .Start  (4'd3)
    );
    
Shift_and_zero_pad SZP2 (
    .In     (AO2),
    .Out    (PP1),
    .Start  (4'd4)
    );
        
Shift_and_zero_pad SZP3 (
    .In     (AO3),
    .Out    (PP2),
    .Start  (4'd5)
    );
            
Shift_and_zero_pad SZP4 (
    .In     (AO4),
    .Out    (PP3),
    .Start  (4'd6)
    );
    
eight_bit_CLA_Adder EBCLA1 (
    .A      (PP0),
    .B      (PP1),
    .Sum    (Sum1)  
    );  
    
eight_bit_CLA_Adder EBCLA2 (
    .A      (PP2),
    .B      (PP3),
    .Sum    (Sum2)
    );
    

state_register SR1 (
    .In     (Sum1),
    .Out    (Q3),
    .clk    (clk)
    );

state_register SR2 (
    .In     (Sum2),
    .Out    (Q4),
    .clk    (clk)
    );
    
eight_bit_CLA_Adder EBCLA3 (
    .A      (Q3),
    .B      (Q4),
    .Sum    (P)
    );

    
D_reg_clk #(Width2) D5 (
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .d      (P),
    .q      (Out)
    );
    


endmodule
