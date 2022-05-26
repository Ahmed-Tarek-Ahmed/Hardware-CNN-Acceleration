`timescale 1ns / 1ps

module Conv_Layer#(parameter n_inputs = 16, size = 16, windows=1, filters=16,DP=4)(
        input [size*n_inputs*filters-1:0] weights,
        input [size*n_inputs/2*(windows+1)-1:0] data,
        output   [size*windows*filters-1:0]  Out );
genvar i;
genvar j;
generate 
for(i=0; i<filters; i = i+1)begin : Conv_Y
    for(j=1; j<=windows; j = j+1)begin :Conv_X
        Convolution#(.size(size),.n_inputs(n_inputs),.DP(DP)) C(
            .weights(weights[size*n_inputs*i+:size*n_inputs]),
            .data (data[size*n_inputs/2*(j+1)-1-:size*n_inputs] ),
            .Out    (Out[(i*windows+(j-1))*size+:size])
            );
    end
    end
endgenerate   
endmodule
