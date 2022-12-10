// file: AdjustDisplay.v
// author: @magdeldin

`timescale 1ns/1ns

module AdjustDisplay (input [3:0] ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM, input [1:0] selected_adjust, output reg[3:0]
DTH, DH, DTM, DM);

always @(selected_adjust) begin
if (selected_adjust == 2'b00 || selected_adjust == 2'b01)begin
DTH = ATH;
DH = AH;
DTM = ATM;
DM = AM;
end

else begin
DTH = AJTH;
DH = AJH;
DTM = AJTM;
DM = AJM;
end

end

endmodule