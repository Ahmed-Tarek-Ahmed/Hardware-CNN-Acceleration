`timescale 1ns / 1ps


module MaxComp
    #(parameter insize = 32,parameter outsize = 3)
    (
    input [insize*5-1:0] INPUT,
    output reg [outsize-1:0] Out
    );
    
    reg [outsize-1:0] i1,i2,i3;
    reg signed [insize-1:0] t1,t2,t3,t4,t5;
       
    always@*
    begin
    if (INPUT[insize-1:0]>INPUT[2*insize-1:insize])
        begin
        i1='b000;
     end
     else begin
        i1='b001;
     end
     
     if (INPUT[insize*4-1:insize*3]>INPUT[5*insize-1:insize*4])
     begin
             i2='b011;
      end
      else begin
             i2='b100;
      end   
      
      if (i1 == 0)
      begin
          i3 = INPUT[insize-1:0]>INPUT[insize*2+:insize]?'b000:'b010;
       end
       else begin
           i3 = INPUT[insize+:insize]>INPUT[insize*2+:insize]?'b001:'b010;
       end
       
       if (i2 == 3)
       begin
                 Out = INPUT[insize*i3+:insize]>INPUT[insize*3+:insize]?i3:'b011;
       end
       else begin
                 Out = INPUT[insize*i3+:insize]>INPUT[insize*4+:insize]?i3:'b100;
       end
       
    end
endmodule
