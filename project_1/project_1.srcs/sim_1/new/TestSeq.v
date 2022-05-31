`timescale 1ns / 1ps


module TestSeq;

wire clock;
wire res;
wire [2:0] Output;
reg [31*3*1000-1:0] Input;
reg [31*3-1:0] temp;
reg [92:0] Inputtemp [1000:0];


Top_Sequential_model  Model (.in(temp),
.clk(clock),.reset(res),.class(Output) );

integer i,j,f;

initial begin

force res = 1;
    force clock = 0;
    #2;
    force clock = 1;
    #1;
    force res = 0;
    
f = $fopen("Vout.txt","w");
$readmemb("Vin.txt", Inputtemp);
for(i=0;i<1000;i=i+1) begin
//temp = 'b100010001011011011001010011001010011011001100001001011011011100011100011100001011010011100001;
    temp = Inputtemp[i]; 
    for(j=0;j<572;j=j+1)begin
        force clock = 0;
        #1;
        force clock = 1;
        #1;  
    end
    $fwrite(f,"%b\n",Output);
    force res = 1;
    force clock = 0;
    #2;
    force clock = 1;
    #1;
    force res = 0;
    
end


    $fclose(f);
    $finish;
end             
endmodule
