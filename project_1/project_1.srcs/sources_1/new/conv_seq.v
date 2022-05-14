`timescale 1ns / 1ps
module conv_seq
    #(parameter n_inputs = 16, size = 32,DP=5,SL=0,Relu=1)
    (    
        output  reg signed [size-1:0]  Out
    );
    reg clk=0;
    reg [size*n_inputs-1:0] data;
    reg [6:0]addr;
    wire [size*n_inputs-1:0] weights;
    C1W W(.clka(clk),.addra(addr),.douta(weights));

    integer i;
    reg signed [size-1:0] a,b;
    reg signed [2*size+n_inputs-2:0]  Temp;
        always @(negedge clk)
        begin
        Temp=0;
            for (i = 0; i < n_inputs*size; i = i + size) 
                begin
            a = weights[i+:size];
            b = data[i+:size];
            Temp = Temp+a*b;
                 end
            Out = Temp[size-DP+SL+:size];
    
            if(Out[size-1] == 1 && Relu==1)
                   Out = 0; 
        end     
    initial begin
        addr=0;
    data='h08000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000;
    #1

    clk=1;
    #1
    clk=0;
    #1;
    clk=1;
    #1;
    $finish;
    end
    
endmodule