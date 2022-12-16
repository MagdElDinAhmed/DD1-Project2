// file: alarm.v
// author: @mohamedelshemy

`timescale 1ns/1ns

module alarm(input clk, rst, en,
output LDA);
reg LDA;
always @(posedge clk) begin
//alarm LED output = 0 when rst button is pressed
if (rst || !en) LDA<=0;
//alarm LED output is blinking when en = 1 "alarm = clock"
else if (en) LDA<=~LDA;
end
endmodule