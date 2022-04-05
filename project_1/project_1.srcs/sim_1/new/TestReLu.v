`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2022 14:53:11
// Design Name: 
// Module Name: TestReLu
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


module TestReLu;

reg [3:0] IN1;
wire [3:0] O;

ReLu R (IN1,O);


initial 
begin

assign IN1 = 4'd4;
#1
assign IN1 = 4'd7;
#1
assign IN1 = 4'd9;
#1
assign IN1 = 4'd15;
#1

$finish;
end
endmodule
