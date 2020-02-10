module voting_machine_fpga (
        input  wire        clk100MHz, 
        input  wire        rst, 
        input  wire        A,
        input  wire        B,
        input  wire        C,
        output wire        A_led,
        output wire        B_led,
        output wire        C_led,
        output wire [3:0]  LEDSEL,
        output wire [7:0]  LEDOUT
    );
    
    assign A_led = A;
    assign B_led = B;
    assign C_led = C;
    
    supply1 [7:0] vcc;
    
    wire DONT_USE;
    wire clk_5KHz;
    
    wire [3:0] i;
    wire [7:0] vote;

    voting_rule VTR (
        .w          (A), 
        .n          (B), 
        .o          (C), 
        .a          (i[3]), 
        .b          (i[2]), 
        .c          (i[1]), 
        .d          (i[0])
    );
    
    clk_gen CLK (
        .clk100MHz  (clk100MHz), 
        .rst        (rst), 
        .clk_4sec   (DONT_USE),
        .clk_5KHz   (clk_5KHz)
    );
    
    bcd_to_7seg BCD (
        .BCD        (i),
        .s          (vote)
    );

    led_mux LED (
        .clk        (clk_5KHz), 
        .rst        (rst),
        .LED3       (vcc),
        .LED2       (vcc),
        .LED1       (vcc),
        .LED0       (vote),
        .LEDSEL     (LEDSEL),
        .LEDOUT     (LEDOUT)
    );

endmodule