`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 02:17:06 PM
// Design Name: 
// Module Name: BCD_to_Cathodes
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


module countercontrol(
input [7:0]outscore, // number in counter
input [2:0] refcnt, 

output reg [7:0] dig  // the number displayed
    );
    reg count;

    always@(refcnt)
    begin
    
    // original comments follow. Not Larkin's
    
    case(refcnt)
        3'd000: begin //First digit
            dig <= outscore % 10; 
        end
    // ONLY COUNTS TO 69    
        3'd001: begin //Second digit
            if(outscore > 6'b111011)begin
                dig <= 8'b00000110;
            end
            else if(outscore > 6'b110001) begin
                dig <= 8'b00000101;
            end
            else if(outscore > 6'b100111) begin
                dig <= 8'b00000100;
            end
            else if(outscore > 5'b11101) begin
                dig <= 8'b00000011;
            end
            else if(outscore > 5'b10011) begin
                dig <= 8'b00000010;
            end
            else if(outscore > 4'b1001) begin
                dig <= 8'b00000001;
            end
            else
                dig = 8'b11111111;
        end
    
        3'd2: dig = 8'b11111110;//Third digit -> -
        
        3'd3: dig = 8'b00001110;// Fourth digit -> E
        3'd4: dig = 8'b00001011;// Fifth digit -> R
        3'd5: dig = 8'b00000000;// Sixth digit -> O
        3'd6: dig = 8'b00001100;// Seventh digit -> C
        3'd7: dig = 8'b00001010;// Eighth digit -> S
     endcase
  end
endmodule
