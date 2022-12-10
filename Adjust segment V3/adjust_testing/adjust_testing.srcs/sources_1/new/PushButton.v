// file: PushButton.v
// author: @magdeldin

`timescale 1ns/1ns

module PushButton(input x, clk, output out

    );
    //wire clk_divide, clk_tmp;
    wire t1,t2;
    //ClockDivider  #(500000) divide (clk,1'b0,clk_tmp);
    //assign clk_divide = clk_tmp;
    debouncer debounc (clk, 1'b0, x, t1);
    synchronizer sync (clk, 1'b0, t1, t2);
    RisingEdgeDetector risingedge (clk, 1'b0, t2, out);
    
endmodule
