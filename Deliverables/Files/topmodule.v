`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:28:26 PM
// Design Name: 
// Module Name: top
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


module topmodule(
    input clk,
    input [7:0]outscore,
    output [7:0]anode,
    output wire A,
    output wire B,
    output wire C,
    output wire D,
    output wire E,
    output wire F,
    output wire G
    );

wire div_refclk;
wire [2:0] refcnt;
wire [7:0] dig;

refclk refreshclock(.clk(clk), .newClk(div_refclk)); 

refcnt refreshcounter(.refclk(div_refclk), .refcnt(refcnt));

anodes anodez(.refcnt(refcnt), .anode(anode));

countercontrol digcontrol(.outscore(outscore), .refcnt(refcnt), .dig(dig));

counter digitz(.digit(dig), .A(A),.B(B),.C(C),.D(D),.E(E),.F(F),.G(G));

endmodule
