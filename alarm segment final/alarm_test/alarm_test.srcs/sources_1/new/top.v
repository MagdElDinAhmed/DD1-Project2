`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 03:41:26 PM
// Design Name: 
// Module Name: top
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


module top(input clk, rst, output  LD0

    );
    
    ClockDivider AAAAA (clk,rst,clk_divided);
    alarm (clk_divided,rst,1'b1, LD0);
    //SecMinCounter DC (clk,rst,1'b1,seconds, minutes,ten_seconds, ten_minutes);
    SelectCounter Select (clk,rst,1'b1,sel_line);
    
    
endmodule

