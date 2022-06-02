`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2022 08:59:08 AM
// Design Name: 
// Module Name: Buffer
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


module Buffer(
    input inBuffer,
    output outBuffer
    );
    
    wire temp;
    
    assign temp=~inBuffer;
    assign outBuffer=~temp;
    
endmodule
