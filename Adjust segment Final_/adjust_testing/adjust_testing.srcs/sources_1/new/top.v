`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 09:57:51 AM
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


module top(input clk, rst, BTNL, BTNR, BTND, BTNU, output  [6:0]seg, output  [3:0] anodes, output LD12, LD13, LD14, LD15

    );
    wire INL, INR, IND, INU;
    PushButton B1 (BTNL,clk_divided,INL);
    PushButton B2 (BTNR,clk_divided,INR);
    PushButton B3 (BTND,clk_divided,IND);
    PushButton B4 (BTNU,clk_divided,INU);
    //wire [3:0] DTH, DH, DTM, DM;
    wire [3:0] ATH, AH, ATM, AM;
    wire [3:0] AJTH, AJH, AJTM, AJM;
    wire [1:0] selected_adjust;
    wire [1:0] sel_line;
    reg [3:0] num;
    ClockDivider #(500000) OneHz (clk, 1'b0, clk_divided);
    SelectCounter Select (clk,rst,1'b1,sel_line);
    Adjust HelpMe (clk_divided,rst, 1'b1,INL,INR,INU,IND, ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM, LD12, LD13, LD14, LD15, selected_adjust);
    //AdjustDisplay NoReallyHelpMe (ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM, selected_adjust,DTH, DH, DTM, DM);
    always @ (*) begin
    case(sel_line)
    3: if (selected_adjust[1]==0) num = ATH; else num = AJTH;
    2: if (selected_adjust[1]==0) num = AH; else num = AJH;
    1: if (selected_adjust[1]==0) num = ATM; else num = AJTM;
    0: if (selected_adjust[1]==0) num = AM; else num = AJM;
    endcase
    end
    wire [3:0] num2 = num;
    decoder4x7p DCC (num2,sel_line,seg,anodes);
endmodule
