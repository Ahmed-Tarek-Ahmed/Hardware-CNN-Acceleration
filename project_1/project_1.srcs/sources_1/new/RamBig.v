`timescale 1ns / 1ps

 
module RamBig (
output reg [466586:0] IN,
output reg [51842:0] Out

);

reg [26:0] Inputtemp [17280:0];
reg [2:0] Outputtemp [17280:0];
integer i;

initial
begin

$readmemb("IN.txt", Inputtemp);
for (i=0; i<17281; i=i+1)
    IN[i*27+:27] = Inputtemp[i];

$readmemb("TotalOutput.txt", Outputtemp);
for (i=0; i<17281; i=i+1)
 Out[i*3+:3] = Outputtemp[i];


end
endmodule