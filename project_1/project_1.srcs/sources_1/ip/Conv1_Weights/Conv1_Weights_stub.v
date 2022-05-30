// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sun May 29 23:36:31 2022
// Host        : DESKTOP-PCIMVFJ running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/University/Graduation_Project/Hardware-CNN-Acceleration-/project_1/project_1.srcs/sources_1/ip/Conv1_Weights/Conv1_Weights_stub.v
// Design      : Conv1_Weights
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module Conv1_Weights(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[2:0],douta[4095:0]" */;
  input clka;
  input ena;
  input [2:0]addra;
  output [4095:0]douta;
endmodule
