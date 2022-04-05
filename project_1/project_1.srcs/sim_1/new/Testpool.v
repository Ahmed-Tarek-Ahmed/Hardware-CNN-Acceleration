`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2022 18:24:57
// Design Name: 
// Module Name: Testpool
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


module Testpool;

    reg [3:0] IN1;
    reg [3:0] IN2;
    reg [3:0] IN3;
    reg [3:0] IN4;
    reg [3:0] IN5;
    reg [3:0] IN6;
    reg [3:0] IN7;
    reg [3:0] IN8;
    reg [3:0] IN9;
    wire [3:0] OUT;
    
    MaxPoolUnit A(IN1,IN2,IN3,IN4,IN5,IN6,IN7,IN8,IN9,OUT);

    initial 
    begin
    assign IN1 = 4'd4;
    assign IN2 = 4'd3;
    assign IN3 = 4'd3;
    assign IN4 = 4'd3;
    assign IN5 = 4'd3;
    assign IN6 = 4'd3;
    assign IN7 = 4'd3;
    assign IN8 = 4'd3;
    assign IN9 = 4'd3;
    #1
    assign IN4 = 4'd5;
    #1
    assign IN7  = 4'd7;
    #1
    $finish;
    end
endmodule