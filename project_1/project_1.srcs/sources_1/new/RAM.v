`timescale 1ns / 1ps

 
module RAM #(parameter size=32) (output reg [2048*size-1:0] Outp);

reg [size-1:0] ram [2047:0];
integer i;



initial
begin
$readmemb("C1.txt", ram);
for (i=0; i<2048; i=i+1) 
 Outp[i*size+:size] = ram[i];
 
end



endmodule
