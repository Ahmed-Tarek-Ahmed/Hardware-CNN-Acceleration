`timescale 1ns / 1ps



module Register#(parameter in_size = 32)(
    input [in_size-1:0] in,
    input enable,
    input reset,
    output reg [in_size-1:0] out
    );
    
    initial begin
    out=0;
    end
    
    always@(posedge enable)
    begin
    if(reset == 1)begin
        out = 0;
    end
    else
    out = in;
    end
    
    
endmodule
