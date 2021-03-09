transcript on

if { [file exists "work"] } {
    vdel -all
}
vlib work
vlog  alu.v aluControl.v adder.v inst_memory.v data_memory.v lab2_tb.v
vsim -t 1ns -voptargs="+acc" testbench

#clk
add wave /testbench/clk

#inst mem
add wave /testbench/inst_memory/inst_mem
add wave /testbench/i_addr_inst_memory
add wave -radix hexadecimal /testbench/o_data_inst_memory

#aluControl
add wave /testbench/i_aluOp_aluControl
add wave -radix hexadecimal /testbench/i_func_aluControl
add wave -radix hexadecimal /testbench/o_aluControl_aluControl

#alu
add wave -radix unsigned /testbench/i_op1_alu
add wave -radix unsigned /testbench/i_op2_alu
add wave -radix hexadecimal /testbench/i_control_alu
add wave -radix unsigned /testbench/o_result_alu
add wave /testbench/o_zf_alu

#data_mem
add wave /testbench/i_addr_data_mem
add wave -radix unsigned /testbench/i_data_mem
add wave /testbench/i_we_data_mem
add wave -radix unsigned /testbench/o_data_mem
add wave -radix unsigned /testbench/data_memory/data_mem

#adder
add wave -radix unsigned /testbench/i_op1_adder
add wave -radix unsigned /testbench/i_op2_adder
add wave -radix unsigned /testbench/o_result_adder

onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full