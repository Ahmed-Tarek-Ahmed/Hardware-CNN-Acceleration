`timescale 1ns / 1ps

 
module RAMD2 #(parameter size=32) (output reg [2240*size-1:0] Outp);

reg [size-1:0] ram [2239:0];
integer i;



initial
begin
$readmemb("DenseT.txt", ram);
for (i=0; i<2240; i=i+1) 
 Outp[i*size+:size] = ram[i];
 
end



endmodule
