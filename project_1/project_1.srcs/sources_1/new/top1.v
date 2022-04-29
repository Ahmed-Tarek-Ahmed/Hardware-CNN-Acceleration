`timescale 1ns / 1ps
module top1#(parameter C_windows=8,parameter C_size=32,parameter C_filters=128,parameter C_n_inputs=16,DP=4);
    wire [65535:0] WT;
    wire [524287:0] WT2;
    wire [C_size*C_n_inputs*C_filters-1:0] weights;
    wire [C_size*C_n_inputs/2*(C_windows+1)-1:0] data;
    wire   [C_size*C_windows*C_filters-1:0]  Out ;
    wire  [512*C_size-1 : 0]OutM;
    EMB_Layer #(.size(C_windows+1))EMB (
    .INBUS('b100011001001100100100001011),
    .OUTBUS(data)
    );
    
    RAM ram(.Outp(WT));
    Ram2 ram2(.Outp(WT2));
    assign weights=WT[C_size*C_n_inputs*C_filters-1:0];
    Conv_Layer#(.size(C_size),.n_inputs(C_n_inputs),.windows(C_windows),.filters(C_filters),.DP(DP)) C(
    .weights(weights),
    .data  (data),
    .Out    (Out)
    );
    MaxPoolLayer#(.n_outputs(512), .Input_size(C_size)) M (
    .INBUS(Out),
    .OUTBUS(OutM)
    );
    initial begin
    #10
    $display("%h",weights);
    $display("%h",data);
    $display("%b",Out[C_size*20-1:0]);
    $display("%b",OutM[C_size*20-1:0]);
    end
    
endmodule
