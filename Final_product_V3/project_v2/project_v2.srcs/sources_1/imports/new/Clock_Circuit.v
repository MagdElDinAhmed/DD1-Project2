// file: Clock_Circuit.v
// author: @basmala

`timescale 1ns/1ns

module Clock_Circuit(input clk, rst, INC, Mode , adjust_flag, input [3:0] AJTH, AJH, AJTM, AJM, output [3:0] CTH, CH, CTM, CM);
//wires for seconds
wire [3:0]S, TS;


//counting seconds
Counter4bit c0(4'b0000, clk, rst, 1'b1, (S[0]== 1) && (S[3] == 1), 1'b0, S);
Counter4bit c1(4'b0000, clk, rst, (S== 9) , (TS==10), 1'b0, TS);

//Counting and setting clock Minutes
Counter4bit c2(AJM, clk, rst, (TS==10), (CM == 10), (INC&&Mode==1 && adjust_flag), CM);
Counter4bit c3(AJTM, clk, rst, (CM==10),(CTM == 6), (INC&&Mode==1 && adjust_flag), CTM);

//counting and adjusting clock hours
Counter4bit c4(AJH, clk, rst, (CTM== 6), ((CH == 4 && CTH==2) || (CH==10)), (INC&&Mode==1 && adjust_flag), CH);    
Counter4bit c5(AJTH, clk, rst, (CH==10), (CTH == 2 && CH == 4), (INC&&Mode==1 && adjust_flag), CTH);    


endmodule
