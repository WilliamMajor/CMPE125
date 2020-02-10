module small_calculator_dp (
        input  wire       clk,
        input  wire [3:0] in1,
        input  wire [3:0] in2,
        input  wire [1:0] s1,
        input  wire [1:0] wa,
        input  wire [1:0] raa,
        input  wire [1:0] rab,
        input  wire [1:0] c,
        input  wire       we,
        input  wire       rea,
        input  wire       reb,
        input  wire       s2,
        output wire [3:0] out,
        output wire       neg     
    );
    
    wire [3:0] mux1out;
    wire [3:0] douta;
    wire [3:0] doutb;
    wire [3:0] aluout;

    mux4 #(
        .WIDTH(4)
    ) MUX1 (
            .sel        (s1),
            .in0        (4'b0),
            .in1        (in1),
            .in2        (in2),
            .in3        (aluout),
            .out        (mux1out)
        );

    register_file RF (
            .clk        (clk),
            .rea        (rea),
            .reb        (reb),
            .we         (we),
            .raa        (raa),
            .rab        (rab),
            .wa         (wa),
            .din        (mux1out),
            .douta      (douta),
            .doutb      (doutb)
        );

    alu ALU (
            .c          (c),
            .in0        (douta),
            .in1        (doutb),
            .alu_out    (aluout),
            .neg        (neg)
            
        );

    mux2 #(
        .WIDTH(4)
    ) MUX2 (
            .sel        (s2),
            .in0        (4'b0),
            .in1        (aluout),
            .out        (out)
        );

endmodule