module and2(
        input wire [1:0] in,
        output wire      out
        );
        
        assign out = in[1] & in [0];

endmodule