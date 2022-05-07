`timescale 1ns / 1ps
module top1#(parameter samples=31, size=32,DP=5,paramD=57344,paramD1=8192,paramD2=320)
    (input [samples*3-1:0] In ,
    output [2:0] Class);
    localparam C1I=16, C1F=128, C2F=64,C2W=((samples-1)/2)-1,C2I=C1F*2,M1CS=samples-1,M1O=M1CS/2*C1F,M2CS=M1CS/2-1,M2O=M2CS/2*C2F;
    localparam D1F=64,D2F=5,DF=128;
    wire [C1I*C1F*size-1:0] WT;
    wire [C2I*C2F*size-1:0] WT2;
    wire [size*C1I/2*(samples)-1:0] data;
    wire   [size*(samples-1)*C1F-1:0]  Out ;
    wire  [M1O*size-1 : 0]OutM,InC2;
    wire [C2W*C2F*size-1:0] OutC2;
    wire [M2O*size-1 : 0]OutM2,InDense;
    wire [DF*size-1 : 0]OutDense;
    wire [D1F*size-1 : 0]OutDense1;
    wire [D2F*size-1 : 0]OutDense2;
    wire [size*paramD-1 : 0]weightsDense;
    wire [size*paramD1-1  : 0]weightsDense1;
    wire [size*paramD2-1  : 0]weightsDense2;
    EMB_Layer #(.samples(samples),.size(size))EMB (
    .INBUS(In),
    .OUTBUS(data)
    );

    RAM #(size)ram(.Outp(WT));
    Ram2 #(size)ram2(.Outp(WT2));
    RAMD #(.size(size),.paramD(paramD),.paramD1(paramD1),.paramD2(paramD2)) ramd(.weights(weightsDense),.weights1(weightsDense1),.weights2(weightsDense2));
    Conv_Layer#(.size(size),.n_inputs(C1I),.windows(samples-1),.filters(C1F),.DP(DP)) C(
    .weights(WT),
    .data  (data),
    .Out   (Out)
    );
    MaxPoolLayer#(.n_outputs(M1O), .Input_size(size),.cs(M1CS)) M (
    .INBUS(Out),
    .OUTBUS(OutM)
    );
    
    Transpose#(.N(M1O),.size(size),.GS(M1CS/2))T(
            .in(OutM),
            .out(InC2)
    );
    
    Conv_Layer#(.size(size),.n_inputs(C2I),.windows(C2W),.filters(C2F),.DP(DP)) C2(
        .weights(WT2),
        .data  (InC2),
        .Out    (OutC2)
        );
        
    MaxPoolLayer#(.n_outputs(M2O), .Input_size(size),.cs(M2CS)) M2 (
        .INBUS(OutC2),
        .OUTBUS(OutM2)
        );
    Transpose#(.N(M2O),.size(size),.GS(M2CS/2))T2(
                .in(OutM2),
                .out(InDense)
        );
        DenseRelu#(.n_outputs(DF), .n_inputs(M2O), .Input_size(size),.DP(DP))D
            (
                .INBUS(InDense),
                .weights(weightsDense),
                .OUTBUS(OutDense)
            );
    DenseRelu#(.n_outputs(D1F), .n_inputs(DF), .Input_size(size),.DP(DP))D1
                    (
                        .INBUS(OutDense),
                        .weights(weightsDense1),
                        .OUTBUS(OutDense1)
                    );
    DenseRelu#(.n_outputs(D2F), .n_inputs(D1F), .Input_size(size),.DP(DP),.SL(2))D2
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
//    $display("%b",WT[size*20-1:0]);
//        $display("%b",Out[size*20-1:0]);
//       $display("%b",OutM[size*20-1:0]);
//      $display("%b",OutC2[size*20-1:0]);
//      $display("%b",OutM2[size*20-1:0]);
//     $display("%b",OutDense[size*20-1:0]);
//     $display("%b",OutDense1);
//      $display("%b",OutDense2);
    end
    
endmodule
