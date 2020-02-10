`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 07:33:12 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input wire cout, go, clk, rst, lessThan, err_in,
    output wire [2:0] cin,
    output wire s1, s2, x_leftin, done, err_out,
    output wire sl_remainder, sr_remainder, sl_x, ce,
    output wire ld_remainder, ld_x, ld_y, ld_c, rst_out
    );
    
//Control register which updates output control signals
reg [16:0] ctrl;

//Current and next state registers
reg [2:0] CS, NS;

//Assigning output signals to corresponding part in ctrl register
assign cin          = ctrl[16:14];
assign s1           = ctrl[13];
assign s2           = ctrl[12];
assign x_leftin     = ctrl[11];
assign done         = ctrl[10];
assign err_out      = ctrl[9];
assign sl_remainder = ctrl[8];
assign sr_remainder = ctrl[7];
assign sl_x         = ctrl[6];
assign ce           = ctrl[5];
assign ld_remainder = ctrl[4];
assign ld_x         = ctrl[3];
assign ld_y         = ctrl[2];
assign ld_c         = ctrl[1];
assign rst_out      = ctrl[0];

//Setting state parameters
parameter   IDLE = 3'b000, 
            LOAD = 3'b001,
            STEP2 = 3'b010,
            DECREMENT = 3'b011,
            LESS_THAN = 3'b100,
            NOT_LESS_THAN = 3'b101,
            SHIFT_RIGHT = 3'b110,
            FINISHED = 3'b111;

//Starting CU at state 0
initial CS = 3'b000;

//Assigning current state to next state at clk
always@(posedge clk, posedge rst) CS <= rst ? 3'b000 : NS;

//Setting next state
always@(CS, go, lessThan, err_in, cout)
begin
    case(CS)
        IDLE:           NS = go;
        LOAD:           NS = STEP2;
        STEP2:          NS = err_in ? IDLE : DECREMENT;
        DECREMENT:      NS = lessThan ? LESS_THAN : NOT_LESS_THAN;
        LESS_THAN:      NS = cout ? DECREMENT : SHIFT_RIGHT;
        NOT_LESS_THAN:  NS = cout ? DECREMENT : SHIFT_RIGHT;
        SHIFT_RIGHT:    NS = FINISHED;
        FINISHED:       NS = IDLE;
    endcase
end

//Setting control signals
always@(CS, err_in, lessThan)
begin
    case(CS)
        IDLE:               ctrl = 17'b100_0_0_0_0_0_0_0_0_0_0_0_0_0_1; 
        LOAD:               ctrl = 17'b100_0_0_0_0_0_0_0_0_0_0_1_1_0_0; 
        STEP2: begin
                if(err_in)  ctrl = 17'b100_0_0_0_0_1_1_0_1_0_0_0_0_1_0;
                else        ctrl = 17'b100_0_0_0_0_0_1_0_1_1_0_0_0_1_0;
            end
        DECREMENT: begin
                if(lessThan)      ctrl = 17'b100_0_0_0_0_0_0_0_0_1_0_0_0_0_0;
                else        ctrl = 17'b100_0_0_0_0_0_0_0_0_1_1_0_0_0_0;
            end
        LESS_THAN:          ctrl = 17'b100_0_0_0_0_0_1_0_1_0_0_0_0_0_0; 
        NOT_LESS_THAN:      ctrl = 17'b100_0_0_1_0_0_1_0_1_0_0_0_0_0_0; 
        SHIFT_RIGHT:        ctrl = 17'b100_0_0_0_0_0_0_1_0_0_0_0_0_0_0; 
        FINISHED:           ctrl = 17'b100_1_1_0_1_0_0_0_0_0_0_0_0_0_0;

    endcase
end

endmodule
