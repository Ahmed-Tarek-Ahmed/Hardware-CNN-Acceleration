`timescale 1ns / 1ps



module Buffer(
    input  inBuffer,
    output outBuffer
    );
    
    
    wire temp;
    
    assign temp=~inBuffer;
    assign outBuffer=~temp;
    
endmodule
