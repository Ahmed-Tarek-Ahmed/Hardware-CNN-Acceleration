`timescale 1ns / 1ps

 
module RamBig (
output reg [469826:0] IN, // Lines in file x length of sample x 3
output reg [52202:0] Out  // Lines in file x 3

);

reg [92:0] Inputtemp [17400:0];
reg [2:0] Outputtemp [17400:0];
integer i;

initial
begin

$readmemb("Vin.txt", Inputtemp);
for (i=0; i<17401; i=i+1)
    IN[i*27+:27] = Inputtemp[i];

$readmemb("Vout.txt", Outputtemp);
for (i=0; i<17401; i=i+1)
 Out[i*3+:3] = Outputtemp[i];


end
endmodule