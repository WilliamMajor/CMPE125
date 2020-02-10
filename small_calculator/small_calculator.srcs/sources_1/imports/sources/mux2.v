module mux2 #(parameter data_width = 4) (
        input  wire             sel,
        input  wire [data_width - 1 : 0] a,
        input  wire [data_width - 1 : 0] b,
        output wire [data_width - 1 : 0] out
    );

    assign out = (sel == 1'b1) ? a : b;

endmodule