`timescale 1ns / 1ps

module CU(
    input wire cout, go, clk, rst, lt, err_in,
    output wire [2:0] cin,
    output wire s1, s2, x_lsb, done, err_out,
    output wire sl_r, sr_r, sl_x, ce,
    output wire ld_r, ld_x, ld_y, ld_c, rst_out
);
//Control register which updates output control signals
reg [16:0] ctrl;
//Current and next state registers
reg [2:0] CS, NS;
//Assigning output signals to corresponding part in ctrl register
assign cin = ctrl[16:14];
assign s1 = ctrl[13];
assign s2 = ctrl[12];
assign x_lsb = ctrl[11];
assign done = ctrl[10];
assign err_out = ctrl[9];
assign sl_r = ctrl[8];
assign sr_r = ctrl[7];
assign sl_x = ctrl[6];
assign ce = ctrl[5];
assign ld_r = ctrl[4];
assign ld_x = ctrl[3];
assign ld_y = ctrl[2];
assign ld_c = ctrl[1];
assign rst_out = ctrl[0];
//Setting state parameters
parameter   idle = 3'b000,
            load = 3'b001,
            step2 = 3'b010,
            dec = 3'b011,
            less_than = 3'b100,
            not_less_than = 3'b101,
            shift_right = 3'b110,
            finished = 3'b111;
            
//Starting CU at state 0
initial CS = 3'b000;
//Assigning current state to next state at clk
always@(posedge clk, posedge rst) CS <= rst ? 3'b000 : NS;
//Setting next state
always@(CS, go, lt, err_in, cout)
begin
    case(CS)
        idle: NS = go;
        load: NS = step2;
        step2: NS = err_in ? idle : dec;
        dec: NS = lt ? less_than : not_less_than;
        less_than: NS = cout ? dec : shift_right;
        not_less_than: NS = cout ? dec : shift_right;
        shift_right: NS = finished;
        finished: NS = idle;
    endcase
end
//Setting control signals
always@(CS, err_in, lt)
begin
    case(CS)
        idle: ctrl = 17'b100_0_0_0_0_0_0_0_0_0_0_0_0_0_1;
        load: ctrl = 17'b100_0_0_0_0_0_0_0_0_0_0_1_1_0_0;
        step2:  begin
                    if(err_in) ctrl = 17'b100_0_0_0_0_1_1_0_1_0_0_0_0_1_0;
                    else ctrl = 17'b100_0_0_0_0_0_1_0_1_1_0_0_0_1_0;
                end
        dec: begin
                if(lt) ctrl = 17'b100_0_0_0_0_0_0_0_0_1_0_0_0_0_0;
                else ctrl = 17'b100_0_0_0_0_0_0_0_0_1_1_0_0_0_0;
            end
        less_than: ctrl = 17'b100_0_0_0_0_0_1_0_1_0_0_0_0_0_0;
        not_less_than: ctrl = 17'b100_0_0_1_0_0_1_0_1_0_0_0_0_0_0;
        shift_right: ctrl = 17'b100_0_0_0_0_0_0_1_0_0_0_0_0_0_0;
        finished: ctrl = 17'b100_1_1_0_1_0_0_0_0_0_0_0_0_0_0;
    endcase
end
endmodule