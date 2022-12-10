// file: mux2_1.v
// author: @basmala

`timescale 1ns/1ns

module mux2_1(input [3:0]x, y, input s, output [3:0]selected);

assign selected= (s == 1)? x:y;

endmodule