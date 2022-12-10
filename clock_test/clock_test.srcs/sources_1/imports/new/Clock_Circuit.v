// file: Clock_Circuit.v
// author: @basmala

`timescale 1ns/1ns

module Clock_Circuit(input clk, INC2, Mode, input [3:0] AJTH, AJH, AJTM, AJM, output [3:0] CTH, CH, CTM, CM);
//wires for seconds
wire [3:0]S, TS;
//selection wires
wire [3:0]s1, s2, s3, s4;
//counting seconds
Counter4bit c0(4'b0000, clk, 1'b1, (S[0]== 1) && (S[3] == 1), S);
Counter4bit c1(4'b0000, clk, (S[0]== 1) && (S[3] == 1), (TS[1]==1) && (TS[3]==1), TS);
//counting and adjusting minutes
mux2_1 m0(AJM, 4'b0000, INC2, s1);
Counter4bit c2(s1, clk, (TS[1]==1) && (TS[3]==1), ((Mode == 1 && INC2 ==1) || (CM[0] == 1 && CM[3] == 1)), CM);
mux2_1 m1(AJTM, 4'b0000, INC2, s2);
Counter4bit c3(s2, clk, (CM[0] == 1 && CM[3] == 1),((Mode == 1 && INC2 ==1) || (CTM[1] == 1 && CTM[2] == 1)), CTM);
//counting and agjusting hours
mux2_1 m2(AJH, 4'b0000, INC2, s3);
Counter4bit c4(s3, clk, (CTM[1] == 1 && CTM[2] == 1), (((CH == 4 && CTH==2) || (CH==10)) || (Mode == 1 && INC2 ==1)), CH);    
mux2_1 m3(AJTH, 4'b0000, INC2, s4);
Counter4bit c5(s4, clk, (CH==10), (CTH[1] == 1 && CH == 4)|| (Mode == 1 && INC2 ==1), CTH);    

endmodule













