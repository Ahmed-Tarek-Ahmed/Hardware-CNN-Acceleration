`timescale 1ns / 1ps


module DenseRelu #(parameter n_outputs = 128, n_inputs = 64, Input_size = 32)
    (
        input [n_inputs*Input_size - 1:0]INBUS,
        input [n_outputs*n_inputs*Input_size-1:0]weights,
        output[n_outputs*Input_size-1:0]OUTBUS
    );
        genvar i;
    generate
    for(i=1; i<=n_outputs; i = i+1)begin : Convolution
       Convolution #(.size(Input_size),.n_inputs(n_inputs)) ui
       (
        .data(INBUS[Input_size*n_inputs - 1:0]),
        .weights(weights[i*Input_size*n_inputs - 1:(i-1)*Input_size*n_inputs]),
        .Out(OUTBUS[i*(Input_size)-1:(i-1)*(Input_size)])
       ); 
    end
    endgenerate
endmodule
