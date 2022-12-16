// file: RisingEdgeDetector.v
// author: @mohamedelshemy

`timescale 1ns/1ns
//the RisingEdgeDetector is used to indicate the onset of a slow time-varying input signal
//it generates a short one-clock-cycle tick when the input signal changes from 0 to 1
module RisingEdgeDetector(input clk, rst, x, output z);
reg [1:0] state, NextState;
parameter [1:0] A=2'b00, B=2'b01, C=2'b10;

//Next state assignments
always @(state, x) begin
case (state)
A: if (x==0) NextState=A; else NextState=B;
B: if (x==0) NextState=A; else NextState=C;
C: if (x==0) NextState=A; else NextState=C;
default: NextState=A;
endcase
end

//state transitions
always @ (posedge clk) begin
if (rst==1) state<=A;
else state <= NextState;
end
assign z = (state == B);
endmodule