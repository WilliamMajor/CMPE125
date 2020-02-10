`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 04:43:20 PM
// Design Name: 
// Module Name: tb_D_reg_clock
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


module tb_D_reg_clock;
reg clk, rst, en;
reg [3:0]A, B;
wire [7:0]P;




reg [8:0] i;
reg [8:0] a;
reg [7:0] expected_out;
reg [7:0] error = 0;

two_stage_pipeline_mult DUT (
    .A      (A),
    .B      (B),
    .Out    (P),
    .clk    (clk),
    .rst    (rst),
    .en     (en)
    );


initial begin
    i = 0;
    rst = 1;
    #10;
    rst = 0;
    clk = 0;
    en = 0;
    #5;
    en = 1;
    #5
    forever
    begin
        clk <= !clk;
//        en <= 1;
        #5;
    end
end

always @ (negedge clk)
begin
    A <= i[7:4];
    B <= i[3:0];
    #0.00001;
  
end


always @ (posedge clk)
begin
    
    a = i-2;
    if( i < 2 ) a = 0;
    #0.0001;
    expected_out = (a[7:4] * a[3:0]);
    #0.5;
    if (expected_out != P) error = error +1;
    #1;
    if (i > 8'b11111111) 
    begin
        $display("Test Finished");
        $finish;
    end
    i = i + 1;
end


endmodule
