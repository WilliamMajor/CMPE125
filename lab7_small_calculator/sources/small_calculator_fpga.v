module small_calculator_fpga(
        input  wire       clk100MHz,
        input  wire       rst,
        input  wire       go,
        input  wire       button,
        input  wire [1:0] op,
        input  wire [3:0] in1,
        input  wire [3:0] in2,
        output wire       done,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
    );

    supply1 [7:0] vcc;

    wire DONT_USE;
    wire clk_5KHz;
    wire manual_clk;

    wire [3:0] out;

    wire [2:0] CS;

    small_calculator SM_CALC (
            .clk            (manual_clk),
            .go             (go),
            .op             (op),
            .in1            (in1),
            .in2            (in2),
            .out            (out),
            .CS             (CS),
            .done           (done)
        );


    wire [3:0] bcd_tens;
    wire [3:0] bcd_ones;

    wire [7:0] led_tens;
    wire [7:0] led_ones;
    wire [7:0] led_CS;

    assign bcd_tens = out / 10;
    assign bcd_ones = out % 10;
    
    clk_gen CLK (
            .clk100MHz          (clk100MHz),
            .rst                (rst),
            .clk_4sec           (DONT_USE),
            .clk_5KHz           (clk_5KHz)
        );
    
    button_debouncer BD(
            .clk                (clk_5KHz),
            .button             (button),
            .debounced_button   (manual_clk)
        );

    bcd_to_7seg BCD_ONES (
            .BCD                (bcd_ones),
            .s                  (led_ones)
        );

    bcd_to_7seg BCD_TENS (
            .BCD                (bcd_tens),
            .s                  (led_tens)
        );

    bcd_to_7seg BCD_CS (
            .BCD                ({1'b0,CS}),
            .s                  (led_CS)
        );

    led_mux LED (
            .clk                (clk_5KHz),
            .rst                (rst),
            .LED3               (led_CS),
            .LED2               (vcc),
            .LED1               (led_tens),
            .LED0               (led_ones),
            .LEDSEL             (LEDSEL),
            .LEDOUT             (LEDOUT)
        );

endmodule
