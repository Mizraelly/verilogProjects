transcript on
vlib work
vlog  BarrelShiftRegister.v
vlog  BarrelShiftRegister_tb.v

vsim -t 1ns -voptargs="+acc" testbench

add wave /testbench/clk
add wave /testbench/data
add wave /testbench/load
add wave /testbench/res_n
add wave /testbench/direction_right
add wave -radix unsigned /testbench/shift_emount
add wave /testbench/out

configure wave -timelineunits ns
run -all
wave zoom full

