`timescale 1ns / 1ps

// GOAL: CLK DIVIDER FROM 100MHz -> 25 MHz

module clk_divider(clk, reset, newClk);
    
    input clk, reset;
    output newClk;
    
    reg [29:0] cnt = 0;
    parameter toggleVal = 1; // Still confused about this value
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
