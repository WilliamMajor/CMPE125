module tb_and_or_self_checking;

    reg [3:0] tb_in;
    wire      tb_out;
    
    reg       tb_out_expected;
    
    and_or DUT (
            .in     (tb_in),
            .out    (tb_out)
            );
        
    integer I;
    integer error_count = 0;
    
    initial begin
        for(I = 0; I < 2 ** 4; I = I + 1) begin
            tb_in = I;
            tb_out_expected = (tb_in[3] & tb_in[2]) | (tb_in[1] & tb_in[0]);
            #5;
            if(tb_out_expected != tb_out) begin
                $display("Error, result incorrect %d != %d", tb_out_expected, tb_out);
                error_count = error_count +1;
            end
        end
        $display ("Simulation Finished");
        $finish;
    end
        

endmodule
