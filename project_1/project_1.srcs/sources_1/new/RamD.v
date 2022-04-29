`timescale 1ns / 1ps

 
module RAMD (
output reg [2047:0] in,
output reg [262143:0] weights

);

reg [31:0] intemp [63:0];
reg [31:0] weightstemp [8191:0];
integer i;

initial
begin
$readmemb("inputDesne.txt", intemp);
for (i=0; i<64; i=i+1) 
 in[i*32+:32] = intemp[i];
 
$readmemb("DenseWeights.txt", weightstemp);
for (i=0; i<8192; i=i+1) 
 weights[i*32+:32] = weightstemp[i];
end

endmodule
