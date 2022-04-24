`timescale 1ns / 1ps

module EMB_Layer#(parameter size=2)(   
         input [3*size-1:0]INBUS,
        output [256*size-1:0]OUTBUS );
    genvar i;
    generate
    for(i=1; i<=size; i = i+1)begin : EMB_Unit
         mux_emb EMB(
            .y1('h02783354FD0CA2A4FE8BFA340059E598FF47C1EA0116094EFFAB3AFFFDA44538),
            .y2('h0192B3BEFE42E934FFFEB548008882C2FF3A98F3FF36E72901D6F04CFEF04904),
            .y3('h013C74BC0220BB84004E47A0FE4A69B0006D7C6C0114C30E01BA8FBCFEFDB398),
            .y4('h01ED2CD401051B460144611802030D64FFC2FCB2FFEEF7EAFEE3BB1CFFBD39D1),
            .y5('hFFD3F5E00064892B00319942FFC695D001705DECFE44008CFFB6CB4DFFF58960),
            .sel(INBUS[i*3-1-:3]),
            .x(OUTBUS[i*256-1-:256])
            );
    end
    endgenerate     
endmodule
