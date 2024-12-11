`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 04:35:54 PM
// Design Name: 
// Module Name: snake_clock
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


module snake_clock(
    input clk, 
    input reset, 
    input sw,
    output newClk
);
    reg [29:0] cnt = 0;
    reg [29:0] toggleVal;
    reg tempClk = 0;
    
    assign newClk = tempClk;
    
    always @(posedge clk or posedge reset)
    begin        
        if (reset)
        begin
            cnt <= 0;
            tempClk <= 0;
            toggleVal <= 2_500_000 - 1;  // Default value for toggleVal
        end
        else
        begin
            // Easy mode (caterpillar)
            if (sw)
                toggleVal <= 2_500_000 - 1;  // Set toggleVal to 2_500_000 - 1 when sw is high
            else
                toggleVal <= 1_000_000 - 1;  // Set toggleVal to 1_000_000 - 1 when sw is low
            // Hard mode (desert snake)
            if (cnt < toggleVal)
                cnt <= cnt + 1;
            else
            begin
                cnt <= 0;
                tempClk <= ~tempClk;
            end
        end
    end
endmodule
