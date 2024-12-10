`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 06:17:04 PM
// Design Name: 
// Module Name: refclk
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


module refclk(clk, reset, newClk);
    input clk, reset;
    output newClk;
    
    reg [29:0] cnt = 0;
    parameter toggleVal = 10_000-1; // Not sure about the math but value allows for good refresh
    reg tempClk = 0;
    
    assign newClk = tempClk;
    
    always@(posedge clk)
    begin        
        if(reset)
        begin
            cnt <=0;
            tempClk <= 0;
        end
        else
        begin
            if(cnt < toggleVal)
                cnt = cnt + 1;
            else
            begin
                cnt <= 0;
                tempClk = ~tempClk;
            end    
       end
    end
endmodule
