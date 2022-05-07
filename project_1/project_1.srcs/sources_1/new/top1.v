`timescale 1ns / 1ps
module top1#(parameter samples=31, size=32, C_filters=128, C_n_inputs=16,DP=5,C2F=64,C2W=14,C2I=256)
    (input [92:0] In ,
    output [2:0] Class);
    wire [65535:0] WT;
    wire [524287:0] WT2;
    wire [size*C_n_inputs/2*(samples)-1:0] data;
    wire   [size*(samples-1)*C_filters-1:0]  Out ;
    wire  [1920*size-1 : 0]OutM;
    wire [C2W*C2F*size-1:0] OutC2;
    wire [1920*size-1 : 0]InC2;
    wire [448*size-1 : 0]OutM2;
    wire [448*size-1 : 0] outTranspose;
    wire [128*size-1 : 0]OutDense;
    wire [64*size-1 : 0]OutDense1;
    wire [5*size-1 : 0]OutDense2;
    wire [1835007 : 0]weightsDense;
    wire [262143 : 0]weightsDense1;
    wire [10239 : 0]weightsDense2;
    EMB_Layer #(.samples(samples),.size(size))EMB (
    .INBUS(In),
    .OUTBUS(data)
    );
    
    RAM ram(.Outp(WT));
    Ram2 ram2(.Outp(WT2));
    RAMD ramd(.weights(weightsDense),.weights1(weightsDense1),.weights2(weightsDense2));
    Conv_Layer#(.size(size),.n_inputs(C_n_inputs),.windows(samples-1),.filters(C_filters),.DP(DP)) C(
    .weights(WT),
    .data  (data),
    .Out   (Out)
    );
    MaxPoolLayer#(.n_outputs(1920), .Input_size(size),.cs(30)) M (
    .INBUS(Out),
    .OUTBUS(OutM)
    );
    
    Transpose#(.N(1920),.size(size),.GS(15))T(
            .in(OutM),
            .out(InC2)
    );
    
    Conv_Layer#(.size(size),.n_inputs(C2I),.windows(C2W),.filters(C2F),.DP(DP)) C2(
        .weights(WT2),
        .data  (InC2),
        .Out    (OutC2)
        );
        
    MaxPoolLayer#(.n_outputs(448), .Input_size(size),.cs(14)) M2 (
        .INBUS(OutC2),
        .OUTBUS(OutM2)
        );
    Transpose#(.N(448),.size(size),.GS(7))T2(
                .in(OutM2),
                .out(outTranspose)
        );
    DenseRelu#(.n_outputs(128), .n_inputs(448), .Input_size(size),.DP(DP))D
            (
                .INBUS(outTranspose),
                .weights(weightsDense),
                .OUTBUS(OutDense)
            );
    DenseRelu#(.n_outputs(64), .n_inputs(128), .Input_size(size),.DP(DP))D1
                    (
                        .INBUS(OutDense),
                        .weights(weightsDense1),
                        .OUTBUS(OutDense1)
                    );
    DenseRelu#(.n_outputs(5), .n_inputs(64), .Input_size(size),.DP(DP),.SL(2))D2
                    (
                        .INBUS(OutDense1),
                        .weights(weightsDense2),
                        .OUTBUS(OutDense2)
                    );                                
    MaxComp# (.insize(size)) C1ass
                    (   .INPUT(OutDense2),
                        .Out(Class)
                    );    
    
    initial begin
    #10
    $display("%b",data[size*20-1:0]);
        $display("%b",Out[size*20-1:0]);
       $display("%b",OutM[size*20-1:0]);
      $display("%b",OutC2[size*20-1:0]);
      $display("%b",OutM2[size*20-1:0]);
     $display("%b",OutDense[size*20-1:0]);
     $display("%b",OutDense1);
      $display("%b",OutDense2);
    end
    
endmodule
