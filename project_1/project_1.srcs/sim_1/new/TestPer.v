`timescale 1ns / 1ps

module TestPer;
wire [1618292:0] WIN;
reg [52202:0] temp = 0;
wire [52202:0] WOut;
RamBig R (WIN,WOut);
wire [2:0] Mout;
integer f;
reg [64:0] i;
reg [92:0] Min ;

initial
begin
#0.1
f = $fopen("Vout.txt","w");

for (i=0;i<1000;i=i+1)
begin
Min = WIN[i*93+:93];
#0.01;
$fwrite(f,"%b\n",Mout);
end

$fclose(f);  
$finish;
end



integer j = 0;

top_test T (Min,Mout);

//always@(Min)
//begin

////temp[j*3+:3] = Mout;
////j = j+3;
//#0.001;
//end
endmodule
