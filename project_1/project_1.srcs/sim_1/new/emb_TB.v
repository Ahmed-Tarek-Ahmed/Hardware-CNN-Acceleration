`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2022 17:53:48
// Design Name: 
// Module Name: emb_TB
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


module emb_TB ;
reg [15:0] y1 ;
reg [15:0] y2 ;
reg [15:0] y3 ;
reg [15:0] y4 ;
reg [15:0] y5 ;
reg [2:0] sel;
wire [15:0] x;

mux_emb dut(.y1(y1), .y2(y2), .y3(y3), .y4(y4), .y5(y5), .sel(sel), .x(x));
initial begin
$monitor ("y1=%h y2=%h y3=%h y4=%h y5=%h sel=%b ",y1,y2,y3,y4,y5,sel) ;
y1 = 0; y2 = 0; y3 = 0; y4 = 0; y5 = 0; sel = 0000; // starts execution at t=0
#10 y1 = 16'haa00; y2 = 16'h0ab0; y3 = 16'h1230; y4 = 16'h7890; y5 = 16'hfea0; sel = 000; // execution at t = 10 time units
#10 y1 = 16'haa00; y2 = 16'h0ab0; y3 = 16'h1230; y4 = 16'h7890; y5 = 16'hfea0; sel = 001; // execution at t = 20 time units 
#10 y1 = 16'haa00; y2 = 16'h0ab0; y3 = 16'h1230; y4 = 16'h7890; y5 = 16'hfea0; sel = 010;
#10 y1 = 16'haa00; y2 = 16'h0ab0; y3 = 16'h1230; y4 = 16'h7890; y5 = 16'hfea0; sel = 011;
#10 y1 = 16'haa00; y2 = 16'h0ab0; y3 = 16'h1230; y4 = 16'h7890; y5 = 16'hfea0; sel = 100; //execution at t = 30 time units 
#10 ;
$finish ;
end
endmodule
