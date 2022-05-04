`timescale 1ns / 1ps

module TestPer;
wire [466586:0] WIN;
reg [51842:0] temp = 0;
wire [51842:0] WOut;
RamBig R (WIN,WOut);


wire [2:0] Mout;
integer f;
reg [63:0] i;
reg [26:0] Min ;

initial
begin
Min = 0;
f = $fopen("output.txt","w");

for (i=0;i<17282;i=i+1)
begin
Min = WIN[i*27+:27];
#0.001;
end

$fclose(f);  

end



integer j = 0;

top1 T (Min,Mout);

always@(Min)
begin
$fwrite(f,"%b\n",Mout);
//temp[j*3+:3] = Mout;
//j = j+3;
#0.000001;
end


//integer c =0;
//integer k;
//always@*
//begin

//for (k=0;k<19594;k=k+1)
//begin
//    if (temp[k*3+:3]==WOut[k*3+:3])
//    begin
//    c=c+1;
//end
//end
//end

endmodule
