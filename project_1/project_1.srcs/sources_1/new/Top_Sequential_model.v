`timescale 1ns / 1ps

module Top_Sequential_model#(parameter n_unitsC = 32, size = 16,DP=4,FC1=16,FC2=1,RC1=3,RC2=3,MaxPool_layerSize = 16,
                                       MC1Depth = 3,MC2Depth = 6,Wr_MemBlkDepth = 6, r_MemBlkDepth = 3,DeseMemDepth = 9,
                                       memblkReadWidth = 2048
                            )
    (
        input clk
    );
    wire [MC1Depth-1:0] MC1; // Address MC1 out of Control Unit
    wire [MC2Depth-1:0] MC2; // Address MC2 out of Control Unit
    wire [Wr_MemBlkDepth-1:0] Wr_MemBlk1_Address; //Memory Block-1 Write address Address out of Control
    wire [Wr_MemBlkDepth-1:0] Wr_MemBlk2_Address; //Memory Block-1 Write address Address out of Control
    wire [Wr_MemBlkDepth-1:0] Wr_MemBlk3_Address; //Memory Block-1 Write address Address out of Control
    wire [r_MemBlkDepth-1:0] r_MemBlk1_Address; //Memory Block-1 Read address Address out of Control
    wire [r_MemBlkDepth-1:0] r_MemBlk2_Address; //Memory Block-2 Read address Address out of Control
    wire [r_MemBlkDepth-1:0] r_MemBlk3_Address; //Memory Block-3 Read address Address out of Control
    wire denseEnable;
    wire [2:0]Enable; // Memory Array EnableBus out of Control Unit
    wire [size*16*FC1-1:0] WC1; // Wire out of MC1
    wire [size*256*FC2-1:0] WC2;// Wire out of MC2
    wire [size*8*RC1-1:0] DataC1;// Wire out of Embedding
    wire [size*128*RC2-1:0] DataC2;// Wire out of Memory Array
    wire mode; // Wire out of Control Unit
    wire [size*n_unitsC-1:0]OutC; // Wire Out of Concolution
    wire [size*n_unitsC-1:0]OutR; // wire out of Register File-1  
    wire [MaxPool_layerSize*size - 1 :0] MP_layerOut;
    wire [size-1 : 0] Out_AT1;
    wire [size-1 : 0] Out_AT2;
    wire [size-1 :0] Out_MPU;
    wire [size-1 :0] OutR2;
    wire [memblkReadWidth-1 :0]Memblk1; // out of memblk-1
    wire [memblkReadWidth-1 :0]Memblk2; // out of memblk-2
    wire [memblkReadWidth-1 :0]Memblk3; // out of memblk-3
    wire [memblkReadWidth*3 -1 :0]MemArrayOUT ;
    assign MemArrayOUT = {Memblk1,Memblk2,Memblk3};
    Conv_Layer_Seq C(
        .WC1(WC1),
        .WC2(WC2),
        .DataC1(DataC2),
        .DataC2(DataC2),
        .clk(clk),
        .OutR(OutC)
    );
    RegisterFile#(.ele_num(MaxPool_layerSize*2),.in_size(size)) R1(
        .enable(clk),
        .inbus(OutC),
        .outbus(OutR)
    );
    MaxPoolLayer#(.n_outputs(MaxPool_layerSize),.Input_size(size),.cs(32)) MPL(
        .OUTBUS(MP_layerOut),
        .INBUS(OutR)
    );
    AdderTree#(.n(MaxPool_layerSize),.size(size)) AT1( // may add enable to stop in conv-1 mode
        .in(OutR[size*n_unitsC-1:(size*n_unitsC-1)/2]),
        .out(Out_AT1)
     );
    AdderTree#(.n(MaxPool_layerSize),.size(size)) AT2(  // may add enable to stop in conv-1 mode
         .in(OutR[(size*n_unitsC)/2-1:0]),
         .out(Out_AT2)
    );
    MaxPoolUnit#(.In_size(size)) MPU(
        .in({Out_AT1,Out_AT2}),
        .Out(Out_MPU)
    );
    RegisterFile#(.ele_num(1),.in_size(size)) R2(
        .enable(clk && mode),
        .inbus(Out_MPU),
        .outbus(OutR2)
    );
    ControlUnit(
        .clk(clk),
        .Conv_mode(mode),
        .MC1_Address(MC1),
        .MC2_Address(MC2),
        .EnableBus(Enable), 
        .Wr_MemBlk1_Address(Wr_MemBlk1_Address),
        .Wr_MemBlk2_Address(Wr_MemBlk2_Address),
        .Wr_MemBlk3_Address(Wr_MemBlk3_Address),
        .r_MemBlk1_Address(r_MemBlk1_Address),
        .r_MemBlk2_Address(r_MemBlk2_Address),
        .r_MemBlk3_Address(r_MemBlk3_Address),
        .r_Dese_Adress(0), // to be reviewed
        .denseEnable(denseEnable)   
    );
    MemBlk_1(
      .addra(Wr_MemBlk1_Address),.ena(Enable[2]),.dina(MP_layerOut),.clka(clk),
      .addrb(r_MemBlk1_Address),.clkb(clk),.enb(mode),.doutb(Memblk1) 
    );
    MemBlk_2(
        .addra(Wr_MemBlk2_Address),.ena(Enable[1]),.dina(MP_layerOut),.clka(clk),
          .addrb(r_MemBlk2_Address),.clkb(clk),.enb(mode),.doutb(Memblk2)
        );
    MemBlk_3(
        .addra(Wr_MemBlk3_Address),.ena(Enable[0]),.dina(MP_layerOut),.clka(clk),
        .addrb(r_MemBlk3_Address),.clkb(clk),.enb(mode),.doutb(Memblk3)            
        );
    Conv1_Weights(
        .addra(MC1),.ena(!mode),.douta(WC1),.clka(clk)
    );
    Conv2_Weights(
        .addra(MC2),.ena(!mode),.douta(WC2),.clka(clk)
        );
endmodule
