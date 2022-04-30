`timescale 1ns / 1ps
module Convolution
    #(parameter n_inputs = 2, size = 32,DP=4,SL=0)
    (    
        input [size*n_inputs-1:0] weights,
        input [size*n_inputs-1:0] data,
        output  reg signed [size-1:0]  Out,
        output reg signed [2*size+n_inputs-2:0]  Temp
    );
    integer i;
    reg signed [size-1:0] a;
    reg signed [size-1:0] b;
  
        always @(weights,data)
        begin
        Temp=0;
            for (i = 0; i < n_inputs*size; i = i + size) 
                begin
            a = weights[i+:size];
            b = data[i+:size];
            Temp = Temp+a*b;
                 end
            Out = Temp[size-DP+SL+:size];
    
            if(Out[size-1] == 1)
                   Out = 0; 
        end     

endmodule