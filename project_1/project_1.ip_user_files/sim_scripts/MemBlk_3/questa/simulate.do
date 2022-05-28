onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib MemBlk_3_opt

do {wave.do}

view wave
view structure
view signals

do {MemBlk_3.udo}

run -all

quit -force
