`timescale 1ns / 1ps


module DenseTB#(parameter n_outputs = 128, n_inputs = 64, Input_size = 32);
        wire [Input_size*n_inputs-1:0] in;
        wire [n_outputs*n_inputs*Input_size-1:0] weights;
        wire [n_outputs*(2*Input_size+n_inputs-1)-1:0] Out;
        
        RAMD ramd(.in(in),.weights(weights));
        
        DenseRelu #(.n_outputs(n_outputs),.n_inputs(n_inputs),.Input_size(Input_size)) u1(
        .INBUS(in),
        .OUTBUS(Out),
        .weights(weights)
);
    initial begin
    #10;
    //in ='hfe17e572fc11ccd4fe0a5abeffcca61dfd4201740141331a0062f934ff6adccefeecb54eff4a63a7fe5b935a007a674601da3f52fd7eb460fe3f951c00d33ded;
    //weights ='h0192b3befe42e934fffeb548008882c2ff3a98f3ff36e72901d6f04cfef0490401ed2cd401051b460144611802030d64ffc2fcb2ffeef7eafee3bb1cffbd39d10192b3befe42e934fffeb548008882c2ff3a98f3ff36e72901d6f04cfef0490401ed2cd401051b460144611802030d64ffc2fcb2ffeef7eafee3bb1cffbd39d1;

    $display("%b\n",Out[127*2:0]);
    #10;
    $finish;
    end
endmodule
