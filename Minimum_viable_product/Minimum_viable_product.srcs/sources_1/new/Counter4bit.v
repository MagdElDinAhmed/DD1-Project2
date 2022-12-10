// file: Counter4bit.v
// author: @basmala

`timescale 1ns/1ns

module Counter4bit(input [3:0]data, input clk,rst, en, load_zero, load_value, output reg [3:0]count);

always@(posedge clk or posedge rst or posedge load_value) begin
if (rst) 
count <= 0;

else if(load_value)
count <= data;

else if (load_zero)
count<=0;

else if(en)
count <= count + 1;
else count<=count;
end


endmodule