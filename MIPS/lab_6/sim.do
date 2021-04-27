transcript on

if { [file exists "work"] } {
    vdel -all
}
vlib work
vlog  alu.v aluControl.v adder.v inst_memory.v data_memory.v controlUnit.v nextPC.v pc.v regFile.v signExtend.v mux2in1.v mux3in1.v mux4in1.v register.v hazardDetect_unit.v main.v lab6_tb.v 
vsim -t 1ns -voptargs="+acc" testbench


add wave /testbench/main/*


add wave /testbench/main/hazardDetect_unit/*
add wave /testbench/main/regFile/register
add wave /testbench/main/data_memory/data_mem
onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full