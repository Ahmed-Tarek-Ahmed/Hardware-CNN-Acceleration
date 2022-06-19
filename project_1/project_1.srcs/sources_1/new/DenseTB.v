`timescale 1ns / 1ps


module DenseTB#(parameter n_outputs = 64, n_inputs = 128, Input_size = 32,DP=4);
        wire [Input_size*n_inputs-1:0] ind1;
        wire [n_outputs*n_inputs*Input_size-1:0] weights1;
        wire [n_outputs*(Input_size)-1:0] Out;
        
        RAMD ramd(.ind1(ind1),.weights1(weights1));
        DenseRelu #(.n_outputs(n_outputs),.n_inputs(n_inputs),.Input_size(Input_size),.DP(4)) u1(
        .INBUS(ind1),
        .OUTBUS(Out),
        .weights(weights1)
);
    initial begin
    #10;
    $display("%b\n",Out);
    #10;
    $finish;
    end
endmodule
