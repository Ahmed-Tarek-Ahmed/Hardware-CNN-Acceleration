`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2022 16:31:31
// Design Name: 
// Module Name: MaxPoolUnit
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


module MaxPoolUnit
   #(parameter Vsize = 3)
    (
    input [Vsize:0] INPUT1,
    input [Vsize:0] INPUT2,
    input [Vsize:0] INPUT3,
    input [Vsize:0] INPUT4,
    input [Vsize:0] INPUT5,
    input [Vsize:0] INPUT6,
    input [Vsize:0] INPUT7,
    input [Vsize:0] INPUT8,
    input [Vsize:0] INPUT9,
    output [Vsize:0] Out
    );
    
   wire [Vsize:0] O1;
   wire [Vsize:0] O2;
   wire [Vsize:0] O3;
   wire [Vsize:0] O4;
   wire [Vsize:0] O5;
   wire [Vsize:0] O6;
   wire [Vsize:0] O7;
   
   MaxComp Comp1(INPUT1,INPUT2,O1);
   MaxComp Comp2(INPUT3,O1,O2);
   MaxComp Comp3(INPUT4,O2,O3);
   MaxComp Comp4(INPUT5,O3,O4);
   MaxComp Comp5(INPUT6,O4,O5);
   MaxComp Comp6(INPUT7,O5,O6);
   MaxComp Comp7(INPUT8,O6,O7);
   MaxComp Comp8(INPUT9,O7,Out);
   
endmodule
