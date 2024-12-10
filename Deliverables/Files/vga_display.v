`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 05:17:38 PM
// Design Name: 
// Module Name: vga_display
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


module vga_display(
    input [2:0] inmove,
    input resetButton,
    input [9:0] x,
    input [9:0] y,
    input clk,
    input di,   
    input palette,
    
    output reg [3:0] r,
    output reg [3:0] g,
    output reg [3:0] b,
    output reg [7:0] score_cnt
    );
    reg [9:0] headx;
    reg [9:0] heady;
    wire [9:0] applex;
    wire [9:0] appley;
    reg [199:0] stored_x;
    reg [199:0] stored_y;
    wire snake_clk_2;
    wire endgame;
    wire border;
    reg [2:0]move;
    reg [7:0]acount;
    
    snake_clock sclk (.clk(clk), .reset(resetButton), .sw(palette), .newClk(snake_clk_2)); // Revise the instantiation of this + vars
    wire [7:0] score_cnt_temp;
    
    initial begin
        headx <= 10'd380;
        heady <= 10'd280;
        stored_x[199:20] <= 180'b0;
        stored_y[199:20] <= 180'b0;
        stored_x[9:0] <= 10'd360;
        stored_y[9:0] <= 10'd280;
        stored_x[19:10] <= 10'd340;
        stored_y[19:10] <= 10'd280;
        score_cnt <= 0;
    end
    
    
    apple_gen AppleGen(.headx(headx), .heady (heady), .clk(clk), .score_cnt(score_cnt_temp), .endgame(endgame), .applex(applex), .appley(appley), .reset(resetButton));
    
    end_game lose(.vga_clk(clk),.resetButton(resetButton), .score_cnt(score_cnt), .current_x(headx), .current_y(heady), .stored_x(stored_x), .stored_y(stored_y), .xPixel(x), .yPixel(y), .endgame(endgame), .border(border));

    // Look at counter to set invisible squares = 0;
    always @ (posedge snake_clk_2) begin
        // initial position of the snake
        if(resetButton) begin
            headx <= 10'd380;
            heady <= 10'd280;
            stored_x[199:20] <= 180'b0; // Stored tail
            stored_y[199:20] <= 180'b0;
            stored_x[9:0] <= 10'd360; // Middle Body
            stored_y[9:0] <= 10'd280;
            stored_x[19:10] <= 10'd340; // Tail
            stored_y[19:10] <= 10'd280;   
            score_cnt <= 0;
            move = 3'b100;
        end
        else if(endgame) begin
            headx <= 10'd380;
            heady <= 10'd280;
            stored_x[199:20] <= 180'b0; // Stored tail
            stored_y[199:20] <= 180'b0;
            stored_x[9:0] <= 10'd360; // Middle Body
            stored_y[9:0] <= 10'd280;
            stored_x[19:10] <= 10'd340; // Tail
            stored_y[19:10] <= 10'd280; 
            score_cnt <= 0;
            move = 3'b100;  
        end
        else begin
                move = inmove;
            // For loop could have helped!
            
            case(move)
            // For some reson, the directions for up and down got swapped for the button mapping...
                3'b000 : begin
                    stored_x = stored_x << 10;   // Right
                    stored_y = stored_y << 10;
                    stored_x[9:0] = headx;
                    stored_y[9:0] = heady;
                    headx = headx + 20; // If we make snake smaller, we make this change
                    score_cnt <= score_cnt_temp;
                end
                3'b001 : begin
                    stored_x = stored_x << 10; // Down
                    stored_y = stored_y << 10;
                    stored_x[9:0] = headx;
                    stored_y[9:0] = heady;
                    heady = heady - 20;
                    score_cnt <= score_cnt_temp;
                end
                3'b010 : begin
                    stored_x = stored_x << 10; // Left
                    stored_y = stored_y << 10;
                    stored_x[9:0] = headx;
                    stored_y[9:0] = heady;
                    headx = headx - 20;
                    score_cnt <= score_cnt_temp;
                end
                3'b011 : begin
                    stored_x = stored_x << 10; // Up
                    stored_y = stored_y << 10;
                    stored_x[9:0] = headx;
                    stored_y[9:0] = heady;
                    heady = heady + 20;
                    score_cnt <= score_cnt_temp;
                end
               3'b100 : begin // Default? make a default state
                    headx <= 10'd380;
                    heady <= 10'd280;
                    stored_x[199:20] <= 180'b0; // Stored tail
                    stored_y[199:20] <= 180'b0;
                    stored_x[9:0] <= 10'd360; // Middle Body
                    stored_y[9:0] <= 10'd280;
                    stored_x[19:10] <= 10'd340; // Tail
                    stored_y[19:10] <= 10'd280;   
                    score_cnt <= 0;
                end
            endcase
           end
end     
        
    always @ (posedge clk) begin
    if(di) begin
        if(~endgame) begin 
            if(((x < (applex + 20)) && (x >= applex)) && ((y < (appley + 20)) && (y >= appley))) begin  // apple color
               r = (palette) ? 4'hF : 4'h9;
               g = (palette) ? 4'h0 : 4'h5;
               b = (palette) ? 4'h0 : 4'h1;
            end
            else if(((x < (headx + 20)) && (x >= headx)) && ((y < (heady + 20)) && (y >= heady))) begin  // head color
                r = (palette) ? 8'hCC : 4'h0;
                g = (palette) ? 8'h00 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[9:0] + 20)) && (x >= stored_x[9:0])) && ((y < (stored_y[9:0] + 20)) && (y >= stored_y[9:0]))) begin  // tail color
                r = (palette) ? 8'h66 : 4'hF;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[19:10] + 20)) && (x >= stored_x[19:10])) && ((y < (stored_y[19:10] + 20)) && (y >= stored_y[19:10]))) begin
                r = (palette) ? 8'h33 : 4'hE;
                g = (palette) ? 8'h99 : 4'hE;
                b = (palette) ? 8'h00 : 4'h2;
            end
            else if(((x < (stored_x[29:20] + 20)) && (x >= stored_x[29:20])) && ((y < (stored_y[29:20] + 20)) && (y >= stored_y[29:20])) && (score_cnt > 8'd0) ) begin
                r = (palette) ? 8'h66 : 4'h0;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[39:30] + 20)) && (x >= stored_x[39:30])) && ((y < (stored_y[39:30] + 20)) && (y >= stored_y[39:30])) && (score_cnt > 8'd1)) begin
                r = (palette) ? 8'h33 : 4'hF;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[49:40] + 20)) && (x >= stored_x[49:40])) && ((y < (stored_y[49:40] + 20)) && (y >= stored_y[49:40])) && (score_cnt > 8'd2)) begin
                r = (palette) ? 8'h66 : 4'hE;
                g = (palette) ? 8'h99 : 4'hE;
                b = (palette) ? 8'h00 : 4'h2;
            end
            else if(((x < (stored_x[59:50] + 20)) && (x >= stored_x[59:50])) && ((y < (stored_y[59:50] + 20)) && (y >= stored_y[59:50])) && (score_cnt > 8'd3)) begin
                r = (palette) ? 8'h33 : 4'h0;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[69:60] + 20)) && (x >= stored_x[69:60])) && ((y < (stored_y[69:60] + 20)) && (y >= stored_y[69:60])) && (score_cnt > 8'd4)) begin
                r = (palette) ? 8'h66 : 4'hF;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[79:70] + 20)) && (x >= stored_x[79:70])) && ((y < (stored_y[79:70] + 20)) && (y >= stored_y[79:70])) && (score_cnt > 8'd5)) begin
                r = (palette) ? 8'h33 : 4'hE;
                g = (palette) ? 8'h99 : 4'hE;
                b = (palette) ? 8'h00 : 4'h2;
            end
            else if(((x < (stored_x[89:80] + 20)) && (x >= stored_x[89:80])) && ((y < (stored_y[89:80] + 20)) && (y >= stored_y[89:80])) && (score_cnt > 8'd6)) begin
                r = (palette) ? 8'h66 : 4'h0;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[99:90] + 20)) && (x >= stored_x[99:90])) && ((y < (stored_y[99:90] + 20)) && (y >= stored_y[99:90])) && (score_cnt > 8'd7)) begin
                r = (palette) ? 8'h33 : 4'hF;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[109:100] + 20)) && (x >= stored_x[109:100])) && ((y < (stored_y[109:100] + 20)) && (y >= stored_y[109:100])) && (score_cnt > 8'd8)) begin
                r = (palette) ? 8'h66 : 4'hE;
                g = (palette) ? 8'h99 : 4'hE;
                b = (palette) ? 8'h00 : 4'h2;
            end
            else if(((x < (stored_x[119:110] + 20)) && (x >= stored_x[119:110])) && ((y < (stored_y[119:110] + 20)) && (y >= stored_y[119:110])) && (score_cnt > 8'd9)) begin
                r = (palette) ? 8'h33 : 4'h0;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[129:120] + 20)) && (x >= stored_x[129:120])) && ((y < (stored_y[129:120] + 20)) && (y >= stored_y[129:120])) && (score_cnt > 8'd10)) begin
                r = (palette) ? 8'h66 : 4'hF;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[139:130] + 20)) && (x >= stored_x[139:130])) && ((y < (stored_y[139:130] + 20)) && (y >= stored_y[139:130])) && (score_cnt > 8'd11)) begin
                r = (palette) ? 8'h33 : 4'hE;
                g = (palette) ? 8'h99 : 4'hE;
                b = (palette) ? 8'h00 : 4'h2;
            end
            else if(((x < (stored_x[149:140] + 20)) && (x >= stored_x[149:140])) && ((y < (stored_y[149:140] + 20)) && (y >= stored_y[149:140])) && (score_cnt > 8'd12)) begin
                r = (palette) ? 8'h66 : 4'h0;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[159:150] + 20)) && (x >= stored_x[159:150])) && ((y < (stored_y[159:150] + 20)) && (y >= stored_y[159:150])) && (score_cnt > 8'd13)) begin
                r = (palette) ? 8'h33 : 4'hF;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[169:160] + 20)) && (x >= stored_x[169:160])) && ((y < (stored_y[169:160] + 20)) && (y >= stored_y[169:160])) && (score_cnt > 8'd14)) begin
                r = (palette) ? 8'h66 : 4'hE;
                g = (palette) ? 8'h99 : 4'hE;
                b = (palette) ? 8'h00 : 4'h2;
            end
            else if(((x < (stored_x[179:170] + 20)) && (x >= stored_x[179:170])) && ((y < (stored_y[179:170] + 20)) && (y >= stored_y[179:170])) && (score_cnt > 8'd15)) begin
                r = (palette) ? 8'h33 : 4'h0;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[189:180] + 20)) && (x >= stored_x[189:180])) && ((y < (stored_y[189:180] + 20)) && (y >= stored_y[189:180])) && (score_cnt > 8'd16)) begin
                r = (palette) ? 8'h66 : 4'hF;
                g = (palette) ? 8'h99 : 4'h0;
                b = (palette) ? 8'h00 : 4'h0;
            end
            else if(((x < (stored_x[199:190] + 20)) && (x >= stored_x[199:190])) && ((y < (stored_y[199:190] + 20)) && (y >= stored_y[199:190])) && (score_cnt > 8'd17)) begin
                r = (palette) ? 8'h33 : 4'hE;
                g = (palette) ? 8'h99 : 4'hE;
                b = (palette) ? 8'h00 : 4'h2;
            end
   
            else if(border) begin // border
            r = (palette) ? 5'd27 : 4'h6;
            g = (palette) ? 7'd117 : 4'h0;
            b = (palette) ? 2'd2 : 4'h0;
            end
            else if(x % 20 == 0 || y % 20 == 0) begin // Grid
            r = (palette) ? 4'h1 : 4'h8;
            g = (palette) ? 4'h3 : 4'h7;
            b = (palette) ? 4'h6 : 4'h5;
            end
            else begin  // background
            r = (palette) ? 4'h0 : 4'hB;
            g = (palette) ? 4'h6 : 4'hA;
            b = (palette) ? 4'h0 : 4'h6;
            end
        end
        else begin // We could change to an actual game over screen
            move = 3'b100;
            r = 4'h8;
            g = 4'h0;
            b = 4'h0;
            end
    end
    else begin
        r = 4'h0;
        g = 4'h0;
        b = 4'h0;
    end
end
endmodule
