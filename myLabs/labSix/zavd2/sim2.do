transcript on

if { [file exists "work"] } {
    vdel -all
}

vlib work
vlog  micro_mac.v micro_mac_tb.v

vsim -t 1ns -voptargs="+acc" testbench

add wave /testbench/clk
add wave /testbench/x1
add wave /testbench/x2
add wave /testbench/x3
add wave /testbench/machine/state
add wave /testbench/out
onbreak resume

configure wave -timelineunits ns
run -all
wave zoom full