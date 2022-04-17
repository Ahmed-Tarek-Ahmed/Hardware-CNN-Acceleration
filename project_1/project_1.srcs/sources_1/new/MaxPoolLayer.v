`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2022 01:09:44 PM
// Design Name: 
// Module Name: MaxPoolLayer
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


module MaxPoolLayer # (parameter n_outputs = 3, Input_size = 32)
    ( 
        input [n_outputs*Input_size*2 - 1:0]INBUS,
        output [n_outputs*Input_size-1 : 0]OUTBUS
    );
    
    genvar i;
    generate
    for(i=1; i<=n_outputs; i = i+1)begin : MaxPoolUnit
       MaxPoolUnit #(.In_size(Input_size)) ui
       (
        .in(INBUS[Input_size*2*i - 1:Input_size*2*(i-1)]),
        .Out(OUTBUS[Input_size*i - 1:Input_size*(i-1)])
       ); 
    end
    endgenerate
endmodule