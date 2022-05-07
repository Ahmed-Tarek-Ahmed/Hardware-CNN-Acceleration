`timescale 1ns / 1ps

 
module RAMD #(parameter size=32,paramD=57344,paramD1=8192,paramD2=320)(
output reg [paramD*size-1:0] weights,
output reg [paramD1*size-1:0] weights1,
output reg [paramD2*size-1:0] weights2

);

reg [size-1:0] weightstemp [paramD-1:0];
reg [size-1:0] weightstemp1 [paramD1-1:0];
reg [size-1:0] weightstemp2 [paramD2-1:0];
integer i;

initial
begin
$readmemb("denseWeights.txt", weightstemp);
for (i=0; i<paramD; i=i+1)
    weights[i*size+:size] = weightstemp[i];

$readmemb("dense1weights.txt", weightstemp1);
for (i=0; i<paramD1; i=i+1)
 weights1[i*size+:size] = weightstemp1[i];


$readmemb("dense2weights.txt", weightstemp2);
for (i=0; i<paramD2; i=i+1)
 weights2[i*size+:size] = weightstemp2[i];

end
endmodule
