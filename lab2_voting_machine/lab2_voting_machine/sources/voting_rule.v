module voting_rule (
        input  wire w,
        input  wire n,
        input  wire o,
        output wire a,
        output wire b,
        output wire c,
        output wire d
    );

    assign a = w&n&o;
    assign b = ~w&~n&o | ~w&n&o | w&~n&o | w&n&~o;
    assign c = ~w&n&~o | ~w&n&o | w&~n&o | w&~n&~o;
    assign d = ~w&n&~o | ~w&n&o | w&n&~o | w&n&o;
    
endmodule