`timescale 1ns / 1ps


module MaxComp
    #(parameter insize = 32,parameter outsize = 3)
    (
    input [insize*5-1:0] INPUT,
    output reg [outsize-1:0] Out
    );
    
    reg [outsize-1:0] i1,i2,i3;
    
       
    always@*
    begin
    if ($signed(INPUT[insize-1:0])>$signed(INPUT[2*insize-1:insize]))
        begin
        i1='b000;
     end
     else begin
        i1='b001;
     end
     
     if ($signed(INPUT[insize*4-1:insize*3])>$signed(INPUT[5*insize-1:insize*4]))
     begin
             i2='b011;
      end
      else begin
             i2='b100;
      end   
      
      if (i1 == 0)
      begin
          i3 = $signed(INPUT[insize-1:0])>$signed(INPUT[insize*2+:insize])?'b000:'b010;
       end
       else begin
           i3 = $signed(INPUT[insize+:insize])>$signed(INPUT[insize*2+:insize])?'b001:'b010;
       end
       
       if (i2 == 3)
       begin
                 Out = $signed(INPUT[insize*i3+:insize])>$signed(INPUT[insize*3+:insize])?i3:'b011;
       end
       else begin
                 Out = $signed(INPUT[insize*i3+:insize])>$signed(INPUT[insize*4+:insize])?i3:'b100;
       end
       
    end
endmodule
