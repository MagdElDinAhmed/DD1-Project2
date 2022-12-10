`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 04:31:31 PM
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


module top(input clk, rst, output  [6:0]seg,  [3:0] anodes

    );
    wire [3:0] hours, minutes;
    wire [2:0] ten_hours, ten_minutes;
    wire [1:0] sel_line;
    reg [3:0] num;
    ClockDivider #(5000) AAAAA (clk,rst,clk_divided);
    Clock_Circuit (clk_divided,1'b0,1'b0,4'b0, 4'b0, 4'b0, 4'b0,ten_hours, hours, ten_minutes, minutes);
    //SecMinCounter DC (clk,rst,1'b1,seconds, minutes,ten_seconds, ten_minutes);
    SelectCounter Select (clk,rst,1'b1,sel_line);
    
    always @ (*) begin
    case(sel_line)
    3: num = ten_hours;
    2: num = hours;
    1: num = ten_minutes;
    0: num = minutes;
    endcase
    end
    wire [3:0] num2 = num;
    decoder4x7p DCC (num2,sel_line,seg,anodes);
endmodule
