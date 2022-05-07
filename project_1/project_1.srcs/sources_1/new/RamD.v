`timescale 1ns / 1ps

 
module RAMD (
output reg [1835007:0] weights,
output reg [262143:0] weights1,
output reg [10239:0] weights2

);

//reg [31:0] intemp [63:0];
//reg [31:0] intemp1 [127:0];
//reg [31:0] intemp2 [63:0];
reg [31:0] weightstemp [57343:0];
reg [31:0] weightstemp1 [8191:0];
reg [31:0] weightstemp2 [319:0];
integer i;

initial
begin
$readmemb("DenseWeights.txt", weightstemp);
for (i=0; i<57344; i=i+1)
    weights[i*32+:32] = weightstemp[i];

$readmemb("dense1weights.txt", weightstemp1);
for (i=0; i<8192; i=i+1)
 weights1[i*32+:32] = weightstemp1[i];


$readmemb("dense2weights.txt", weightstemp2);
for (i=0; i<320; i=i+1)
 weights2[i*32+:32] = weightstemp2[i];

end
endmodule
