`timescale 1ns / 1ps

module Conv_Layer_Seq#(parameter n_inputs = 16,size = 16,DP=4,FC1=16,FC2=1,RC1=3,RC2=3,n_units=32)(
        input [size*16*FC1-1:0] WC1,
        input [size*256*FC2-1:0] WC2,
        input [size*8*RC1-1:0] DataC1,
        input [size*128*RC2-1:0] DataC2,
        input mode,
        output  [size*n_units-1:0]  Out
        );
        genvar i;integer j;
         reg [n_units*size*n_inputs-1:0] weights;
         reg [n_units*size*n_inputs-1:0] data;
        always@(WC1,WC2,DataC1,DataC2,mode)begin
        if (mode==0)begin
            for (j=0;j<n_units;j=j+2)begin
                data[j*size*n_inputs+:size*n_inputs]=DataC1[size*8*2-1:0];
                weights[j*size*n_inputs+:size*n_inputs] = WC1[(j/2)*size*n_inputs+:size*n_inputs];
            end
            for (j=1;j<n_units;j=j+2)begin
                data[j*size*n_inputs+:size*n_inputs]=DataC1[size*8*RC1-1:size*8];
                weights[j*size*n_inputs+:size*n_inputs] = WC1[((j-1)/2)*size*n_inputs+:size*n_inputs];
            end
           
        end
        else begin
                weights={WC2,WC2};
                data={DataC2[size*128*RC2-1:size*128],DataC2[size*128*2-1:0]};
        end
        end     
        for(i=0; i<n_units; i = i+1)begin : Conv_Units
            Convolution#(.size(size),.n_inputs(n_inputs),.DP(DP)) C(
            .weights(weights[size*n_inputs*i+:size*n_inputs]),
            .data (data[size*n_inputs*i+:size*n_inputs] ),
            .Out    (Out[i*size+:size]),
            .Relu(~mode)
            );
        end
endmodule
