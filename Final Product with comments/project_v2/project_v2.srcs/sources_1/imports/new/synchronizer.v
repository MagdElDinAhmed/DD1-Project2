// file: synchronizer.v
// author: @mohamedelshemy

`timescale 1ns/1ns
//the synchronizer is delaying using flipflops to avoid the push buttons bounces
module synchronizer(input clk, rst, in, output out);
reg q1,q2;
always@(posedge clk, posedge rst) begin
 if(rst == 1'b1) begin
 q1 <= 0;
 q2 <= 0;

 end
 else begin
 q1 <= in;
 q2 <= q1;

 end
end
assign out = q2;
endmodule