`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:17:06 PM
// Design Name: 
// Module Name: BCD_to_Cathodes
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

 // Basically an encoder for our display! (I think)
module counter(
input [7:0] digit,
output  reg  A,
output reg B,
output reg C,
output reg D,
output reg E,
output reg F,
output reg G
    );

reg [6:0] encde = 7'b0000000; 

always@ (digit) begin
    case(digit)
        8'b00000000 : encde <= 7'b1111110;//0 //I believe this turns our 8 digit binary score into one that can be read on 7 screens
        8'b00000001 : encde <= 7'b0110000;//1
        8'b00000010 : encde <= 7'b1101101;//2
        8'b00000011 : encde <= 7'b1111001;//3
        8'b00000100 : encde <= 7'b0110011;//4       
        8'b00000101 : encde <= 7'b1011011;//5
        8'b00000110 : encde <= 7'b1011111;//6
        8'b00000111 : encde <= 7'b1110000;//7
        8'b00001000 : encde <= 7'b1111111;//8
        8'b00001001 : encde <= 7'b1111011;//9
        8'b00001010 : encde <= 7'b1011011;//S
        8'b00001100 : encde <= 7'b1001110;//C
        8'b00001011 : encde <= 7'b1000110;//R
        8'b00001110 : encde <= 7'b1001111;//E
        8'b00010001 : encde <= 7'b0001110;//L
        8'b11111110 : encde <= 7'b0000001;//minus
        8'b11111111 : encde <= 7'b0000000;//empty
        endcase

   A = ~encde[6];
   B = ~encde[5];
   C = ~encde[4];
   D = ~encde[3];
   E = ~encde[2];
   F = ~encde[1];
   G = ~encde[0];
end
endmodule
