// file: RisingEdgeDetector.v
// author: @magdeldin

`timescale 1ns/1ns

module RisingEdgeDetector(input clk, rst, x, output z);
reg [1:0] state, NextState;
parameter [1:0] A=2'b00, B=2'b01, C=2'b10;

//transitions
always @(state, x) begin
case (state)
A: if (x==0) NextState=A; else NextState=B;
B: if (x==0) NextState=A; else NextState=C;
C: if (x==0) NextState=A; else NextState=C;
default: NextState=A;
endcase
end

always @ (posedge clk) begin
if (rst==1) state<=A;
else state <= NextState;
end
assign z = (state == B);
endmodule
