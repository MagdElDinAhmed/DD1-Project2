`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 06:11:37 PM
// Design Name: 
// Module Name: X_Bit_Counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module X_Bit_Counter#(parameter x = 3, n=8)(input clk,        
                      input rst, en,                
                      output reg[x-1:0] out

    );
    always @ (posedge clk or posedge rst) begin  
        if (rst)  
          out <= 0;
        else if (en)
        begin
          
        if (out<n-1)  
          out <= out + 1;
        else
          out <= 0;
          
        end  
    end  
endmodule
