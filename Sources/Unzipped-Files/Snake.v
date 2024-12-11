`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 04:08:40 PM
// Design Name: 
// Module Name: Snake
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

module Snake(
    input clk,
    input resetButton,
    input palette,
    input up, down, left, right,
    output [3:0]r,
    output [3:0]g,
    output [3:0]b,
    output vsync,
    output hsync,
    output [7:0]anode,
    output wire A,
    output wire B,
    output wire C,
    output wire D,
    output wire E,
    output wire F,
    output wire G,
    output wire [7:0] score_cnt
    );
    
    wire [9:0] x, y;
    wire di;
    wire [2:0] direction;
    wire clk25;
    wire reset;

    clk_divider clkDiv (clk, resetButton, clk25);
    
    button_inputs fpga(.clk(clk), .reset(resetButton), .up(up), .down(down), .left(left), .right(right), .direction(direction));
    
    vga_display snakemover( .inmove(direction), .x(x), .y(y), .di(di), .resetButton(resetButton), .clk(clk25), .r(r), .g(g), .b(b), .score_cnt(score_cnt), .palette(palette));
    
    vga_display_2 VGArefresh(.clk(clk25), .x(x), .y(y), .v_sync(vsync), .h_sync(hsync), .disp(di));
     
    topmodule top(.clk(clk), .outscore(score_cnt), .anode(anode), .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G));
    
endmodule
