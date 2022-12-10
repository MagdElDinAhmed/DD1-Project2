// file: SelectCounter.v
// author: @magdeldin

`timescale 1ns/1ns

module SelectCounter#(parameter n=4) (input clk,        
                      rst, en,                
                      output [1:0] count

    );
    wire clk_out;
    ClockDivider #(300000) DUUT (clk, rst, clk_out);
    X_Bit_Counter #(2,n) DUT (clk_out, rst, en, 1'b0, count);
endmodule