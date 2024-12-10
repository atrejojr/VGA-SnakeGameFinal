`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:04:11 PM
// Design Name: 
// Module Name: anode_control
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

// Actual scoreboard display after the encoder
module anodes(
input [2:0] refcnt,
output reg [7:0] anode = 0
    );
    
always@(refcnt)
begin
    case(refcnt) // controls all 8 digits on the BCD display on the fpga board
   3'b000: anode = 8'b11111110;//digit 1
   3'b001: anode = 8'b11111101;//digit 2
   3'b010: anode = 8'b11111011;//digit 3
   3'b011: anode = 8'b11110111;//digit 4
   3'b100: anode = 8'b11101111;//digit 5
   3'b101: anode = 8'b11011111;//digit 6
   3'b110: anode = 8'b10111111;//digit 7
   3'b111: anode = 8'b01111111;//digit 8
    endcase
end
endmodule
