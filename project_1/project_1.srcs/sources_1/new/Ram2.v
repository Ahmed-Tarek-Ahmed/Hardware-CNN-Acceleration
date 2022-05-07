`timescale 1ns / 1ps

 
module Ram2 #(parameter size=32) (output reg [16384*size-1:0] Outp);

reg [size-1:0] ram [16383:0];
integer i;



initial
begin
$readmemb("C2.txt", ram);
for (i=0; i<16384*size; i=i+1) 
 Outp[i*size+:size] = ram[i];
end



endmodule
