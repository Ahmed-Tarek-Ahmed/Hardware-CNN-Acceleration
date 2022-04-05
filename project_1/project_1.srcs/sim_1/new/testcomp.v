`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2022 17:18:54
// Design Name: 
// Module Name: testcomp
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


module testcomp;
    reg [3:0] IN1;
    reg [3:0] IN2;
    wire [3:0] OUT;
    
    MaxComp Comp(
    .INPUT1  (IN1),
    .INPUT2 (IN2),
    .Out    (OUT)
    );    
    initial 
    begin
    assign IN1 = 4'd2;
    assign IN2 = 4'd3;
    #1
    assign IN1 = 4'd4;
    #1
    assign IN2  = 4'd5;
    #1
    $finish;
    end
endmodule
