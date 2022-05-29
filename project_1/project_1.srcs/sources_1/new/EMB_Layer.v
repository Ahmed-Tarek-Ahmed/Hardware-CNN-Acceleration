`timescale 1ns / 1ps

module EMB_Layer#(parameter samples=2,size=32)(   
         input [3*samples-1:0]INBUS,
        output [8*size*samples-1:0]OUTBUS );
    genvar i;
    wire [5*size*8-1:0] weights;
    assign weights='h00C5004FFF81FE76013A0075FF9200D6FEEEFF98FF48FFFD0104FFF4FFFAFF24FFA800B9000FFECEFEFB013CFFA8FF5300A200500072FFC00010FF280007FF5D03310426FDA801ED0075002F0004002C;
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
