// file: PushButton.v
// author: @magdeldin

`timescale 1ns/1ns

module PushButton(input x, clk, output out

    );

    wire t1,t2;

    debouncer debounc (clk, 1'b0, x, t1);
    synchronizer sync (clk, 1'b0, t1, t2);
    RisingEdgeDetector risingedge (clk, 1'b0, t2, out);
    
endmodule
