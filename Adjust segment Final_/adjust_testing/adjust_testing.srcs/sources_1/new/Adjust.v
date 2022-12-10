// file: Adjust.v
// author: @magdeldin

`timescale 1ns/1ns
//Term Guide:
//INL: Input from BTNL after processing
//INR: Input from BTNR after processing
//INU: Input from BTNU after processing
//IND: Input from BTND after processing

//ATH: The BCD for the ten hours portion of the alarm time
//AH: The BCD for the hours portion of the alarm time
//AJTH: The BCD for the ten hours portion of the adjusted clock time
//AJH: The BCD for the hours portion of the adjusted clock time
//AJTM: The BCD for the ten minutes portion of the adjusted clock time
//AJM: The BCD for the minutes portion of the adjusted clock time


module Adjust(input clk,rst, en, INL,INR,INU,IND,output [3:0] ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM,
output LD12, LD13, LD14, LD15, output [1:0] selected_adjust);
//wire to select the adjusted part
wire [1:0] selected_adjust;
wire [3:0] ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM;

//temporary outputs to account for the 24 hour cycle
wire [3:0] AH_temp1, AH_temp2;
wire [3:0] AJH_temp1, AJH_temp2;

//wires for enabling adjusting alarm hours
wire enable_alarm_hours; assign enable_alarm_hours = en&&(selected_adjust==2'b00);
wire enable_ten_alarm_hours; assign enable_ten_alarm_hours = (enable_alarm_hours && AH==9);

//wires for enabling adjusting alarm minutes
wire enable_alarm_minutes; assign enable_alarm_minutes = en&&(selected_adjust==2'b01);
wire enable_ten_alarm_minutes; assign enable_ten_alarm_minutes = (enable_alarm_minutes && AM==9);

//wires for enabling adjusting clock hours
wire enable_clock_hours; assign enable_clock_hours = en&(selected_adjust==2'b10);
wire enable_ten_clock_hours; assign enable_ten_clock_hours = (enable_clock_hours && AJH==9);

//wires for enabling adjusting clock minutes
wire enable_clock_minutes; assign enable_clock_minutes = en&(selected_adjust==2'b11);
wire enable_ten_clock_minutes; assign enable_ten_clock_minutes = (enable_clock_minutes && AJM==9);

//X_Bit_Counter to select between adjusting alarm hour, alarm minute, clock hour and clock minute
X_Bit_Counter #(2,4) Select_Adjust (clk,rst ,en&(INL|INR),INL,selected_adjust);

assign LD12 = (selected_adjust==2'b11);
assign LD13 = (selected_adjust==2'b10);
assign LD14 = (selected_adjust==2'b01);
assign LD15 = (selected_adjust==2'b00);

//X_Bit_Counters to change the alarm hour
X_Bit_Counter #(4,10) Adjust_Alarm_Hour (clk,rst ,enable_alarm_hours && (IND||INU),IND,AH); //clock would go up to 29 before resetting to 0
X_Bit_Counter #(4,3) Adjust_Alarm_Ten_Hour (clk,rst ,enable_alarm_hours &&((AH==9 && INU)|| (AH==0 && IND)),IND,ATH);

//X_Bit_Counters to change the alarm minute
X_Bit_Counter #(4,10) Adjust_Alarm_Minute (clk,rst ,enable_alarm_minutes&&(IND||INU),IND,AM);
X_Bit_Counter #(4,6) Adjust_Alarm_Ten_Minute (clk,rst , enable_alarm_minutes&&((AM==9 && INU)|| (AM==0 && IND)),IND,ATM);

//X_Bit_Counters to change the clock hour
X_Bit_Counter #(4,10) Adjust_Clock_Hour (clk,rst ,enable_clock_hours&&(IND||INU),IND,AJH);
X_Bit_Counter #(4,3) Adjust_Clock_Ten_Hour (clk,rst ,enable_clock_hours&&((AJH==9 && INU)|| (AJH==0 && IND)),IND,AJTH);

//X_Bit_Counters to change the clock minute
X_Bit_Counter #(4,10) Adjust_Clock_Minute (clk,rst ,enable_clock_minutes&&(IND||INU),IND,AJM);
X_Bit_Counter #(4,6) Adjust_Clock_Ten_Minute (clk,rst ,enable_clock_minutes&&((AJM==9 && INU) || (AJM==0 && IND)),IND,AJTM);
endmodule