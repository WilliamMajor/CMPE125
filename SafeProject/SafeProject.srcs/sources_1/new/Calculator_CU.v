`timescale 1ns / 1ps
module Calculator_CU(
    input go, clk,
    input [1:0] op,
    output reg we, rea, reb, s2, done,
    output reg [1:0] s1, wa, raa, rab, c,
    output [3:0] cs
);
reg[3:0] CS, NS;
reg[18:0] ctrl;
assign cs = CS;

parameter idle = 4'b0000,
    in1_to_r1 = 4'b0001,
    in2_to_r2 = 4'b0010,
    wait_op = 4'b0011,
    r1pr2_to_r3 = 4'b0100,
    r1sr2_to_r3 = 4'b0101,
    r1ar2_to_r3 = 4'b0110,
    r1xr2_to_r3 = 4'b0111,
    finished = 4'b1000;
//Initialize state to 0
initial
begin
CS = 4'b0;
NS = 4'b0;
end
//Setting current state to next state at clock tick
always@(posedge clk) CS <= NS;
//Setting what NS should be
always@(CS, op, go)
begin
    case(CS)
        idle: if(go) NS = in1_to_r1;
        in1_to_r1: NS = in2_to_r2;
        in2_to_r2: NS = wait_op;
        wait_op: begin
            $display("op ",op);
            case(op)
                2'b11: NS = r1pr2_to_r3;
                2'b10: NS = r1sr2_to_r3;
                2'b01: NS = r1ar2_to_r3;
                2'b00: NS = r1xr2_to_r3;
            endcase
        end
        r1pr2_to_r3: NS = finished;
        r1sr2_to_r3: NS = finished;
        r1ar2_to_r3: NS = finished;
        r1xr2_to_r3: NS = finished;
        finished: NS = idle;
    endcase
end
//Setting ctrl register based on state
always@(CS)
begin
    case(CS)
        idle: ctrl = 19'b00_00_0_00_0_00_0_00_0_0_0000;
        in1_to_r1: ctrl = 19'b11_01_1_00_0_00_0_00_0_0_0001;
        in2_to_r2: ctrl = 19'b10_10_1_00_0_00_0_00_0_0_0010;
        wait_op: ctrl = 19'b00_00_0_00_0_00_0_00_0_0_0011;
        r1pr2_to_r3: ctrl = 19'b00_11_1_01_1_10_1_00_0_0_0100;
        r1sr2_to_r3: ctrl = 19'b00_11_1_01_1_10_1_01_0_0_0101;
        r1ar2_to_r3: ctrl = 19'b00_11_1_01_1_10_1_10_0_0_0110;
        r1xr2_to_r3: ctrl = 19'b00_11_1_01_1_10_1_11_0_0_0111;
        finished: ctrl = 19'b00_00_0_11_1_11_1_10_1_1_1000;
    endcase
end
//Setting individual signals to ctrl signal
always@(ctrl)
    begin
        s1 = ctrl[18:17];
        wa = ctrl[16:15];
        we = ctrl[14];
        raa = ctrl[13:12];
        rea = ctrl[11];
        rab = ctrl[10:9];
        reb = ctrl[8];
        c = ctrl[7:6];
        s2 = ctrl[5];
        done = ctrl[4];
    end
endmodule
