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
wire [3:0] ATM, AM, AJTH, AJH, AJTM, AJM;
reg [3:0] ATH, AH, AJTH, AJH;

//temporary outputs to account for the 24 hour cycle
wire [4:0] AH_temp;
wire [4:0] AJH_temp;

//wires for enabling adjusting alarm hours
wire enable_alarm_hours; assign enable_alarm_hours = en&&(selected_adjust==2'b10);
wire enable_ten_alarm_hours; assign enable_ten_alarm_hours = (enable_alarm_hours && AH==9);

//wires for enabling adjusting alarm minutes
wire enable_alarm_minutes; assign enable_alarm_minutes = en&&(selected_adjust==2'b11);
wire enable_ten_alarm_minutes; assign enable_ten_alarm_minutes = (enable_alarm_minutes && AM==9);

//wires for enabling adjusting clock hours
wire enable_clock_hours; assign enable_clock_hours = en&(selected_adjust==2'b00);
wire enable_ten_clock_hours; assign enable_ten_clock_hours = (enable_clock_hours && AJH==9);

//wires for enabling adjusting clock minutes
wire enable_clock_minutes; assign enable_clock_minutes = en&(selected_adjust==2'b01);
wire enable_ten_clock_minutes; assign enable_ten_clock_minutes = (enable_clock_minutes && AJM==9);

//X_Bit_Counter to select between adjusting alarm hour, alarm minute, clock hour and clock minute
X_Bit_Counter #(2,4) Select_Adjust (clk,rst ,en&(INL|INR),INL,selected_adjust);

assign LD12 = en &&(selected_adjust==2'b11);
assign LD13 = en &&(selected_adjust==2'b10);
assign LD14 = en&&(selected_adjust==2'b01);
assign LD15 = en&&(selected_adjust==2'b00);

//X_Bit_Counters to change the alarm hour
//X_Bit_Counter #(4,10) Adjust_Alarm_Hour (clk,rst ,enable_alarm_hours && (IND||INU),IND,AH); //clock would go up to 29 before resetting to 0
//X_Bit_Counter #(4,3) Adjust_Alarm_Ten_Hour (clk,rst ,enable_alarm_hours &&((AH==9 && INU)|| (AH==0 && IND)),IND,ATH);
X_Bit_Counter #(5,24) Adjust_Alarm_Hour (clk,rst,enable_alarm_hours & (IND|INU), IND,AH_temp);

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
X_Bit_Counter #(4,10) Adjust_Alarm_Minute (clk,rst ,enable_alarm_minutes&&(IND||INU),IND,AM);
X_Bit_Counter #(4,6) Adjust_Alarm_Ten_Minute (clk,rst , enable_alarm_minutes&&((AM==9 && INU)|| (AM==0 && IND)),IND,ATM);

//X_Bit_Counters to change the clock hour
//X_Bit_Counter #(4,10) Adjust_Clock_Hour (clk,rst ,enable_clock_hours&&(IND||INU),IND,AJH);
//X_Bit_Counter #(4,3) Adjust_Clock_Ten_Hour (clk,rst ,enable_clock_hours&&((AJH==9 && INU)|| (AJH==0 && IND)),IND,AJTH);

X_Bit_Counter #(5,24) Adjust_Clock_Hour (clk,rst,enable_clock_hours & (IND|INU), IND,AJH_temp);
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
X_Bit_Counter #(4,10) Adjust_Clock_Minute (clk,rst ,enable_clock_minutes&&(IND||INU),IND,AJM);
X_Bit_Counter #(4,6) Adjust_Clock_Ten_Minute (clk,rst ,enable_clock_minutes&&((AJM==9 && INU) || (AJM==0 && IND)),IND,AJTM);
endmodule