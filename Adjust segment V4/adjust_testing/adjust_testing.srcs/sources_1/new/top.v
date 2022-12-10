// file: top.v
// author: @magdeldin

`timescale 1ns/1ns

module top(input clk, rst, BTNL, BTNR, BTND, BTNU, output  [6:0]seg, output  [3:0] anodes, output LD12, LD13, LD14, LD15

    );
    wire INL, INR, IND, INU;
    PushButton B1 (BTNL,clk_divided,INL);
    PushButton B2 (BTNR,clk_divided,INR);
    PushButton B3 (BTND,clk_divided,IND);
    PushButton B4 (BTNU,clk_divided,INU);
    wire [3:0] DTH, DH, DTM, DM;
    wire [1:0] sel_line;
    reg [3:0] num;
    ClockDivider #(500000) OneHz (clk, 1'b0, clk_divided);
    SelectCounter Select (clk,rst,1'b1,sel_line);
    Adjust HelpMe (clk_divided,rst, 1'b1,INL,INR,INU,IND, ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM, LD12, LD13, LD14, LD15, selected_adjust);
    AdjustDisplay NoReallyHelpMe (ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM, selected_adjust,DTH, DH, DTM, DM);
    always @ (*) begin
    case(sel_line)
    3: num = DTH;
    2: num = DH;
    1: num = DTM;
    0: num = DM;
    endcase
    end
    wire [3:0] num2 = num;
    decoder4x7p DCC (num2,sel_line,seg,anodes);
endmodule