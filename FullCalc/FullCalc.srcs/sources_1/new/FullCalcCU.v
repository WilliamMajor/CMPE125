`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 10:00:19 PM
// Design Name: 
// Module Name: FullCalcCU
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


module FullCalcCU(
        input [1:0] F,
        input go, done_calc, done_div, clk, err_in,
        output[1:0] sel_l, op_calc,
        output en_in, en_out, go_calc, go_div, sel_h, done, err_out
    );
    
reg [3:0] cs, ns;
reg [10:0] ctrl;

assign err_out = ctrl[10];
assign en_in = ctrl[9];
assign en_out = ctrl[8];
assign go_calc = ctrl[7];
assign go_div = ctrl[6];
assign sel_h = ctrl[5];
assign sel_l = ctrl[4:3];
assign op_calc = ctrl[2:1];
assign done = ctrl[0];

parameter   s0 = 4'b0000,
            s1 = 4'b0001,
            s2 = 4'b0010,
            s3 = 4'b0011,
            s4 = 4'b0100,
            s5 = 4'b0101,
            s6 = 4'b0110,
            s7 = 4'b0111,
            s8 = 4'b1000,
            s9 = 4'b1001;
initial
begin
    cs = 4'b0;
    ns = 4'b0;
end
always@(posedge clk) cs = ns;

always@(cs, go, done_calc, done_div, F, err_in)
begin
    case(cs)
        s0:         ns = go;
        s1:         ns = s2;
        s2: if (F[1] == 0) ns = s3;
            else    ns = {3'b010, F[0]};
        s3:         ns = s6;
        s4:         ns = s8;
        s5:         ns = s7;
        s6:         ns = done_calc ? s9 : s6;
        s7:         ns = (done_div||err_in) ? s9 : s7;
        s8:         ns = s9;
        s9:         ns = s0;
        default:    ns = s0;
    endcase
end

always@(cs, done_calc, done_div, err_in)
begin
    case(cs)
        s0: begin                    ctrl = 11'b0_0_0_0_0_0_00_00_0; $display("got here0"); end
        s1: begin                    ctrl = 11'b0_1_0_0_0_0_00_00_0; $display("got here1"); end
        s2: begin                    ctrl = 11'b0_0_0_0_0_0_00_00_0; $display("got here2"); end
        s3: if (F[0]) begin          ctrl = 11'b0_0_0_1_0_0_00_10_0; $display("got here3"); end
            else  begin              ctrl = 11'b0_0_0_1_0_0_00_00_0; $display("got here3a"); end
        s4: begin                    ctrl = 11'b0_0_0_0_0_0_00_00_0; $display("got here4"); end
        s5: begin                    ctrl = 11'b0_0_0_0_1_0_00_00_0; $display("got here5"); end
        s6: if(done_calc) begin      ctrl = 11'b0_0_1_0_0_0_10_00_0; $display("got here6"); end
            else
            begin
                if (F[0]) begin      ctrl = 11'b0_0_1_0_0_0_00_10_0; $display("got here6a"); end
                else begin           ctrl = 11'b0_0_1_0_0_0_00_00_0; $display("got here6b"); end
            end
        s7: if(done_div) begin       ctrl = 11'b0_0_1_0_0_0_00_00_0; $display("got here7"); end
            else if (err_in) begin   ctrl = 11'b1_0_1_0_0_0_00_00_0; $display("got here7a"); end
            else  begin              ctrl = 11'b0_0_0_0_0_0_00_00_0; $display("got here7b"); end
        s8: begin                    ctrl = 11'b0_0_1_0_0_1_01_00_0; $display("got here8"); end
        s9: begin                    ctrl = 11'b0_0_0_0_0_0_00_00_1; $display("got here9"); end
    endcase
end
endmodule
