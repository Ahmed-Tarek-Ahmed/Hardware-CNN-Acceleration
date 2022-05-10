`timescale 1ns / 1ps

module EMB_Layer#(parameter samples=2,size=32)(   
         input [3*samples-1:0]INBUS,
        output [8*size*samples-1:0]OUTBUS );
    genvar i;
    wire [5*size*8-1:0] weights;
    assign weights='h00AF7102FF0F112F00246611FF4C4E8CFF79A85B0058C05800B215C8007F9029FF9B82F5FFA8174FFF256CF3FFF91859FF79117DFFB1CB4F00817748FF35946500E19A9EFED20E040056ED2E00BBD23D001B3C9B00EF0098FFD0106AFF91A8C5FFFB4AAE00360DD500D6702900EDF0C4FF393CDAFFECCE4FFFEE44340071C29BFF89A0BE00131E0C0068A299FFF65D27FEC28DEE00EFB30AFF6013F5007E9095;
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
