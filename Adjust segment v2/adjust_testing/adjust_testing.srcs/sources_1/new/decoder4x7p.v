// file: decoder4x7p.v
// author: @magdeldin

`timescale 1ns/1ns

module decoder4x7p(input [3:0]X,input [1:0]en, output reg [6:0]seg, output reg [3:0] anodes

    );
   
    always @ (en,X) begin 
//    the commented if else statement was part of experiment 2
    //if (en==1)
    //begin
    //anodes=4'b1110;
    //end
    //else begin
    //anodes=4'b1111;
    //end
    //the case statement bit was part of experiment 4
    case(en)
    0: anodes=4'b1110;
    1: anodes=4'b1101;
    2: anodes=4'b1011;
    3: anodes=4'b0111;
    endcase
    
    case(X)
    0 : seg=7'b0000001;
    1 : seg=7'b1001111;
    2 : seg=7'b0010010;
    3 : seg=7'b0000110;
    4 : seg=7'b1001100;
    5 : seg=7'b0100100;
    6 : seg=7'b0100000;
    7 : seg=7'b0001111;
    8 : seg=7'b0000000;
    9 : seg=7'b0000100;
    //from 10 to 15 is part of experiment 3
    10: seg=7'b0001000;
    11: seg=7'b1100000;
    12: seg=7'b0110001;
    13: seg=7'b1000010;
    14: seg=7'b0110000;
    15: seg=7'b0111000;
    ///default : seg=7'b1111111; expirement 2
    endcase
    
    end
    
endmodule
