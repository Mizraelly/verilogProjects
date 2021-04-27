transcript on

vlib work
vlog  alu.v aluControl.v adder.v inst_memory.v data_memory.v controlUnit.v nextPC.v pc.v regFile.v signExtend.v mux2in1.v mux3in1.v mux4in1.v register.v hazardDetect_unit.v main.v lab6_tb.v 
vsim -t 1ns -voptargs="+acc" testbench


add wave /testbench/clk

#regFile
add wave -radix unsigned /testbench/main/regFile/i_raddr1
add wave -radix unsigned /testbench/main/regFile/i_raddr2
add wave -radix unsigned /testbench/main/regFile/i_waddr
add wave -radix unsigned /testbench/main/regFile/i_wdata
add wave -radix unsigned /testbench/main/regFile/o_rdata1
add wave -radix unsigned /testbench/main/regFile/o_rdata2
add wave -radix unsigned /testbench/main/regFile/register

#data_memory
add wave -radix unsigned /testbench/main/data_memory/i_addr
add wave -radix unsigned /testbench/main/data_memory/i_data
add wave -radix unsigned /testbench/main/data_memory/data_mem

#alu
add wave -radix unsigned /testbench/main/alu/i_op1
add wave -radix unsigned /testbench/main/alu/i_op2
add wave -radix unsigned /testbench/main/alu/o_result
add wave /testbench/main/alu/o_zf

#Extender
add wave -radix unsigned /testbench/main/signExtend/o_data

#aluControl
add wave /testbench/main/aluControl/i_aluOp
add wave -radix hexadecimal /testbench/main/aluControl/i_func

#contolUnit
add wave -radix unsigned /testbench/main/controlUnit/i_op

#PC
add wave -radix unsigned /testbench/main/pc/o_pc

onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full