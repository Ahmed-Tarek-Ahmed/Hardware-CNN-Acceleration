`timescale 1ns / 1ps

 
module Ram2 (output reg [524287:0] Outp);

reg [31:0] ram [16383:0];
integer i;



initial
begin
$readmemb("C2.txt", ram);
for (i=0; i<524288; i=i+1) 
 Outp[i*32+:32] = ram[i];
end



endmodule
