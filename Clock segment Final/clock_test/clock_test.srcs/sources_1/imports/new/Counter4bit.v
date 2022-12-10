// file: Counter4bit.v
// author: @basmala

`timescale 1ns/1ns

module Counter4bit(input [3:0]data, input clk, en, load, output reg [3:0]count);

always@(posedge clk) begin
if(load == 1)
count <= data;
else if(en == 1)
count <= count + 1;
else 
count <= count;
//don't know if last condition needed. The else indicates that we do nothing
end

endmodule