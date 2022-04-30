`timescale 1ns / 1ps
module top1#(parameter C_windows=8,parameter C_size=32,parameter C_filters=128,parameter C_n_inputs=16,DP=4,C2F=64,C2W=3,C2I=256);
    wire [65535:0] WT;
    wire [524287:0] WT2;
    wire [C_size*C_n_inputs/2*(C_windows+1)-1:0] data;
    wire   [C_size*C_windows*C_filters-1:0]  Out ;
    wire  [512*C_size-1 : 0]OutM;
    wire [C2W*C2F*C_size-1:0] OutC2;
    wire [512*C_size-1 : 0]InC2;
    wire  [64*C_size-1 : 0]OutM2;
    wire [128*C_size-1 : 0]OutDense;
    wire [64*C_size-1 : 0]OutDense1;
    wire [5*C_size-1 : 0]OutDense2;
    wire [262143 : 0]weightsDense;
    wire [262143 : 0]weightsDense1;
    wire [10239 : 0]weightsDense2;
    EMB_Layer #(.size(C_windows+1))EMB (
    .INBUS('b100011001001100100100001011),
    .OUTBUS(data)
    );
    
    RAM ram(.Outp(WT));
    Ram2 ram2(.Outp(WT2));
    RAMD ramd(.weights(weightsDense),.weights1(weightsDense1),.weights2(weightsDense2));
    Conv_Layer#(.size(C_size),.n_inputs(C_n_inputs),.windows(C_windows),.filters(C_filters),.DP(DP)) C(
    .weights(WT),
    .data  (data),
    .Out    (Out)
    );
    MaxPoolLayer#(.n_outputs(512), .Input_size(C_size),.cs(8)) M (
    .INBUS(Out),
    .OUTBUS(OutM)
    );
    
    Transpose#(.N(512),.size(C_size),.GS(4))T(
            .in(OutM),
            .out(InC2)
    );
    
    Conv_Layer#(.size(C_size),.n_inputs(C2I),.windows(C2W),.filters(C2F),.DP(DP)) C2(
        .weights(WT2),
        .data  (InC2),
        .Out    (OutC2)
        );
        
    MaxPoolLayer#(.n_outputs(64), .Input_size(C_size),.cs(3)) M2 (
        .INBUS(OutC2),
        .OUTBUS(OutM2)
        );
    DenseRelu#(.n_outputs(128), .n_inputs(64), .Input_size(32))D
            (
                .INBUS(OutM2),
                .weights(weightsDense),
                .OUTBUS(OutDense)
            );
    DenseRelu#(.n_outputs(64), .n_inputs(128), .Input_size(32))D1
                    (
                        .INBUS(OutDense),
                        .weights(weightsDense1),
                        .OUTBUS(OutDense1)
                    );
    DenseRelu#(.n_outputs(5), .n_inputs(64), .Input_size(32),.DP(4),.SL(2))D2
                    (
                        .INBUS(OutDense1),
                        .weights(weightsDense2),
                        .OUTBUS(OutDense2)
                    );                                
        
    
    initial begin
    #10
//    $display("%b",Out[C_size*20-1:0]);
//    $display("%b",OutM[C_size*20-1:0]);
//    $display("%b",InC2[C_size*135-1:0]);
//    $display("%b",OutC2[C_size*20-1:0]);
//    $display("%b",OutM2[C_size*20-1:0]);
       $display("%b",OutDense);
      $display("%b",OutDense1);
      $display("%b",OutDense2);
    end
    
endmodule
