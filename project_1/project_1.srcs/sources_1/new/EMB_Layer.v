`timescale 1ns / 1ps

module EMB_Layer#(parameter samples=2,size=32)(   
         input [3*samples-1:0]INBUS,
        output [8*size*samples-1:0]OUTBUS );
    genvar i;
    wire [5*size*8-1:0] weights;
    RamE ram(.Outp(weights)); 
    generate
    for(i=1; i<=samples; i = i+1)begin : EMB_Unit
         mux_emb#(size) EMB(
              .y1(weights[0+:size*8]),
              .y2(weights[size*8+:size*8]),
              .y3(weights[2*size*8+:size*8]),
              .y4(weights[3*size*8+:size*8]),
              .y5(weights[4*size*8+:size*8]),
            .sel(INBUS[i*3-1-:3]),
            .x(OUTBUS[i*8*size-1-:8*size])
            );
    end
    endgenerate    
endmodule
