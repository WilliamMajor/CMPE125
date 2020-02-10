`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2019 04:32:19 PM
// Design Name: 
// Module Name: sc_four_bit_ALU
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


module sc_four_bit_ALU_;

reg     m,s1,s0;
reg     [3:0] A,B;
wire    [3:0] out;
reg     [3:0]expected_out;
wire    zero, overflow;
reg     expected_zero, expected_overflow;

four_bit_ALU DUT(
    .m          (m),
    .s1         (s1),
    .s0         (s0),
    .A          (A),
    .B          (B),
    .out        (out),
    .zero       (zero),
    .overflow   (overflow)       
    );
    
reg [3:0] idx;
reg [8:0] AB;
reg [9:0] error_count = 0;
initial begin
for(AB = 9'b000000000; AB <= 9'b011111111; AB = AB + 9'b000000001)begin
    A = AB[7:4];
    B = AB[3:0];

for(idx = 4'b0000; idx <= 4'b0111; idx = idx + 3'b0001)begin
    m   = idx[2];
    s1  = idx[1];
    s0  = idx[0];
    
     if (m == 1'b0)      //logic operation chosen
       case({s1,s0})
           2'b00: begin
              #0.00001                // Negation
                 expected_out = ~A;         //Check if operations has caused out to become zero
                 if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                 expected_overflow = 0;   
                 if(expected_out !== out || expected_zero !== zero || expected_overflow !== overflow) error_count = error_count + 1;
                 
                 end                       //if it did throw the zero flag.       
           2'b01: begin
                 #0.00001                    // And
                 expected_out = A & B;
                 if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                 expected_overflow = 0;   
                 if(expected_out !== out || expected_zero !== zero || expected_overflow !== overflow) error_count = error_count + 1;

                 
                 end    
           2'b10: begin 
                   #0.00001                    // Xor
                   expected_out = A ^ B;
                   if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                   expected_overflow = 0;   
                   if(expected_out != out || expected_zero != zero || expected_overflow != overflow) error_count = error_count + 1;
                   
                   end      
           default: begin
                   #0.00001                  // OR
                   expected_out = A | B;
                   if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                   expected_overflow = 0;   
                   if(expected_out != out || expected_zero != zero || expected_overflow != overflow) error_count = error_count + 1;
                   
                   end   
       endcase
   else                //arithmethic operation chosen
       case ({s1,s0})
           2'b00: begin
                   #0.00001
                   expected_out = A - 1;     //decrement
                   if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                   if (A < expected_out) expected_overflow = 1; else expected_overflow = 0;
                   if(expected_out != out || expected_zero != zero || expected_overflow != overflow) error_count = error_count + 1;
                                                //this operation is unsigned so for overflow you are
                 end                           //simply on the other extreme i.e 000 goes to 111 so 
                                               //we check if our starting value is less then our output 
           2'b01: begin
                   #0.00001
                   expected_out = A + B;    //addition
                   if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                   if (expected_out <= A && B != 0) expected_overflow = 1; else expected_overflow = 0; // if adding B to A causes an overflow out will be less than or equal to A
                   if(expected_out != out || expected_zero != zero || expected_overflow != overflow) error_count = error_count + 1;

                   
               end                                         
           2'b10: begin
                   #0.00001
                   expected_out = A - B;    //subtraction
                   if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                   if(expected_out >= A && B != 0) expected_overflow = 1; else expected_overflow = 0;
                   if(expected_out != out || expected_zero != zero || expected_overflow != overflow) error_count = error_count + 1;
                   
               end
           default: begin
                   #0.00001
                   expected_out = A + 1;    //increment
                   if(expected_out == 0) expected_zero = 1; else expected_zero = 0;
                   if(expected_out < A) expected_overflow = 1; else expected_overflow = 0;
                   if(expected_out != out || expected_zero != zero || expected_overflow != overflow) error_count = error_count + 1;
                   
               end
        endcase
  #5;      
end
end
$display ("Simulation Finished");
$finish; 
end

endmodule

