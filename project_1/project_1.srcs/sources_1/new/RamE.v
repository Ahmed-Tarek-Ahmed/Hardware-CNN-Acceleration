`timescale 1ns / 1ps

 
module RamE #(parameter size=32,param=40)(output reg [size*param-1:0] Outp);

reg [size-1:0] ram [param-1:0];
integer i;

initial
begin
$readmemb("Embedding.txt", ram);
for (i=0; i<size*param; i=i+1) 
 Outp[i*size+:size] = ram[i];
end

endmodule