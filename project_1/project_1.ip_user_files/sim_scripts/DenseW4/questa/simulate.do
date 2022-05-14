onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DenseW4_opt

do {wave.do}

view wave
view structure
view signals

do {DenseW4.udo}

run -all

quit -force
