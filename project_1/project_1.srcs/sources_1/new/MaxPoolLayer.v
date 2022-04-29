`timescale 1ns / 1ps


module MaxPoolLayer # (parameter n_outputs = 3, Input_size = 32,cs=3)
    ( 
        input [n_outputs*Input_size*2 - 1:0]INBUS,
        output [n_outputs*Input_size-1 : 0]OUTBUS
    );
    genvar i;
    
  
    generate

    for(i=1; i<=n_outputs; i = i+1)begin : MaxPoolUnit
        localparam integer x = cs/2+1;
        localparam integer c=i/x;
        localparam integer k=i-1;
        if(cs%2!=0) begin
               MaxPoolUnit #(.In_size(Input_size)) ui
               (
                .in(INBUS[Input_size*(2*i+k) - 1-:Input_size*2]),
                .Out(OUTBUS[Input_size*i - 1 -:Input_size])
               ); 
               
    end
    else begin 
           MaxPoolUnit #(.In_size(Input_size)) ui
            (
             .in(INBUS[Input_size*2*i - 1:Input_size*2*(i-1)]),
             .Out(OUTBUS[Input_size*i - 1 -:Input_size])
            ); 
    end
    end
    endgenerate
endmodule