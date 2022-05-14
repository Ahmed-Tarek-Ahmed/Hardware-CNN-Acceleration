onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib C1W_opt

do {wave.do}

view wave
view structure
view signals

do {C1W.udo}

run -all

quit -force
