module small_calculator_cu (
        input  wire       clk,
        input  wire       go,
        input  wire [1:0] op, 
        output wire [1:0] s1,
        output wire [1:0] wa,
        output wire [1:0] raa,
        output wire [1:0] rab,
        output wire [1:0] c,
        output wire       we,
        output wire       rea,
        output wire       reb,
        output wire       s2,
        output wire       done,
        output reg  [2:0] CS
    );
  
    always @(posedge clk) begin
        CS <= NS;
    end

    reg [2:0]  NS;
    reg [14:0] control;

    parameter IDLE  = 15'b00_00_0_00_0_00_0_00_0_0,
              LOAD1 = 15'b01_01_1_00_0_00_0_00_0_0,
              LOAD2 = 15'b10_10_1_00_0_00_0_00_0_0,
              ADD   = 15'b11_11_1_01_1_10_1_00_0_0,
              SUB   = 15'b11_11_1_01_1_10_1_01_0_0,
              AND   = 15'b11_11_1_01_1_10_1_10_0_0,
              XOR   = 15'b11_11_1_01_1_10_1_11_0_0,
              DONE  = 15'b00_00_0_11_1_11_1_10_1_1;

    parameter S0 = 3'd0,
              S1 = 3'd1,
              S2 = 3'd2,
              S3 = 3'd3,
              S4 = 3'd4;
    
    always @ (CS, go) begin
        case(CS)
            S0: NS = (go == 1'b1) ? S1 : S0;
            S1: NS = S2;
            S2: NS = S3;
            S3: NS = S4;
            S4: NS = S0;
            default: NS = (go == 1'b1) ? S1 : S0;
        endcase
    end

    always @(CS, op) begin
        case(CS)
            S0: control = IDLE;
            S1: control = LOAD1;
            S2: control = LOAD2;
            S3: begin
                case (op)
                    2'b00: control = ADD;
                    2'b01: control = SUB;
                    2'b10: control = AND;
                    2'b11: control = XOR;
                endcase
            end
            S4: control = DONE;
        endcase
    end
    
    assign {s1, wa, we, raa, rea, rab, reb, c, s2, done} = control;

endmodule