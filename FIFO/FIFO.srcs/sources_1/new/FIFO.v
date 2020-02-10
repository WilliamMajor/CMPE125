`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2019 02:00:54 PM
// Design Name: 
// Module Name: FIFO
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


module FIFO(D_in, D_out, empty, full, clk, rst, rw, enable);

    parameter bus_width = 8;
    parameter addr_width = 5;
    parameter fifo_depth = 20;
    
    input   clk, rst, rw, enable;
    input   [bus_width-1:0] D_in;
    output  [bus_width-1:0] D_out;
    output  full, empty;
    
    reg     [bus_width-1:0] D_out;
    reg     full, empty;
    reg     [addr_width:0] r_ptr, w_ptr;
    reg     [bus_width-1:0] mem [fifo_depth-1:0];

always @ (posedge clk, posedge rst)
begin
    if(rst)
    begin 
        r_ptr = 0;
        w_ptr = 0; 
        D_out = 0;
    end
        
    else if(!enable)
    begin
        D_out = 'bz;end
        
    else if(rw && !empty)
    begin
        D_out = mem[r_ptr[addr_width-1:0]];
        r_ptr = r_ptr + 1; end
    
    else if(!rw && !full)
    begin
        mem[w_ptr[addr_width-1:0]] = D_in;
        w_ptr = w_ptr + 1;end
        
    else
    begin
        D_out = 'bz; end
end

always @ (r_ptr, w_ptr)
begin
    if(r_ptr == w_ptr)
    begin
        empty = 1;
        full = 0; end
    else if (r_ptr[addr_width-1:0] == w_ptr[addr_width-1:0])
    begin
        empty = 0;
        full = 1; end
    else
    begin
        empty = 0;
        full = 0; end
end
endmodule
