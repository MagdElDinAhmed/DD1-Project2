`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2022 06:12:35 PM
// Design Name: 
// Module Name: SelectCounter
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


module SelectCounter#(parameter n=4) (input clk,        
                      rst, en,                
                      output [1:0] count

    );
    wire clk_out;
    ClockDivider #(300000) DUUT (clk, rst, clk_out);
    X_Bit_Counter #(2,n) DUT (clk_out, rst, en, count);
endmodule
