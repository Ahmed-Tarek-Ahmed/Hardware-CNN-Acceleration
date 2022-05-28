`timescale 1ns / 1ps



module Register#(parameter in_size = 32)(
    input [in_size-1:0] in,
    input enable,
    output reg [in_size-1:0] out
    );
    
    initial begin
    out=0;
    end
    
    always@(posedge enable)
    begin
    out = in;
    end
    
    
endmodule
