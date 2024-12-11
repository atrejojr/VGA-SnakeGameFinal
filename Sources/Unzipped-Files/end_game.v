`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 04:35:54 PM
// Design Name: 
// Module Name: end_game
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


module end_game(
    input vga_clk,
    input resetButton,
    input [7:0] score_cnt,
    input [9:0] current_x, // Current position
    input [9:0] current_y,
    input [9:0] xPixel,
    input [9:0] yPixel,
    input [199:0] stored_x, // Steres length of snake for later
    input [199:0] stored_y, 
    output reg endgame,
    output reg border
    );
    reg body;
    reg borderCollision;
    
    initial begin 
    endgame = 0;
    end
    
    always @ (*)
    begin
        border <= (xPixel < 10 || (xPixel > 630 && xPixel < 640) || yPixel < 10 || (yPixel > 470 && yPixel < 480)); // Border location + playable screen 
	   if (((current_x<10) || ((current_x+20)>630)) || ((current_y<10) || ((current_y+20)>470))) // Checks the boundary for collision
	       borderCollision <= 1;
	   else
	       borderCollision <= 0;
	end
    always@(*) begin // This is finite length of the body; Creates constraint for endgame
        body = ((current_x == stored_x[9:0] && current_y == stored_y[9:0] && (score_cnt >= 8'd0))
        ||  (current_x == stored_x[19:10] && current_y == stored_y[19:10] && (score_cnt >= 8'd0))
        ||  (current_x == stored_x[29:20] && current_y == stored_y[29:20] && (score_cnt > 8'd0))
        ||  (current_x == stored_x[39:30] && current_y == stored_y[39:30] && (score_cnt > 8'd1))
        ||  (current_x == stored_x[49:40] && current_y == stored_y[49:40] && (score_cnt > 8'd2))
        ||  (current_x == stored_x[59:50] && current_y == stored_y[59:50] && (score_cnt > 8'd3))
        ||  (current_x == stored_x[69:60] && current_y == stored_y[69:60] && (score_cnt > 8'd4))
        ||  (current_x == stored_x[79:70] && current_y == stored_y[79:70] && (score_cnt > 8'd5))
        ||  (current_x == stored_x[89:80] && current_y == stored_y[89:80] && (score_cnt > 8'd6))
        ||  (current_x == stored_x[99:90] && current_y == stored_y[99:90] && (score_cnt > 8'd7))
        ||  (current_x == stored_x[109:100] && current_y == stored_y[109:100] && (score_cnt > 8'd8))
        ||  (current_x == stored_x[119:110] && current_y == stored_y[119:110] && (score_cnt > 8'd9))
        ||  (current_x == stored_x[129:120] && current_y == stored_y[129:120] && (score_cnt > 8'd10))
        ||  (current_x == stored_x[139:130] && current_y == stored_y[139:130] && (score_cnt > 8'd11))
        ||  (current_x == stored_x[149:140] && current_y == stored_y[149:140] && (score_cnt > 8'd12))
        ||  (current_x == stored_x[159:150] && current_y == stored_y[159:150] && (score_cnt > 8'd13))
        ||  (current_x == stored_x[169:160] && current_y == stored_y[169:160] && (score_cnt > 8'd14))
        ||  (current_x == stored_x[179:170] && current_y == stored_y[179:170] && (score_cnt > 8'd15))
        ||  (current_x == stored_x[189:180] && current_y == stored_y[189:180] && (score_cnt > 8'd16))
        ||  (current_x == stored_x[199:190] && current_y == stored_y[199:190] && (score_cnt > 8'd17))); 
    end
    
    always @(posedge vga_clk) begin    //or posedge resetButton    
        if (body || borderCollision) 
            endgame <= 1;
        else
           endgame <= 0;
// For the future, try making reste button the only condition to get OUT of endgame           
//          if (resetButton)
//             endgame <= 0;
        end

endmodule
