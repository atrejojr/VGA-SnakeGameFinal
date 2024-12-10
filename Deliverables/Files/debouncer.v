`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 04:33:26 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk, button, 
    output reg clean,
    output reg [7:0] db_cnt
    );

    wire cnt_max = 8'hFF;
    
    always @(posedge clk) begin
        if(button == 0) begin
            db_cnt <= 0;
            clean <= 0;
            end
        else if(db_cnt == cnt_max) 
                clean <= 1; 
        else
            db_cnt <= db_cnt + 1; 
    end
     
endmodule





//    input wire clk,
//    input wire noisy_button,
//    output reg clean_button
//    );
    
//    parameter max_val = 200000;
//    reg [18:0] counter;
//    reg stability;
 
//    initial begin
//        counter = 0;
//        stability = 0;
//        clean_button = 0;
//    end
//    always @ (posedge clk) begin
//        if (noisy_button == stability)
//            counter <= 0; 
//        else
//            counter <= counter +1;
//        if (counter >= max_val) 
//            stability <= noisy_button;
//    end
// endmodule
