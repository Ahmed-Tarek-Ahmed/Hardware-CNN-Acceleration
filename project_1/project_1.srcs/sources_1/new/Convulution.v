`timescale 1ns / 1ps
module Convolution
    #(parameter n_inputs = 2,parameter size = 3)
    (    
        input [size*n_inputs-1:0] weights,
        input [size*n_inputs-1:0] data,
        output reg signed [2*size+n_inputs-2:0]  Out
    );

    integer i;
    reg signed [size-1:0] a;
    reg signed [size-1:0] b;
  
    always @(weights,data)
    begin
    Out=0;
    for (i = 0; i < n_inputs*size; i = i + size) 
    begin
    a = weights[i+:size];
    b = data[i+:size];
    Out = Out+a*b;
    end
end
endmodule