`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2019 03:39:15 PM
// Design Name: 
// Module Name: inferred_CLA_Adder
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


module inferred_CLA_Adder(
      input      [3:0]      A,B,
      output reg [3:0]      s
    );
  integer   tsum;
  integer   idx;
  reg [3:0] Cin;
  reg       Cout;
    always @ (A, B)
    begin
    Cout  = 0;
        for (idx = 0; idx < 4; idx = idx + 1)begin
            Cin[idx] = Cout;
            tsum = A[idx] + B[idx] + Cin[idx];
            s[idx] = tsum[0];
            Cout = tsum[1];  
       end
    end
endmodule
