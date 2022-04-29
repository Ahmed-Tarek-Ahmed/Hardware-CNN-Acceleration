`timescale 1ns / 1ps

module EMB_Layer#(parameter size=2)(   
         input [3*size-1:0]INBUS,
        output [256*size-1:0]OUTBUS );
    genvar i;
    generate
    for(i=1; i<=size; i = i+1)begin : EMB_Unit
         mux_emb EMB(
            .y1('h0173B87E020F7880FF2D82E302FE2374FEF90FBCFFDB2BDEFF48C0D1FEED04E0),
            .y2('h032E7A4401428E58FF5043DE0136FA30FD59F88402945310FEC45864FED607F6),
            .y3('hFEB877BEFD31493CFD5E3E30006E321F01AB125601A38476FFCB648502150CBC),
            .y4('hFD86586000E881C4FF119A5701D4E5A0FEC58594FCD83FBC032F9660FE7DECCE),
            .y5('hFEB7A63800F66D9002BC2350FDA6ADF801E68914FF47FC0DFEF183BE0094F638),
            .sel(INBUS[i*3-1-:3]),
            .x(OUTBUS[i*256-1-:256])
            );
    end
    endgenerate     
endmodule
