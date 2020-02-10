module register_file (
        input  wire       clk,
        input  wire       rea,
        input  wire       reb,
        input  wire       we,
        input  wire [1:0] raa,
        input  wire [1:0] rab,
        input  wire [1:0] wa,
        input  wire [3:0] din, 
        output wire [3:0] douta,
        output wire [3:0] doutb
    );

    reg [3:0] RegFile[3:0];

    always @ (posedge clk) begin
        if(we) begin
            RegFile[wa] <= din;
        end
        else begin
            RegFile[wa] <= RegFile[wa];
        end
    end

    assign douta = (rea == 1'b1) ? RegFile[raa] : 4'b0;
    assign doutb = (reb == 1'b1) ? RegFile[rab] : 4'b0;

endmodule
