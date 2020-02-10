module small_calculator (
        input  wire       clk,
        input  wire       go,
        input  wire [1:0] op,
        input  wire [3:0] in1,
        input  wire [3:0] in2,
        output wire [3:0] out,
        output wire [2:0] CS,
        output wire       done,
        output wire       neg
    );
    
    wire [1:0] s1;
    wire [1:0] wa;
    wire [1:0] raa;
    wire [1:0] rab;
    wire [1:0] c;

    wire we;
    wire rea;
    wire reb;
    wire s2;

    small_calculator_dp DP (
            .clk        (clk),
            .in1        (in1),
            .in2        (in2),
            .s1         (s1),
            .wa         (wa),
            .raa        (raa),
            .rab        (rab),
            .c          (c),
            .we         (we),
            .rea        (rea),
            .reb        (reb),
            .s2         (s2),
            .out        (out),
            .neg        (neg)
        );

    small_calculator_cu CU (
            .clk        (clk),
            .go         (go),
            .op         (op),
            .s1         (s1),
            .wa         (wa),
            .raa        (raa),
            .rab        (rab),
            .c          (c),
            .we         (we),
            .rea        (rea),
            .reb        (reb),
            .s2         (s2),
            .done       (done),
            .CS         (CS)
    );

endmodule
