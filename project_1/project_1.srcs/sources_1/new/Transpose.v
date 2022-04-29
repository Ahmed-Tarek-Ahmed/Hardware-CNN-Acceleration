`timescale 1ns / 1ps

module Transpose#(parameter N=10,size=10,GS=2)(
        input [N*size-1:0] in,
        output reg [N*size-1:0] out
    );
    integer i,j;
    always@(in)
    begin
    for (i=0;i<GS;i=i+1) begin
        for(j=0;j<N/GS;j=j+1)begin    
            out[(i*N/GS+j)*size+:size]=in[(j*GS+i)*size+:size];
    end
    end
    end
endmodule
