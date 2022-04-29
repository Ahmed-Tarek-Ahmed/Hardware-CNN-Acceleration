`timescale 1ns / 1ps

module EMB_Layer#(parameter size=2)(   
         input [3*size-1:0]INBUS,
        output [256*size-1:0]OUTBUS );
    genvar i;
    generate
    for(i=1; i<=size; i = i+1)begin : EMB_Unit
         mux_emb EMB(
            .y1('h00A4B0F3FF5FB2C801C18F1EFFBB0E6FFEFFAD04005B414E002CE99F018A74D2),
            .y2('h01A3F3EE01DEF526004F0FABFCF481C8FE3FCEA000C71276FDEAF72402679BAC),
            .y3('h015B00060121A984FE43F5E0FF0A282702DD174801F393D8013C65DEFD9DDBEC),
            .y4('hFE8670AC01CD1DC0029642C00233A74400FA93C6FEED8456028FDD800243AECC),
            .y5('hFE76CCF6FE1B8D38FEA438A201035090FF62576CFE680478FE7878A2FE35FCA6),
            .sel(INBUS[i*3-1-:3]),
            .x(OUTBUS[i*256-1-:256])
            );
    end
    endgenerate     
endmodule
