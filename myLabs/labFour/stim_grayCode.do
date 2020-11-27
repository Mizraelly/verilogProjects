transcript on
vlib work

vlog grayCode.v
vlog grayCode_tb.v 

vsim -t 1ns -voptargs="+acc" testbench

add wave /testbench/rst_n
add wave /testbench/clk
add wave -radix unsigned /testbench/out

configure wave -timelineunits ns

run -all
wave zoom full