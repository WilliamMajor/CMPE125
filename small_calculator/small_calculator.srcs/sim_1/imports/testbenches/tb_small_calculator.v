module tb_small_calculator;
    reg        clk;
    reg        go;
    reg  [1:0] op;
    reg  [3:0] in1;
    reg  [3:0] in2;
    wire [3:0] out;
    wire [2:0] CS;
    wire       done;
    wire       neg;

    reg [3:0] tb_out;

    integer I;
    integer error_count = 0;

    small_calculator DUT (
            .clk            (clk),
            .go             (go),
            .op             (op),
            .in1            (in1),
            .in2            (in2),
            .out            (out),
            .CS             (CS),
            .done           (done),
            .neg            (neg)
        );

    task tick;
        begin
            clk = 1'b0; #5; clk = 1'b1; #5;
        end
    endtask

    initial begin
        error_count = 0;
        for(I = 0; I < 2 ** 10; I = I + 1) begin
            {op, in2, in1} = I;
            
            case(op)
                2'b00: tb_out = in1 + in2;
                2'b01: tb_out = in1 - in2;
                2'b10: tb_out = in1 & in2;
                2'b11: tb_out = in1 ^ in2;
            endcase

            go = 1'b1;
            tick;
            go = 1'b0;
            while(!done) tick;

            if(tb_out != out) begin
                error_count = error_count + 1;
            end
            tick;
        end
        $finish;
    end

endmodule
