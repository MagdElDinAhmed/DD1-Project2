// file: X_Bit_Counter.v
// author: @magdeldin

`timescale 1ns/1ns

module X_Bit_Counter #(parameter x = 4, n=10)(input clk,        
                      input rst, en, UpDown,                
                      output reg[x-1:0] out

    );

    always @ (posedge clk or posedge rst) begin  
        
        
        if (rst)  
          out <= 0;
        else if (en)
        begin
          if (UpDown) begin
          if (out-1<=0) out=n-1;
          end
        if (out<n-1)begin  
          if (UpDown)out <= out - 1;
          else out<= out+1;
        end
        else
          out <= 0;
          
        end  
    end  
endmodule