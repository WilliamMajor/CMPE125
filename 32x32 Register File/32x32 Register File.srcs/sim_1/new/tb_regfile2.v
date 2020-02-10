`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2019 12:54:50 PM
// Design Name: 
// Module Name: tb_regfile2
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


module tb_regfile2;

wire     [3:0] ra1, ra2;
reg     [3:0] wa1, wa2;
reg     we1, we2, clk;
reg     [31:0] wd1, wd2;
reg     [4:0] idx1, idx2;
reg     [32:0] idx3, idx4;
wire    [31:0] rd1, rd2;
wire    err;
integer count = 0;
integer count1 = 0;
integer error_count = 0;
reg     testing = 0;

regfile2 DUT(
    .rd1    (rd1),
    .ra1    (ra1),
    .rd2    (rd2),
    .ra2    (ra2),
    .wd1    (wd1),
    .wa1    (wa1),
    .we1    (we1),
    .wd2    (wd2),
    .wa2    (wa2),
    .we2    (we2),
    .clk    (clk),
    .err    (err)
    );
    
initial begin
    we1 <=1'b0;
    we2 <=1'b0;
    clk <= 1'b0;
    #5
    forever
    begin
        clk <= !clk;
        
        #2;
    end
end

initial begin
    for(idx2 = 4'b1; idx2 < 4'b1000; idx2 = idx2 + 2)begin
        count = 0;
        for(idx4 = 107444580; count < 10; idx4 = idx4 + 107444580)begin
            #10;
            count = count + 1; 
        end
        
    end
    //do some edge case testing
    //edge case were ra1 = ra2 = wa1
    testing = 1;
    idx2 <= 4'b0101;
    idx1 <= 4'b0101;
    wa1  <= 4'b0101;
    wa2  <= 4'b0111;
    #10;
    if (rd1 != wd1) error_count = error_count + 1;
    #5;
    //edge case were ra1 = ra2 = wa2
    idx2 <= 4'b0011;
    idx1 <= 4'b0011;
    wa2  <= 4'b0011;
    wa1  <= 4'b0100;
    #10;
    if (rd2 != wd2) error_count = error_count + 1;
    #5;
    idx2 <= 4'b0111;
    idx1 <= 4'b0111;
    wa1  <= 4'b0111;
    wa2  <= 4'b0111;
    #10;
    if (rd2 != 0) error_count = error_count + 1;
    #5
    $finish;
end

initial begin

    for(idx1 = 4'b0; idx1 < 4'b1000; idx1 = idx1 + 2)begin
        count1 = 0;
        for(idx3 = 103204590; count1 < 10; idx3 = idx3 + 103204590)begin
            #10;
            count1 = count1 + 1; 
        end
        
    end        
end


always @ (posedge clk)begin
    we1 = !we1;
    we2 = !we2;
    if(err)begin
        idx1 = 0;
        idx2 = 0;
    end
    if(we1 && !testing)begin
        wa1 = ra1;
        wd1 = idx3[31:0];end
    if(we2 && !testing)begin
        wa2 = ra2;
        wd2 = idx4[31:0];end 
end

//always @ (negedge we1) wd1 = idx3[31:0];

//always @ (negedge we2) wd2 = idx4[31:0];
    
always @ (wa1)begin
    #0.5
    if((rd1 != wd1) && (wa1 != 0) && !testing) error_count = error_count + 1;
end

always @ (wa2)begin
    #0.5
    if((rd2 != wd2) && !testing) error_count = error_count + 1;
end

assign ra1 = idx1[3:0];
assign ra2 = idx2[3:0];


endmodule




