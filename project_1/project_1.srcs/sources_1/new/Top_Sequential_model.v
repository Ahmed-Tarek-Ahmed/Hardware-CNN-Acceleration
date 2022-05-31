`timescale 1ns / 1ps

module Top_Sequential_model#(parameter n_unitsC = 32, size = 16,DP=4,FC1=16,FC2=1,RC1=3,RC2=3,MaxPool_layerSize = 16,
                                       MC1Depth = 3,MC2Depth = 6,Wr_MemBlkDepth = 6, r_MemBlkDepth = 3,DeseMemDepth = 9,
                                       memblkReadWidth = 2048,size1=18
                            )
    (
        input clk,reset,
        output [2:0 ]class
    );
    reg [9:0] counter=0;
    wire [8:0] counterD;
    reg [3*3-1:0] samples;
    reg [15*9-1:0] SamplesAll;
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
    wire [31:0] countD;
    wire WC2EN,EnR2;
    wire  [size1*5-1:0]OutputD;

    assign DataC2 = {Memblk3,Memblk2,Memblk1};
    EMB_Layer #(.samples(3),.size(size))EMB (samples,DataC1);
    
    Conv_Layer_Seq C(
        .WC1(WC1),
        .WC2(WC2),
        .DataC1(DataC1),
        .DataC2(DataC2),
        .Out(OutC),
        .mode(mode)
    );
    RegisterFile#(.ele_num(MaxPool_layerSize*2),.in_size(size)) R1(
        .enable(~clk),
        .inbus(OutC),
        .outbus(OutR),
        .reset(reset)
    );
    MaxPoolLayer#(.n_outputs(MaxPool_layerSize),.Input_size(size),.cs(32)) MPL(
        .OUTBUS(MP_layerOut),
        .INBUS(OutR)
    );
    AdderTree#(.n(MaxPool_layerSize),.size(size)) AT1( // may add enable to stop in conv-1 mode
        .in(OutR[size*n_unitsC-1:size*n_unitsC/2]),
        .out(Out_AT2)
     );
    AdderTree#(.n(MaxPool_layerSize),.size(size)) AT2(  // may add enable to stop in conv-1 mode
         .in(OutR[(size*n_unitsC/2) -1:0]),
         .out(Out_AT1)
    );
    MaxPoolUnit#(.In_size(size)) MPU(
        .in({Out_AT1,Out_AT2}),
        .Out(Out_MPU)
    );
    RegisterFile#(.ele_num(1),.in_size(size)) R2(
        .enable(~clk && EnR2),
        .inbus(Out_MPU),
        .outbus(OutR2)
    );
    ControlUnit CU(
        .clk(clk),
        .ExtMode(mode),
        .MC1_Address(MC1),
        .MC2_Address(MC2),
        .EnableBus(Enable), 
        .Wr_MemBlk1_Address(Wr_MemBlk1_Address),
        .Wr_MemBlk2_Address(Wr_MemBlk2_Address),
        .Wr_MemBlk3_Address(Wr_MemBlk3_Address),
        .r_MemBlk1_Address(r_MemBlk1_Address),
        .r_MemBlk2_Address(r_MemBlk2_Address),
        .r_MemBlk3_Address(r_MemBlk3_Address),
        //.r_Dese_Adress(0), // to be reviewed
        .denseEnable(denseEnable),
        .reset(reset),
        .Counter1Debug(countD),
        .WC2EN(WC2EN),
        .EnR2(EnR2)
    );
    MemBlk_1 M1(
      .addra(Wr_MemBlk1_Address),.ena(Enable[2]),.dina(MP_layerOut),.clka(~clk),
      .addrb(r_MemBlk1_Address),.clkb(~clk),.enb(WC2EN),.doutb(Memblk1),.wea('b1) 
    );
    MemBlk_2 M2(
        .addra(Wr_MemBlk2_Address),.ena(Enable[1]),.dina(MP_layerOut),.clka(~clk),
          .addrb(r_MemBlk2_Address),.clkb(~clk),.enb(WC2EN),.doutb(Memblk2),.wea('b1)
        );
    MemBlk_3 M3(
        .addra(Wr_MemBlk3_Address),.ena(Enable[0]),.dina(MP_layerOut),.clka(~clk),
        .addrb(r_MemBlk3_Address),.clkb(~clk),.enb(WC2EN),.doutb(Memblk3),.wea('b1)
        );
    Conv1_Weights Conv1(
        .addra(MC1),.ena(~mode),.douta(WC1),.clka(~clk)
    );
    Conv2_Weights Conv2(
        .addra(MC2),.ena(WC2EN),.douta(WC2),.clka(~clk)
        );
    Dense_Seq Dense(
    .In(OutR2),.enable(denseEnable),.clk(~clk),.Out(OutputD)
    );    
        
     MaxComp# (.insize(size1)) C1ass
           (   .INPUT(OutputD),
               .Out(class)
           );        
        
     always@(negedge clk)begin
        if(reset)
        counter=0;
        else
           counter=counter+'b1;
     end
        integer i;
        integer j;
//        initial 
//            begin
//            //samples=9'b001001001;
//            SamplesAll = 'b001001001100100001011011100011100011100001011011011100100010011100100100001100100001100001010011001100001010010100100100010010001001100;
//            samples = SamplesAll[15*9 -1 -:9];
//            force reset = 1;
//            force clk = 0;
//            #1
//            force clk = 1;
//            #1
//            force reset = 0;
//            #1
//            for(j =0;j<=14;j=j+1)begin
//                samples = SamplesAll[15*9 - j*9 -1 -:9];                                
//                for( i =0; i <= 7; i = i+1)begin  
//                    force clk = 0;
//                    #1;
//                    //$display("MPL_OUT_:%b",MP_layerOut);
//                    //$display("MEmblk1:%b",Memblk1);
//                    //$display("WC1:%b",WC1);
//                    //$display("\n");
//                    force clk = 1;
//                    #1;
//                end
//            end
//            force clk = 0;
//            #1
//            force clk = 1;
//            #1
//            $display("OutM:%b",MP_layerOut);
//            for(i=0;i<451;i=i+1)begin
//             force clk = 0;
//            #1;
//            force clk = 1;
//            #1; 
//                $display("OUTMPU:%b",Out_MPU);  
//                $display("output:%b",OutputD); 
//                $display("dE:%b",denseEnable);
//                $display("cycle%d\n",counter);   

//            end
//            $display("CLASS%d",class);
//            $finish;
//            end
endmodule
