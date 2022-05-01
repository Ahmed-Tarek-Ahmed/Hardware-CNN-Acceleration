`timescale 1ns / 1ps

 
module RamBig (
output reg [529037:0] IN,
output reg [58781:0] Out

);

reg [26:0] Inputtemp [19593:0];
reg [2:0] Outputtemp [19593:0];
integer i;

initial
begin

$readmemb("TotalInput.txt", Inputtemp);
for (i=0; i<19594; i=i+1)
    IN[i*27+:27] = Inputtemp[i];

$readmemb("TotalOutput.txt", Outputtemp);
for (i=0; i<19594; i=i+1)
 Out[i*3+:3] = Outputtemp[i];


end
endmodule