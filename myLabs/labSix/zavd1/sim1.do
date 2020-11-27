transcript on

if { [file exists "work"] } {
    vdel -all
}

vlib work
vlog  stateMacSix.v stateMacSix_tb.v

vsim -t 1ns -voptargs=+acc testbench

add wave /testbench/clk
add wave /testbench/reset
add wave /testbench/w
add wave /testbench/statemac/state
add wave /testbench/out
onbreak resume

configure wave -timelineunits ns
run -all
wave zoom full