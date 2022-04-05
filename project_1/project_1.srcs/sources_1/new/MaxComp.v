`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2022 16:35:24
// Design Name: 
// Module Name: MaxComp
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


module MaxComp
    #(parameter size = 3)
    (
    input [size:0] INPUT1,
    input [size:0] INPUT2,
    output [size:0] Out
    );
    
assign Out = INPUT1>INPUT2?INPUT1:INPUT2;

endmodule
