onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Conv2_Weights -L blk_mem_gen_v8_4_1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Conv2_Weights xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Conv2_Weights.udo}

run -all

endsim

quit -force
