transcript on

if { [file exists "work"] } {
    vdel -all
}
vlib work
vlog  ALU.v ALU_tb.v
vsim -t 1ns -voptargs="+acc" testbench
add wave /testbench/i_clk
add wave /testbench/a
add wave /testbench/b
add wave /testbench/out
add wave /testbench/mode

onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full


