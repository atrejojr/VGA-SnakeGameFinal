`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:17:06 PM
// Design Name: 
// Module Name: refcnt
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


module refcnt(
input refclk,
output reg [2:0] refcnt = 0 //
    );
    
always@(posedge refclk)
    refcnt <= refcnt +1; // add one to the refresh counter at the positive dge of the refresh clock
    
endmodule
