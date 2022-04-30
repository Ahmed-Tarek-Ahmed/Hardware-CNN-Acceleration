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
    //in ='hfe17e572fc11ccd4fe0a5abeffcca61dfd4201740141331a0062f934ff6adccefeecb54eff4a63a7fe5b935a007a674601da3f52fd7eb460fe3f951c00d33ded;
    //weights ='h0192b3befe42e934fffeb548008882c2ff3a98f3ff36e72901d6f04cfef0490401ed2cd401051b460144611802030d64ffc2fcb2ffeef7eafee3bb1cffbd39d10192b3befe42e934fffeb548008882c2ff3a98f3ff36e72901d6f04cfef0490401ed2cd401051b460144611802030d64ffc2fcb2ffeef7eafee3bb1cffbd39d1;
    $display("%b\n",Out);
    #10;
    $finish;
    end
endmodule
