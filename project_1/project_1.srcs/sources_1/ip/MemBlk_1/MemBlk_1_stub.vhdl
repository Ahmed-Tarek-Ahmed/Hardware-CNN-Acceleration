-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Mon May 30 16:51:37 2022
-- Host        : DESKTOP-PCIMVFJ running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/University/Graduation_Project/Hardware-CNN-Acceleration-/project_1/project_1.srcs/sources_1/ip/MemBlk_1/MemBlk_1_stub.vhdl
-- Design      : MemBlk_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx485tffg1157-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemBlk_1 is
  Port ( 
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 5 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 255 downto 0 );
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 2 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 2047 downto 0 )
  );

end MemBlk_1;

architecture stub of MemBlk_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,ena,wea[0:0],addra[5:0],dina[255:0],clkb,enb,addrb[2:0],doutb[2047:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_1,Vivado 2018.2";
begin
end;
