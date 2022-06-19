`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2022 09:36:30 AM
// Design Name: 
// Module Name: SystemClk
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


module SystemClk(

input sysclk_p,
input sysclk_n,
output reg dout

    );
    wire sysclk;
    IBUFDS IBUFDS_sysclk(
    .I(sysclk_p),
    .IB(sysclk_n),
    .O(sysclk)
    );
    always @(posedge sysclk) begin
    dout <=~dout;
    end
endmodule
