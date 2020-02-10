`timescale 1ns / 1ps

module Full_Calc_CU(
    input [2:0] F,
    input go, done_calc, done_div, clk, err_in,
    output[2:0] op_calc,
    output[1:0] sel_l,
    output en_in, en_out, go_calc, go_div, done, sel_h, err_out
    );
reg [3:0] cs, ns;
reg [11:0] ctrl;

assign err_out = ctrl[11];
assign en_in = ctrl[10];
assign en_out = ctrl[9];
assign go_calc = ctrl[8];
assign go_div = ctrl[7];
assign sel_h = ctrl[6];
assign sel_l = ctrl[5:4];
assign op_calc = ctrl[3:1];
assign done = ctrl[0];

parameter   s0  = 4'b0000,
            s1  = 4'b0001,
            s2  = 4'b0010,
            s3  = 4'b0011,
            s4  = 4'b0100,
            s4a = 4'b1010,
            s5  = 4'b0101,
            s6  = 4'b0110,
            s7  = 4'b0111,
            s8  = 4'b1000,
            s9  = 4'b1001;
initial
begin
    cs = 4'b0;
    ns = 4'b0;
end

always@(posedge clk) cs = ns;

always@(cs, go, done_calc, done_div, F, err_in)
begin
    case(cs)
        s0: ns = go;
        s1: ns = s2;
        s2: if(F[2] == 0 && F[1] == 1) ns = {3'b010,F[0]}; //take care of mult and divide
            else ns = s3;
        s3: ns = s6;
        s4: ns = s4a;
        s4a: ns = s8;
        s5: ns = s7;
        s6: ns = done_calc ? s9 : s6;
        s7: begin
                if(err_in) ns = s0;
                else ns = done_div ? s9: s7; // handle division
            end
        s8: ns = s9;
        s9: ns = s0;
    endcase
end

always@(cs, done_calc, done_div, err_in)
begin
    case(cs)
        s0:                                 ctrl = 12'b0_0_0_0_0_0_00_000_0;
        s1:                                 ctrl = 12'b0_1_0_0_0_0_00_000_0;
        s2:                                 ctrl = 12'b0_0_0_0_0_0_00_000_0;
        s3: if (F[2] == 0)
            begin
                if(F[0])                    ctrl = 12'b0_0_0_1_0_0_00_010_0;
                else                        ctrl = 12'b0_0_0_1_0_0_00_011_0;
            end
            else if(F[1])                   ctrl = 12'b0_0_0_1_0_0_00_110_0;
            else if(!F[1] && F[0])          ctrl = 12'b0_0_0_1_0_0_00_001_0;
            else                            ctrl = 12'b0_0_0_1_0_0_00_111_0;
        s4:                                 ctrl = 12'b0_0_0_0_0_0_00_000_0;
        s4a:                                ctrl = 12'b0_0_0_0_0_0_00_000_0;
        s5:                                 ctrl = 12'b0_0_0_0_1_0_00_000_0;
        s6: if(done_calc)                   ctrl = 12'b0_0_1_0_0_0_10_000_0;
            else
            begin
                if (F[2] == 0)
                begin
                    if(F[0])                    ctrl = 12'b0_0_0_1_0_0_00_010_0;
                    else                        ctrl = 12'b0_0_0_1_0_0_00_011_0;
                end
                else if(F[1])                   ctrl = 12'b0_0_0_1_0_0_00_110_0;
                else if(!F[1] && F[0])          ctrl = 12'b0_0_0_1_0_0_00_001_0;
                else                            ctrl = 12'b0_0_0_1_0_0_00_111_0;
            end
        s7: if(done_div)                        ctrl = 12'b0_0_1_0_0_0_00_000_0;
            else if (err_in)                    ctrl = 12'b1_0_0_0_0_0_00_000_0;
            else                                ctrl = 12'b0_0_0_0_0_0_00_000_0;
        s8:                                     ctrl = 12'b0_0_1_0_0_1_01_000_0;
        s9:                                     ctrl = 12'b0_0_1_0_0_0_00_000_1;
    endcase
end
        
//        s3: if(F[2] == 1 && F[1] == 1)      ctrl = 12'b0_0_0_0_0_0_00_110_0;
//            else if(F[2] == 1 && F[1] == 0)
//            begin
//                if(F[0] == 0)               ctrl = 12'b0_0_0_0_0_0_00_001_0;
//                else if (F[0] == 1)         ctrl = 12'b0_0_0_0_0_0_00_111_0;
//            end
//            else
//            begin
//                if (F[0])                   ctrl = 12'b0_0_0_1_0_0_00_010_0;
//                else                        ctrl = 12'b0_0_0_1_0_0_00_011_0;
//             end                               
//        s4:                                 ctrl = 12'b0_0_0_0_0_0_00_000_0;                           
//        s4a:                                ctrl = 12'b0_0_0_0_0_0_00_000_0;
//        s5:                                 ctrl = 12'b0_0_0_0_1_0_00_000_0;
//        s6: if(done_calc)                   ctrl = 12'b0_0_1_0_0_0_10_000_0;
//            else
//            begin
//                if (F[0])                   ctrl = 12'b0_0_0_0_0_0_00_010_0;
//                else                        ctrl = 12'b0_0_0_0_0_0_00_011_0;
//            end
//        s7: if(done_div)                    ctrl = 12'b0_0_1_0_0_0_00_000_0;
//            else if (err_in)                ctrl = 12'b1_0_0_0_0_0_00_000_0;
//            else                            ctrl = 12'b0_0_0_0_0_0_00_000_0;
//        s8:                                 ctrl = 12'b0_0_1_0_0_1_01_000_0;
//        s9:                                 ctrl = 12'b0_0_1_0_0_0_00_000_1;
//    endcase
//end
endmodule