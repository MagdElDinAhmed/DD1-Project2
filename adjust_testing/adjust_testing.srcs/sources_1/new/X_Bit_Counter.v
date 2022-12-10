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
          
          if (UpDown)  begin
            if (out-1>=0) out<=out-1;
            else out<=n-1;
          end
          
          else begin
            if (out+1<=n-1) out<=out+1;
            else out<=0;
          end
        end
    end  
endmodule