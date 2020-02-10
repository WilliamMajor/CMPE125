module tb_voting_rule;
    
    reg  w;
    reg  n;
    reg  o;
    wire a;
    wire b;
    wire c;
    wire d;
    
    voting_rule DUT (
        .w    (w), 
        .n    (n), 
        .o    (o),
        .a    (a), 
        .b    (b), 
        .c    (c), 
        .d    (d)
    );
    
    initial begin
        o = 0;
        forever #5 o = ~o;
    end
        
    initial begin
        n = 0;
        forever #10 n = ~n;
    end

    initial begin
        w = 0;
        forever #20 w = ~w;
    end

    initial #40 $stop;

    initial $monitor(
            $time, 
            " A=%b, B=%b, C=%b : a=%b, b=%b, c=%b, d=%b",
            w, n, o, a, b, c, d
        );
    
endmodule