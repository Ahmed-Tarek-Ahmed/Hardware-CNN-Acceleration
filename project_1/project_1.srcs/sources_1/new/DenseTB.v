`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2022 11:36:31 PM
// Design Name: 
// Module Name: DenseTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DenseTB#(parameter n_outputs = 2, n_inputs = 16, Input_size = 32);
        reg [Input_size*n_inputs-1:0] in;
        reg [n_outputs*n_inputs*Input_size-1:0] weights;
        wire [n_outputs*(2*Input_size+n_inputs-1)-1:0] Out;
        DenseRelu #(.n_outputs(n_outputs),.n_inputs(n_inputs),.Input_size(Input_size)) u1(
        .INBUS(in),
        .OUTBUS(Out),
        .weights(weights)
);
    initial begin
    #10;
    in ='hfe17e572fc11ccd4fe0a5abeffcca61dfd4201740141331a0062f934ff6adccefeecb54eff4a63a7fe5b935a007a674601da3f52fd7eb460fe3f951c00d33ded;
    weights ='h0192b3befe42e934fffeb548008882c2ff3a98f3ff36e72901d6f04cfef0490401ed2cd401051b460144611802030d64ffc2fcb2ffeef7eafee3bb1cffbd39d10192b3befe42e934fffeb548008882c2ff3a98f3ff36e72901d6f04cfef0490401ed2cd401051b460144611802030d64ffc2fcb2ffeef7eafee3bb1cffbd39d1;
    #10;
    $finish;
    end
endmodule
