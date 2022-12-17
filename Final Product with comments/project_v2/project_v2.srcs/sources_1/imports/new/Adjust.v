// file: Adjust.v
// author: @mohamedelshemy

`timescale 1ns/1ns

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

module Adjust(input clk, rst, en, INL, INR, INU, IND, INC, output [3:0] ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM,
output LD12, LD13, LD14, LD15, adjust_flag, output [1:0] selected_adjust);
//wire to select the adjusted part
reg [1:0] selected_adjust, NextState;
wire [3:0] ATM, AM, AJTM, AJM;
reg [3:0] ATH, AH, AJTH, AJH;

//wire to flag adjusting of clock
reg adjust_flag;
always @(posedge clk or posedge rst or posedge INC) begin
if (rst) adjust_flag<=1'b0;
else if (en && INC) adjust_flag<=1'b0;
else if (en && (selected_adjust == 2'b00 || selected_adjust == 2'b01) && (IND || INU)) adjust_flag=1'b1;
end

//parameters for states
parameter adjust_alarm_hour = 2'b10, adjust_alarm_minute = 2'b11, adjust_clock_hour = 2'b00, adjust_clock_minute = 2'b01;


//state transition
always @ (selected_adjust, INL, INR) begin
case (selected_adjust)
adjust_alarm_hour: if (INL) NextState = adjust_clock_minute; else if (INR) NextState = adjust_alarm_minute; else NextState = adjust_alarm_hour;
adjust_alarm_minute: if (INL) NextState = adjust_alarm_hour; else if (INR) NextState = adjust_clock_hour; else NextState = adjust_alarm_minute;
adjust_clock_hour: if (INL) NextState = adjust_alarm_minute; else if (INR) NextState = adjust_clock_minute; else NextState = adjust_clock_hour;
adjust_clock_minute: if (INL) NextState = adjust_clock_hour; else if (INR) NextState = adjust_alarm_hour; else NextState = adjust_clock_minute;
endcase
end

//transition statements
always @ (posedge clk or posedge rst) begin
if (rst) selected_adjust<=adjust_clock_hour;
else
selected_adjust<=NextState;
end
//temporary outputs to account for the 24 hour cycle
wire [4:0] AH_temp;
wire [4:0] AJH_temp;

//wires for enabling adjusting alarm hours
wire enable_alarm_hours; assign enable_alarm_hours = en&&(selected_adjust==2'b10)  && (IND|INU);


//wires for enabling adjusting alarm minutes
wire enable_alarm_minutes; assign enable_alarm_minutes = en&&(selected_adjust==2'b11)&&(IND||INU);
wire enable_ten_alarm_minutes; assign enable_ten_alarm_minutes = enable_alarm_minutes&&((AM==9 && INU)|| (AM==0 && IND));

//wires for enabling adjusting clock hours
wire enable_clock_hours; assign enable_clock_hours = en&&(selected_adjust==2'b00) && (IND|INU);

//wires for enabling adjusting clock minutes
wire enable_clock_minutes; assign enable_clock_minutes = en&&(selected_adjust==2'b01)&&(IND||INU);
wire enable_ten_clock_minutes; assign enable_ten_clock_minutes = enable_clock_minutes&&((AJM==9 && INU) || (AJM==0 && IND));

//X_Bit_Counter to select between adjusting alarm hour, alarm minute, clock hour and clock minute
//X_Bit_Counter #(2,4) Select_Adjust (clk,rst ,en&(INL|INR),INL,selected_adjust);

assign LD12 = en &&(selected_adjust==2'b11);
assign LD13 = en &&(selected_adjust==2'b10);
assign LD14 = en&&(selected_adjust==2'b01);
assign LD15 = en&&(selected_adjust==2'b00);

//X_Bit_Counter to change the alarm hour
X_Bit_Counter #(5,24) Adjust_Alarm_Hour (clk,rst,enable_alarm_hours, IND,AH_temp);

always @(AH_temp) begin

case (AH_temp)
0: begin ATH=0;
AH=0;
end

1: begin ATH=0;
AH=1;
end

2: begin ATH=0;
AH=2;
end

3: begin ATH=0;
AH=3;
end

4: begin ATH=0;
AH=4;
end

5: begin ATH=0;
AH=5;
end

6: begin ATH=0;
AH=6;
end

7: begin ATH=0;
AH=7;
end

8: begin ATH=0;
AH=8;
end

9: begin ATH=0;
AH=9;
end

10: begin ATH=1;
AH=0;
end

11: begin ATH=1;
AH=1;
end

12: begin ATH=1;
AH=2;
end

13: begin ATH=1;
AH=3;
end

14: begin ATH=1;
AH=4;
end

15: begin ATH=1;
AH=5;
end

16: begin ATH=1;
AH=6;
end

17: begin ATH=1;
AH=7;
end

18: begin ATH=1;
AH=8;
end

19: begin ATH=1;
AH=9;
end

20: begin ATH=2;
AH=0;
end

21: begin ATH=2;
AH=1;
end

22: begin ATH=2;
AH=2;
end

23: begin ATH=2;
AH=3;
end

default: begin ATH=0;
AH=0;
end
endcase

end 

//X_Bit_Counters to change the alarm minute
X_Bit_Counter #(4,10) Adjust_Alarm_Minute (clk,rst ,enable_alarm_minutes,IND,AM);
X_Bit_Counter #(4,6) Adjust_Alarm_Ten_Minute (clk,rst , enable_alarm_minutes && ((AM==9 && INU)|| (AM==0 && IND)) ,IND,ATM);

//X_Bit_Counter to change the clock hour


X_Bit_Counter #(5,24) Adjust_Clock_Hour (clk,rst,enable_clock_hours, IND,AJH_temp);
always @(AJH_temp) begin

case (AJH_temp)
0: begin AJTH=0;
AJH=0;
end

1: begin AJTH=0;
AJH=1;
end

2: begin AJTH=0;
AJH=2;
end

3: begin AJTH=0;
AJH=3;
end

4: begin AJTH=0;
AJH=4;
end

5: begin AJTH=0;
AJH=5;
end

6: begin AJTH=0;
AJH=6;
end

7: begin AJTH=0;
AJH=7;
end

8: begin AJTH=0;
AJH=8;
end

9: begin AJTH=0;
AJH=9;
end

10: begin AJTH=1;
AJH=0;
end

11: begin AJTH=1;
AJH=1;
end

12: begin AJTH=1;
AJH=2;
end

13: begin AJTH=1;
AJH=3;
end

14: begin AJTH=1;
AJH=4;
end

15: begin AJTH=1;
AJH=5;
end

16: begin AJTH=1;
AJH=6;
end

17: begin AJTH=1;
AJH=7;
end

18: begin AJTH=1;
AJH=8;
end

19: begin AJTH=1;
AJH=9;
end

20: begin AJTH=2;
AJH=0;
end

21: begin AJTH=2;
AJH=1;
end

22: begin AJTH=2;
AJH=2;
end

23: begin AJTH=2;
AJH=3;
end

default: begin AJTH=0;
AJH=0;
end
endcase

end 

//X_Bit_Counters to change the clock minute
X_Bit_Counter #(4,10) Adjust_Clock_Minute (clk,rst ,enable_clock_minutes,IND,AJM);
X_Bit_Counter #(4,6) Adjust_Clock_Ten_Minute (clk,rst ,enable_clock_minutes && ((AJM==9 && INU) || (AJM==0 && IND)),IND,AJTM);
endmodule
