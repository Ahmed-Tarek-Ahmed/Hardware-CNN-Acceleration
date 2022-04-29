`timescale 1ns / 1ps

module Conv_Layer#(parameter n_inputs = 2,parameter size = 2,parameter windows=2,parameter filters=2,DP=4)(
        input [size*n_inputs*filters-1:0] weights,
        input [size*n_inputs/2*(windows+1)-1:0] data,
        output   [size*windows*filters-1:0]  Out );
genvar i;
generate
for(i=1; i<=filters; i = i+1)begin : Conv_Columns
            Conv_Windows#(.size(size),.n_inputs(n_inputs),.windows(windows),.DP(DP)) C(
                .weights(weights[size*n_inputs*i-1-:size*n_inputs]),
                .data (data),
                .Out    (Out[size*windows*i-1-:size*windows])
            );
    end
endgenerate   
endmodule