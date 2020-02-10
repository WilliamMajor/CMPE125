module MUX2 #(WIDTH = 4) (
        input  wire             sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b,
        output wire [WIDTH-1:0] out
    );

    assign out = (sel == 1'b1) ? b : a;

endmodule