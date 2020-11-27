transcript on

if { [file exists "work"] } {
    vdel -all
}

vlib work
vlog  stateMacThree.v stateMacThree_tb.v

vsim -t 1ns -voptargs=+acc testbench

add wave clk
add wave /testbench/rst
add wave /testbench/state
add wave /testbench/x
add wave /testbench/y
add wave /testbench/z1
add wave /testbench/z2

onbreak resume

configure wave -timelineunits ns
run -all
wave zoom full