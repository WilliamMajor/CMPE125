module and_or (
        input  wire [3:0] in,
        output wire       out
    );
        
        wire [1:0] sig;
        
        and2 A1 (
                .in     (in[3:2]),
                .out    (sig[1])
                );
                
        and2 A2 (
                .in     (in[1:0]),
                .out    (sig[0])
                );
        
        or2 O1 (
                .in     (sig),
                .out    (out)
                );
        
        
endmodule