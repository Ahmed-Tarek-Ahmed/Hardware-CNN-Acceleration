`timescale 1ns / 1ps


module top_seq#(parameter size=16,DP=6,n_units=32,n_inputs=16)(
        input clk,
        output  [32*size-1:0]out
    );
    reg [3*3-1:0] samples;
    wire [3*8*size-1:0] OE;
    wire [16*128*size-1:0] WT;
    wire [n_units*size*n_inputs-1:0] weights;
    wire [n_units*size*n_inputs-1:0] data;
    wire  [32*size-1:0]OC;
    wire  [16*size-1:0] OM;
    wire  [size-1:0]  OA1,OA2,OMU;
    RAM #(.size(size))ram(.Outp(WT));
    
    EMB_Layer #(.samples(3),.size(size))EMB (samples,OE);
 
    Conv_Layer_Seq#(.size(size),.DP(DP)) C(
    .WC1(WT[16*16*size-1:0]),
    .DataC1  (OE),
    .OutR   (OC),
    .mode (1'b0),
    .DataC2(6144'b0),
    .WC2(0)
    );
    
     MaxPoolLayer#(.n_outputs(16), .Input_size(size)) M (
     .INBUS(OC),
     .OUTBUS(OM)
     );
    
    AdderTree#(16,size) A1 (OC[16*size-1:0],OA1);
    
    AdderTree#(16,size) A2 (OC[32*size-1:16*size],OA2);
    
    MaxPoolUnit#(size,2) MU ({OA1,OA2},OMU);
    
    initial 
    begin
    samples=9'b001001001;
    #1
    $display("%b",OC1);

    $finish;
    end
    
endmodule
