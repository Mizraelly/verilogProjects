transcript on
if { [file exists "work"] } {
    vdel -all
}

vlib work

vlog AU.v CU.v uMac.v uMac_tb.v 

vsim -t 1ns -voptargs="+acc" testbench

add wave /testbench/clk
add wave /testbench/rst_n
add wave -radix unsigned /testbench/a1
add wave -radix unsigned /testbench/a2
add wave -radix unsigned /testbench/b1
add wave -radix unsigned /testbench/b2
add wave -radix unsigned /testbench/mode
add wave -radix unsigned /testbench/itask
add wave -radix signed /testbench/out1
add wave -radix signed /testbench/out2

add wave -radix signed /testbench/uMac1/outAU1
add wave -radix signed /testbench/uMac1/outAU2
add wave -radix signed /testbench/uMac1/outRe
add wave -radix signed /testbench/uMac1/outIm

onbreak resume
run -all

configure wave -timelineunits ns
wave zoom full