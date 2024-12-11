`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 04:35:54 PM
// Design Name: 
// Module Name: apple_gen
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


module apple_gen(
    input [9:0] headx, // Snake head to check for collitions
    input [9:0] heady,
    input clk,
    input reset,
    input endgame,
 
    output reg [9:0] applex,
    output reg [9:0] appley,
    output reg [7:0] score_cnt // Change bits later to +25pts/apple
    );
    
    reg [11:0] counter; //Variable determines new apple generation
    
    initial begin
        applex = 200; // New module to make rando but for now... this is set
        appley = 240;
        counter = 2000; // Randomizer (timer) starts here
        score_cnt <= 0;
    end

    always@ (posedge clk) begin
        if(reset || endgame) begin
            applex<=200;
            appley<=240;
            counter = 2000; //Why is this 2000?
            score_cnt <= 0;
         end
         else begin
            
        if(counter == 4000)
            counter <= 0;
        else
        counter <= counter + 1;
        if(headx < applex + 20 && headx > applex - 20 && heady < appley + 20 && heady > appley - 20) begin // Collition/eat; 30 might be related to size
            score_cnt <= score_cnt + 1; 
            applex = (counter % 28) + 3;
            appley = (counter % 20) + 3;
            if(headx == applex && heady == appley && headx == 0 && heady == 0) begin // Input body so that you can check this condition and prevent apple in body??
                applex = applex + 4;
                appley = appley + 7;
            end
            else if(headx == applex && heady == appley) begin // Head apple collision condition??
                applex = applex - 1;
                appley = appley - 1;
            end
            applex = applex*5'd20;
            appley = appley*5'd20;
        end
        else begin
            applex <= applex;
            appley <= appley;
        end
        end
        
    end
endmodule
