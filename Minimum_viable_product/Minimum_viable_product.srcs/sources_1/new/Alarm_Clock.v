`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 02:49:22 PM
// Design Name: 
// Module Name: Alarm_Clock
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


module Alarm_Clock(input BTNC,BTNL,BTNR,BTND,BTNU,rst,clk, output [6:0]seg, output LD0, LD12, LD13, LD14, LD15,
    output [3:0] anodes
    );
    parameter [1:0] Clock=2'b00,
                    Adjust=2'b01,
                    Alarm=2'b10;  //Wire for modified button input
   
   //wires for the output
   wire [3:0] ATH, AH, ATM, AM;
   wire [3:0] AJTH, AJH, AJTM, AJM;
   wire [3:0] CTH, CH, CTM, CM;
   wire LD0, LD12, LD13, LD14, LD15;
   //wire for the select line from the adjust circuit
   wire [1:0] selected_adjust;
   //Wire for mode
   wire mode;
   
   
   //Wire for Number to be output on the display
   reg [3:0] Num_Out;
   
   //Registers for states
   reg [1:0] state, NextState;
   
   //Wires for the divided clock frequency
   wire One_Hundred_Hz, One_Hz;
   
   //wire for selection line to the 7 segment display before and after mode is accounted for
   wire [1:0] select_out;
   //wire [2:0] select_out; assign select_out={mode,select_out_temp};
   
   //Edge detectors, synchronisers and debouncers
   PushButton B1 (BTNC, One_Hundred_Hz, INC);
   PushButton B1a (BTNC, One_Hz, INC2);
   PushButton B2 (BTNL, One_Hundred_Hz, INL);
   PushButton B3 (BTNR, One_Hundred_Hz, INR);
   PushButton B4 (BTND, One_Hundred_Hz, IND);
   PushButton B5 (BTNU, One_Hundred_Hz, INU);
   
   //Clock dividers
   ClockDivider #(500000) One_Hundred_Hz_Divider (clk,rst,One_Hundred_Hz);
   ClockDivider #(5000000) One_Hz_Divider (clk,rst,One_Hz);
   
   //Counter to select the output to the 7 segment display
   SelectCounter select_counter (clk,rst,1,select_out);
   decoder4x7p decode (Num_Out, select_out, seg, anodes);
   
   //Adjust Circuit
   Adjust adjust_me (One_Hundred_Hz,rst, mode, INL,INR,INU,IND,ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM,LD12, LD13, LD14, LD15, selected_adjust);
   //module Clock_Circuit(input clk, INC2, Mode, input [3:0] AJTH, AJH, AJTM, AJM, output [3:0] CTH, CH, CTM, CM);
   Clock_Circuit cl(One_Hz, INC2,state, AJTH, AJH, AJTM, AJM, CTH, CH, CTM, CM);
   
   //Alarm Circuit
   alarm alarms (One_Hz, rst, alarm_enable,alarm_signal);
   
   always @(select_out) begin
   case (select_out)
   2'b00: 
   if (mode) begin
   if (selected_adjust[1]==0) Num_Out = AM; else Num_Out = AJM;
   end
   else Num_Out = CM;
   2'b01: 
   if (mode) begin
   if (selected_adjust[1]==0) Num_Out = ATM; else Num_Out = AJTM;
   end
   else Num_Out = CTM;
   2'b10: 
   if (mode) begin
   if (selected_adjust[1]==0) Num_Out = AH; else Num_Out = AJH;
   end
   else Num_Out = CH;
   2'b11:
   if (mode) begin 
   if (selected_adjust[1]==0) Num_Out = ATH; else Num_Out = AJTH;
   end
   else Num_Out = CTH;
   
   endcase
   end
   
   //state transitions
   always @(state,INC, INL, INR, IND, INU) begin
   case (state)
   Adjust: if (INC) NextState = Clock; else NextState = Adjust;
   Clock: if ( (ATH==CTH) && (AH==CH) && (ATM == CTM) && (AM == CM) ) NextState = Alarm;
   else if (INC) NextState = Adjust;
   else NextState = Clock;
   Alarm: if (INC || INL || INR || INU || IND) NextState = Clock; else NextState = Alarm;
   default: NextState = Clock;
   endcase
   end
   
   //state alteration
   always @(posedge One_Hundred_Hz, posedge rst) begin
   if (rst) state <= Clock;
   else
   state <= NextState;
   end
   
   assign alarm_enable = state==Alarm;
   assign LD0 = (state==Adjust) || (alarm_signal);
   assign mode = (state==Adjust);
   
   
endmodule
