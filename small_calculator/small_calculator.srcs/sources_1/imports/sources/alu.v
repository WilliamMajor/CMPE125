module alu (
        input  wire [1:0] c,
        input  wire [3:0] in0,
        input  wire [3:0] in1,
        output reg  [3:0] alu_out,
        output reg  neg
    );

    always @ (in0, in1, c) begin
        case(c)
            2'b00: begin
                alu_out = in0 + in1;
                neg = 1'b0;
                end
            2'b01: begin
                if(in0 < in1)begin
                    alu_out = in1 - in0;
                    neg = 1'b1;
                end
                else alu_out = in0 - in1;
                end
            2'b10: begin
                alu_out = in0 & in1;
                neg = 1'b0;
                end
            2'b11: begin
                alu_out = in0 ^ in1;
                neg = 1'b0;
                neg = 1'b0;
                end
        endcase
    end

endmodule