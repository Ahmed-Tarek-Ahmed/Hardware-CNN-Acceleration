`timescale 1ns / 1ps

module EMB_Layer#(parameter samples=2,size=32)(   
         input [3*samples-1:0]INBUS,
        output [8*size*samples-1:0]OUTBUS );
    genvar i;
    wire [5*size*8-1:0] weights;
    assign weights='h0018BF0F0009FEEDFFF00834FFCEA974002750AB000EAC93FFF23372001ADC99FFDDB4AFFFF2F28BFFE8E4DEFFFF918D00208C4CFFFE7364FFFF234EFFE47E5FFFF4FE74001731830001EEAAFFD9B795FFDF4D710027997DFFF4FA88FFEA53D200144A5D000A062F000E5710FFF7E41700020013FFE4F99D0000F3F7FFEB8A170066241E0084CDB8FFB4EBED003DAEA6000EB02F0005EFE400009FE1000591A9;
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
