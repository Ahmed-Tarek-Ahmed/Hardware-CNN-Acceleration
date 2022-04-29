`timescale 1ns / 1ps


module MaxComp
    #(parameter size = 3)
    (
    input [size:0] INPUT1,
    input [size:0] INPUT2,
    output [size:0] Out
    );
    
assign Out = INPUT1>INPUT2?INPUT1:INPUT2;

endmodule
