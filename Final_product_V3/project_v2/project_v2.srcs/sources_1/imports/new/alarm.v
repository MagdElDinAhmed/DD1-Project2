`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 03:19:46 PM
// Design Name: 
// Module Name: alarm
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


module alarm(input clk, rst, en,
output LDA);
 reg LDA;
 always @(posedge clk) begin
 if (rst || !en) LDA<=0;
 else if (en) LDA<=~LDA;
 end
 

endmodule
