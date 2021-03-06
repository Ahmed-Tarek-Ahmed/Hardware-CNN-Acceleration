`timescale 1ns / 1ps 
module mux_emb#(parameter size=32)(
input [size*8-1:0] y1,
input [size*8-1:0] y2,
input [size*8-1:0] y3,
input [size*8-1:0] y4,
input [size*8-1:0] y5,
input [2:0]sel,
output reg [size*8-1:0] x
 );
   
  always @(y1, y2, y3, y4, y5, sel)
    begin 
      case(sel)
      3'b000:x = y1;
      3'b001:x = y2;
      3'b010:x = y3;
      3'b011:x = y4;
      3'b100:x = y5;
      default:x = 0;
      endcase
end  
endmodule