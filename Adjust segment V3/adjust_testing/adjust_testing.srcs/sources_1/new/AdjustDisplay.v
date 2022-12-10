// file: AdjustDisplay.v
// author: @magdeldin

`timescale 1ns/1ns

module AdjustDisplay (input [3:0] ATH, AH, ATM, AM, AJTH, AJH, AJTM, AJM, input [1:0] selected_adjust, output reg[3:0]
DTH, DH, DTM, DM);

wire[3:0] DTH, DH, DTM, DM;
/*
assign DTH = selected_adjust[1] ? AJTH : ATH;
assign DH = selected_adjust[1] ? AJH : AH;
assign DTM = selected_adjust[1] ? AJTM : ATM;
assign DM = selected_adjust[1] ? AJM : AM;
*/

always @(selected_adjust) begin
if (selected_adjust== 2'b00 || selected_adjust== 2'b01) begin
DTH = ATH;
DH = AH;
DTM = ATM;
DM = AM;
end

else if (selected_adjust== 2'b10 || selected_adjust== 2'b11) begin
DTH = AJTH;
DH = AJH;
DTM = AJTM;
DM = AJM;
end

end

endmodule