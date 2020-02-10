module bcd_to_7seg (
        input  wire [3:0] BCD,
        output reg  [7:0] s0, s1
        );
        
        always @ (BCD) begin
            case (BCD)
                    4'd0:   begin s1 = 8'b11000000;  s0 = 8'b11000000; end
                    4'd1:   begin s1 = 8'b11000000;  s0 = 8'b11111001; end
                    4'd2:   begin s1 = 8'b11000000;  s0 = 8'b10100100; end
                    4'd3:   begin s1 = 8'b11000000;  s0 = 8'b10110000; end
                    4'd4:   begin s1 = 8'b11000000;  s0 = 8'b10011001; end
                    4'd5:   begin s1 = 8'b11000000;  s0 = 8'b10010010; end
                    4'd6:   begin s1 = 8'b11000000;  s0 = 8'b10000010; end
                    4'd7:   begin s1 = 8'b11000000;  s0 = 8'b11111000; end
                    4'd8:   begin s1 = 8'b11000000;  s0 = 8'b10000000; end
                    4'd9:   begin s1 = 8'b11000000;  s0 = 8'b10010000; end
                    4'd10:  begin s1 = 8'b11111001;  s0 = 8'b11000000; end
                    4'd11:  begin s1 = 8'b11111001;  s0 = 8'b11111001; end
                    4'd12:  begin s1 = 8'b11111001;  s0 = 8'b10100100; end
                    4'd13:  begin s1 = 8'b11111001;  s0 = 8'b10110000; end
                    4'd14:  begin s1 = 8'b11111001;  s0 = 8'b10011001; end
                    4'd15:  begin s1 = 8'b11111001;  s0 = 8'b10010010; end
                    default: s1 = 8'b01111111;
            endcase
        end
        
endmodule


module bcb_to_7seg(
        input  wire  BCB,
        output reg  [7:0] s
        );
        
    always @ (BCB) begin
        case (BCB)
                1'b0: s = 8'b11000000;
                1'b1: s = 8'b11111001;
            default: s = 8'b01111111;
        endcase
    end
endmodule