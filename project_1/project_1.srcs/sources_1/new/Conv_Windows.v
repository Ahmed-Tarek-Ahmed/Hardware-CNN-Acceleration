`timescale 1ns / 1ps

module Conv_Windows#(parameter n_inputs = 2,parameter size = 2,parameter windows=2,DP=4)(
        input [size*n_inputs-1:0] weights,
        input [size*n_inputs/2*(windows+1)-1:0] data,
        output   [size*windows-1:0]  Out );
genvar i;
generate
for(i=1; i<=windows; i = i+1)begin : Conv_units
            Convolution#(.size(size),.n_inputs(n_inputs),.DP(DP)) C(
                .weights(weights),
                .data (data[size*n_inputs/2*(i+1)-1-:size*n_inputs] ),
                .Out    (Out[size*i-1-:size])
            );
    end
endgenerate
endmodule