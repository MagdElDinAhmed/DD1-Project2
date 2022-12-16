// file: PushButton.v
// author: @mohamedelshemy

`timescale 1ns/1ns

module PushButton(input x, clk, output out

    );

    wire t1,t2;
//the debouncer is delaying using 3 D flipflops to avoid the push buttons bounces
    debouncer debounc (clk, 1'b0, x, t1);
//the synchronizer is delaying using flipflops to avoid the push buttons bounces
    synchronizer sync (clk, 1'b0, t1, t2);
//the RisingEdgeDetector is used to indicate the onset of a slow time-varying input signal
//it generates a short one-clock-cycle tick when the input signal changes from 0 to 1
    RisingEdgeDetector risingedge (clk, 1'b0, t2, out);
    
endmodule
