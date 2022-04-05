`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2022 14:18:44
// Design Name: 
// Module Name: ReLu
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


module ReLu
#(parameter size = 3)
(
input [size:0] INPUT1,
output [size:0] Out
);
reg Output;



assign Out = INPUT1[size]?0000:INPUT1;
  


endmodule
