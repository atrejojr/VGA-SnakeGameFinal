`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 06:12:36 PM
// Design Name: 
// Module Name: button_inputs
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

module button_inputs(
    input clk, reset,
    input up, down, left, right,  // Input from buttons
    output reg [2:0] direction  // Output direction (00=right, 01=down, etc.)
);

    wire c_up, c_down, c_left, c_right;
    debouncer clean_up(.clk(clk), .button(up), .clean(c_up));
    debouncer clean_down(.clk(clk), .button(down), .clean(c_down));
    debouncer clean_left(.clk(clk), .button(left), .clean(c_left));
    debouncer clean_right(.clk(clk), .button(right), .clean(c_right));
    
    initial begin
        direction <= 3'b100;
   end
   
    always @(posedge clk) begin
        if (reset)
            direction <= 3'b100;
        else begin
            if (c_up) direction <= 3'b011;        // up
            // For some reson, the directions for up and down got swapped for the button mapping...
            else if (c_down) direction <= 3'b001;  // down
            else if (c_left) direction <= 3'b010; //left
            else if (c_right) direction <= 3'b000; // right
        end
    end
endmodule
