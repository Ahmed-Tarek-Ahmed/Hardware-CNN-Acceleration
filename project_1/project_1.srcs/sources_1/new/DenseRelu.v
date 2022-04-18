`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2022 08:41:18 PM
// Design Name: 
// Module Name: DenseRelu
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


module DenseRelu #(parameter n_outputs = 128, n_inputs = 64, Input_size = 32)
    (
        input [n_inputs*Input_size - 1:0]INBUS,
        input [n_outputs*n_inputs*Input_size-1:0]weights,
        output[n_outputs*(2*Input_size+n_inputs-1)-1:0]OUTBUS
    );
        genvar i;
    generate
    for(i=1; i<=n_outputs; i = i+1)begin : Convolution
       Convolution #(.size(Input_size),.n_inputs(n_inputs)) ui
       (
        .data(INBUS[Input_size - 1:0]),
        .weights(weights[i*Input_size - 1:(i-1)*Input_size]),
        .out(OUTBUS[i*(2*Input_size+n_inputs-1)-1:(i-1)*(2*Input_size+n_inputs-1)])
       ); 
    end
    endgenerate
endmodule
