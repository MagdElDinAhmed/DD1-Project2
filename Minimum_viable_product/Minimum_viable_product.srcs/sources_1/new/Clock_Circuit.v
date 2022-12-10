// file: Clock_Circuit.v
// author: @basmala

`timescale 1ns/1ns

module Clock_Circuit(input clk, rst, INC2, Mode, input [3:0] AJTH, AJH, AJTM, AJM, output [3:0] CTH, CH, CTM, CM);
//wires for seconds
wire [3:0]S, TS;
//selection wires
wire [3:0]s1, s2, s3, s4;
//reg [3:0] d1,d2,d3,d4;
//counting seconds
Counter4bit c0(4'b0000, clk, rst, 1'b1, (S[0]== 1) && (S[3] == 1), 1'b0, S);
Counter4bit c1(4'b0000, clk, rst, (S== 9) , (TS==10), 1'b0, TS);
//counting and adjusting minutes
//mux2_1 m0(AJM, 4'b0000, INC2, s1);
//always @(posedge clk) begin
//if (INC2==1) begin
//d1 = AJM;
//d2 = AJTM;
//d3 = AJH;
//d4 = AJTH;
//end
//else begin
//d1 = 4'b0000;
//d2 = 4'b0000;
//d3 = 4'b0000;
//d4 = 4'b0000;
//end
//end
Counter4bit c2(AJM, clk, rst, (TS==10), (CM == 10), (INC2&&Mode==1), CM);
//mux2_1 m1(AJTM, 4'b0000, INC2, s2);
Counter4bit c3(AJTM, clk, rst, (CM==10),(CTM == 6), (INC2&&Mode==1), CTM);
//counting and agjusting hours
//mux2_1 m2(AJH, 4'b0000, INC2, s3);
Counter4bit c4(AJH, clk, rst, (CTM== 6), ((CH == 4 && CTH==2) || (CH==10)), (INC2&&Mode==1), CH);    
//mux2_1 m3(AJTH, 4'b0000, INC2, s4);
Counter4bit c5(AJTH, clk, rst, (CH==10), (CTH == 2 && CH == 4), (INC2&&Mode==1), CTH);    


endmodule
