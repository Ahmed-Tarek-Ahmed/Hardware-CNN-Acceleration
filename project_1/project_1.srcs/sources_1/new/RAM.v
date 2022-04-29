`timescale 1ns / 1ps

 
module RAM (output reg [65535:0] Outp);

reg [31:0] ram [2047:0];
integer i;



initial
begin
$readmemb("C1.txt", ram);
for (i=0; i<2048; i=i+1) 
 Outp[i*32+:32] = ram[i];
end



endmodule
