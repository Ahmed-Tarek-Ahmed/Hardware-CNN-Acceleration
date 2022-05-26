`timescale 1ns / 1ps


module top_seq#(parameter size=16,DP=6,n_units=32,n_inputs=16)(

        output  [32*size-1:0]OC1
    );
    reg [3*3-1:0] samples;
    wire [3*8*size-1:0] OE;
    wire [16*128*size-1:0] WT;
    wire [n_units*size*n_inputs-1:0] weights;
    wire [n_units*size*n_inputs-1:0] data;
    
    RAM #(.size(size))ram(.Outp(WT));
    
    EMB_Layer #(.samples(3),.size(size))EMB (samples,OE);
 
    Conv_Layer_Seq#(.size(size),.DP(DP)) C(
    .WC1(WT[16*16*size-1:0]),
    .DataC1  (OE),
    .Out   (OC1),
    .mode (1'b0),
    .DataC2(6144'b0),
    .WC2(0),
    .debugW(weights),
    .debugD(data)
    );
    
    initial 
    begin
    samples=9'b001001001;
    #1
    $display("%b",OC1);

    $finish;
    end
    
endmodule
