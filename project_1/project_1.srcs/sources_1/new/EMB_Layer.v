`timescale 1ns / 1ps

module EMB_Layer#(parameter samples=2,size=32)(   
         input [3*samples-1:0]INBUS,
        output [8*size*samples-1:0]OUTBUS );
    genvar i;
    wire [5*size*8-1:0] weights;
    assign weights='h0062FC3F0027FBB5FFC020CDFF3AA5CD009D42AF003AB24CFFC8CDC8006B7265FF76D2BBFFCBCA29FFA39377FFFE463400823133FFF9CD8DFFFC8D35FF91F979FFD3F9CD005CC60D0007BAA8FF66DE54FF7D35C3009E65F6FFD3EA20FFA94F4500512977002818BD00395C42FFDF905B0008004DFF93E6740003CFDFFFAE28590198907A021336E0FED3AFB200F6BA98003AC0BE0017BF9200027F85001646A6;
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
