`timescale 1ns / 1ps


module AdderTree#(parameter n = 8,parameter size = 16)(
    input [n*size-1:0] in,
    output reg [size-1:0] out  
    );


integer i;
reg signed [size-1:0] sum;
reg signed [size:0] temp; 

always@(in)
begin
sum = 0;
for (i=0; i<n-1 ; i = i+2)
begin
temp = $signed(in[(i+1)*size+:size]) + $signed(in[i*size+:size]);
sum = sum + temp;
end

out = sum;
end    
 


endmodule