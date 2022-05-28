`timescale 1ns / 1ps


module RegisterFile#(parameter ele_num = 2,parameter in_size = 32)(
    input [ele_num*in_size-1:0] inbus,
    input enable,
    output [ele_num*in_size-1:0] outbus
    );
    
    genvar i;
    
generate
    for(i=1; i<=ele_num ; i = i+1)begin
    Register#(.in_size(in_size)) R (.in(inbus[i*in_size-1:(i-1)*in_size]),
                                    .enable(enable),
                                    .out(outbus[i*in_size-1:(i-1)*in_size]));
    
    end
endgenerate
    
endmodule

