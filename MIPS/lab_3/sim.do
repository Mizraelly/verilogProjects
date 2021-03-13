transcript on

if { [file exists "work"] } {
    vdel -all
}
vlib work
vlog  alu.v aluControl.v adder.v inst_memory.v data_memory.v controlUnit.v nextPC.v pc.v regFile.v signExtend.v mux2in1.v lab3_tb.v 
vsim -t 1ns -voptargs="+acc" testbench

#add wave /testbench/
#clk
add wave /testbench/clk

#MUX MUX_NextPC_to_PC
add wave -radix unsigned /testbench/MUX_NextPC_to_PC/i_dat0
add wave -radix unsigned /testbench/MUX_NextPC_to_PC/i_dat1
add wave /testbench/MUX_NextPC_to_PC/i_control
add wave -radix unsigned /testbench/MUX_NextPC_to_PC/o_dat

#PC
add wave /testbench/pc/i_rst_n
add wave -radix unsigned /testbench/pc/i_pc
add wave -radix unsigned /testbench/pc/o_pc

#AdderPC
add wave -radix unsigned /testbench/adderPC/i_op1
add wave -radix unsigned /testbench/adderPC/i_op2
add wave -radix unsigned /testbench/adderPC/o_result

#InstMem
add wave -radix unsigned /testbench/inst_memory/i_addr
add wave -radix hexadecimal /testbench/inst_memory/o_data
add wave -radix hexadecimal /testbench/inst_memory/inst_mem

#MUX_InstMem_to_RegFile
add wave -radix unsigned /testbench/MUX_InstMem_to_RegFile/i_dat0
add wave -radix unsigned /testbench/MUX_InstMem_to_RegFile/i_dat1
add wave /testbench/MUX_InstMem_to_RegFile/i_control
add wave -radix unsigned /testbench/MUX_InstMem_to_RegFile/o_dat


#regFile
add wave -radix unsigned /testbench/regFile/i_raddr1
add wave -radix unsigned /testbench/regFile/i_raddr2
add wave -radix unsigned /testbench/regFile/i_waddr
add wave -radix unsigned /testbench/regFile/i_wdata
add wave /testbench/regFile/i_we
add wave -radix unsigned /testbench/regFile/o_rdata1
add wave -radix unsigned /testbench/regFile/o_rdata2
add wave -radix unsigned /testbench/regFile/register

#Extender
add wave -radix unsigned /testbench/signExtend/i_data
add wave /testbench/signExtend/i_en
add wave -radix unsigned /testbench/signExtend/o_data


#MUX_RegFile_to_ALU
add wave -radix unsigned /testbench/MUX_RegFile_to_ALU/i_dat0
add wave -radix unsigned /testbench/MUX_RegFile_to_ALU/i_dat1
add wave /testbench/MUX_RegFile_to_ALU/i_control
add wave -radix unsigned /testbench/MUX_RegFile_to_ALU/o_dat

#alu
add wave -radix unsigned /testbench/alu/i_op1
add wave -radix unsigned /testbench/alu/i_op2
add wave -radix hexadecimal /testbench/alu/i_control
add wave -radix unsigned /testbench/alu/o_result
add wave /testbench/alu/o_zf


#data_memory
add wave -radix unsigned /testbench/data_memory/i_addr
add wave -radix unsigned /testbench/data_memory/i_data
add wave /testbench/data_memory/i_we
add wave -radix unsigned /testbench/data_memory/o_data
add wave -radix unsigned /testbench/data_memory/data_mem

#MUX_DataMem_to_RegFile
add wave -radix unsigned /testbench/MUX_DataMem_to_RegFile/i_dat0
add wave -radix unsigned /testbench/MUX_DataMem_to_RegFile/i_dat1
add wave /testbench/MUX_DataMem_to_RegFile/i_control
add wave -radix unsigned /testbench/MUX_DataMem_to_RegFile/o_dat

#contolUnit
add wave -radix unsigned /testbench/controlUnit/i_op
add wave /testbench/controlUnit/o_regDst
add wave /testbench/controlUnit/o_J
add wave /testbench/controlUnit/o_Beq
add wave /testbench/controlUnit/o_ExtOp
add wave /testbench/controlUnit/o_memToReg
add wave /testbench/controlUnit/o_aluOp
add wave /testbench/controlUnit/o_memWrite
add wave /testbench/controlUnit/o_memRead
add wave /testbench/controlUnit/o_aluSrc
add wave /testbench/controlUnit/o_regWrite


#aluControl
add wave /testbench/aluControl/i_aluOp
add wave -radix hexadecimal /testbench/aluControl/i_func
add wave -radix hexadecimal  /testbench/aluControl/o_aluControl

#next PC
add wave -radix unsigned /testbench/nextPC/i_incPC
add wave -radix unsigned /testbench/nextPC/i_imm26
add wave /testbench/nextPC/i_zero
add wave /testbench/nextPC/i_j
add wave /testbench/nextPC/i_beq
add wave /testbench/nextPC/o_PCSrc
add wave -radix unsigned /testbench/nextPC/o_addr

onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full