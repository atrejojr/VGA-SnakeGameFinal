`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 07:39:00 PM
// Design Name: 
// Module Name: vga_display_2
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


module vga_display_2(
    input clk,
    output reg [9:0] x, 
    output reg [9:0] y,
    output v_sync,
    output h_sync,
    output disp    
    );
    
    // horizontal timings
    parameter HA_END = 639;          // end of active pixels
    parameter HS_STA = HA_END + 30;  // sync starts after front porch
    parameter HS_END = HS_STA + 96;  // sync ends
    parameter LINE   = 799;          // last pixel on line (after back porch)

    // vertical timings
    parameter VA_END = 479;          // end of active pixels
    parameter VS_STA = VA_END + 18;  // sync starts after front porch
    parameter VS_END = VS_STA + 2;   // sync ends
    parameter SCREEN = 524;          // last line on screen (after back porch)

 
    assign h_sync = ~(x >= HS_STA && x < HS_END);  // invert: hsync polarity is negative
    assign v_sync = ~(y >= VS_STA && y < VS_END);  // invert: vsync polarity is negative
    assign disp = (x <= HA_END  && y <= VA_END);   // active region
    
    always@(posedge clk)
    begin
    if(x == LINE)
    begin
        x <= 0;
        y <= (y == SCREEN) ? 0 : y + 1;
    end
    
    else
    begin
        x <= x + 1;
    end
    end
    endmodule
    
    
