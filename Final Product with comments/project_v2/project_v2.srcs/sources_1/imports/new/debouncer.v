// file: debouncer.v
// author: @mohamedelshemy

`timescale 1ns/1ns

module debouncer(input clk, rst, in, output out);
reg q1,q2,q3;
always@(posedge clk, posedge rst) begin
//if rst button is pressed the debouncer is deactivated
 if(rst == 1'b1) begin
 q1 <= 0;
 q2 <= 0;
 q3 <= 0;
 end
 //the debouncer is delaying using 3 D flipflops to avoid the push buttons bounces
 else begin
 q1 <= in;
 q2 <= q1;
 q3 <= q2;
 end
end
assign out = (rst) ? 0 : q1&q2&q3;
endmodule