`timescale 1ns / 1ps


module Multiplier
    #(parameter insize = 3)
    (
    input signed [insize-1:0] A,
    input signed [insize-1:0] B,
    output signed [2*insize-1:0] Out
    );
    assign Out=A*B;
endmodule
