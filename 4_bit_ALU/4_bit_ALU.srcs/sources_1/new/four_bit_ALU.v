`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2019 08:37:03 PM
// Design Name: 
// Module Name: four_bit_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module four_bit_ALU(m, s1, s0, A, B, out, zero, overflow);

    input m,s1,s0;
    input [3:0] A,B;
    output reg zero,overflow;
    output reg [3:0] out;
    
    always @ (m, s1, s0, A, B)
    begin
        if (m == 1'b0)      //logic operation chosen
            case({s1,s0})
                2'b00: begin                    // Negation
                      out = ~A;
                      if(out == 0) zero = 1; else zero = 0;
                      overflow = 0;    //Check if operations has caused out to become zero
                      end                       //if it did throw the zero flag.       
                2'b01: begin                    // And
                      out = A & B;
                      if(out == 0) zero = 1; else zero = 0;
                      overflow = 0;
                      end    
                2'b10: begin                    // Xor
                        out = A ^ B;
                        if(out == 0) zero = 1; else zero = 0;
                        overflow = 0;
                        end      
                2'b11: begin                  // OR
                        out = A | B;
                        if(out == 0) zero = 1; else zero = 0;
                        overflow = 0;
                        end    
            endcase
        else                //arithmethic operation chosen
            case ({s1,s0})
                2'b00: begin
                        out = A - 1;     //decrement
                        if(out == 0) zero = 1; else zero = 0;
                        if (A < out) overflow = 1; else overflow = 0; //this operation is unsigned so for overflow you are
                      end                           //simply on the other extreme i.e 000 goes to 111 so 
                                                    //we check if our starting value is less then our output 
                2'b01: begin
                        out = A + B;    //addition
                        if(out == 0) zero = 1; else zero = 0;
                        if (out <= A && B != 0) overflow = 1; else overflow = 0; // if adding B to A causes an overflow out will be less than or equal to A
                    end                                         
                2'b10: begin
                        out = A - B;    //subtraction
                        if(out == 0) zero = 1; else zero = 0;
                        if(out >= A && B != 0) overflow = 1; else overflow = 0;
                    end
                2'b11: begin
                        out = A + 1;    //increment
                        if(out == 0) zero = 1; else zero = 0;
                        if(out < A) overflow = 1; else overflow = 0;
                    end
             endcase
     end
endmodule
