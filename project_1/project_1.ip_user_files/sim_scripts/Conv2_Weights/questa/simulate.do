onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Conv2_Weights_opt

do {wave.do}

view wave
view structure
view signals

do {Conv2_Weights.udo}

run -all

quit -force
