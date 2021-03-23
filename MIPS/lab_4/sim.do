transcript on

if { [file exists "work"] } {
    vdel -all
}
vlib work
vlog  alu.v aluControl.v adder.v inst_memory.v data_memory.v controlUnit.v nextPC.v pc.v regFile.v signExtend.v mux2in1.v main.v lab4_tb.v 
vsim -t 1ns -voptargs="+acc" testbench


add wave /testbench/clk

#MUX MUX_NextPC_to_PC
add wave -radix unsigned /testbench/main/MUX_NextPC_to_PC/i_dat0
add wave -radix unsigned /testbench/main/MUX_NextPC_to_PC/i_dat1
add wave /testbench/main/MUX_NextPC_to_PC/i_control
add wave -radix unsigned /testbench/main/MUX_NextPC_to_PC/o_dat

#PC
add wave /testbench/main/pc/i_rst_n
add wave -radix unsigned /testbench/main/pc/i_pc
add wave -radix unsigned /testbench/main/pc/o_pc

#AdderPC
add wave -radix unsigned /testbench/main/adderPC/i_op1
add wave -radix unsigned /testbench/main/adderPC/i_op2
add wave -radix unsigned /testbench/main/adderPC/o_result

#InstMem
add wave -radix unsigned /testbench/main/inst_memory/i_addr
add wave -radix hexadecimal /testbench/main/inst_memory/o_data
add wave -radix hexadecimal /testbench/main/inst_memory/inst_mem

#MUX_InstMem_to_RegFile
add wave -radix unsigned /testbench/main/MUX_InstMem_to_RegFile/i_dat0
add wave -radix unsigned /testbench/main/MUX_InstMem_to_RegFile/i_dat1
add wave /testbench/main/MUX_InstMem_to_RegFile/i_control
add wave -radix unsigned /testbench/main/MUX_InstMem_to_RegFile/o_dat


#regFile
add wave -radix unsigned /testbench/main/regFile/i_raddr1
add wave -radix unsigned /testbench/main/regFile/i_raddr2
add wave -radix unsigned /testbench/main/regFile/i_waddr
add wave -radix unsigned /testbench/main/regFile/i_wdata
add wave /testbench/main/regFile/i_we
add wave -radix unsigned /testbench/main/regFile/o_rdata1
add wave -radix unsigned /testbench/main/regFile/o_rdata2
add wave -radix unsigned /testbench/main/regFile/register

#Extender
add wave -radix unsigned /testbench/main/signExtend/i_data
add wave /testbench/main/signExtend/i_en
add wave -radix unsigned /testbench/main/signExtend/o_data


#MUX_RegFile_to_ALU
add wave -radix unsigned /testbench/main/MUX_RegFile_to_ALU/i_dat0
add wave -radix unsigned /testbench/main/MUX_RegFile_to_ALU/i_dat1
add wave /testbench/main/MUX_RegFile_to_ALU/i_control
add wave -radix unsigned /testbench/main/MUX_RegFile_to_ALU/o_dat

#alu
add wave -radix unsigned /testbench/main/alu/i_op1
add wave -radix unsigned /testbench/main/alu/i_op2
add wave -radix hexadecimal /testbench/main/alu/i_control
add wave -radix unsigned /testbench/main/alu/o_result
add wave /testbench/main/alu/o_zf


#data_memory
add wave -radix unsigned /testbench/main/data_memory/i_addr
add wave -radix unsigned /testbench/main/data_memory/i_data
add wave /testbench/main/data_memory/i_we
add wave -radix unsigned /testbench/main/data_memory/o_data
add wave -radix unsigned /testbench/main/data_memory/data_mem

#MUX_DataMem_to_RegFile
add wave -radix unsigned /testbench/main/MUX_DataMem_to_RegFile/i_dat0
add wave -radix unsigned /testbench/main/MUX_DataMem_to_RegFile/i_dat1
add wave /testbench/main/MUX_DataMem_to_RegFile/i_control
add wave -radix unsigned /testbench/main/MUX_DataMem_to_RegFile/o_dat

#contolUnit
add wave -radix unsigned /testbench/main/controlUnit/i_op
add wave /testbench/main/controlUnit/o_regDst
add wave /testbench/main/controlUnit/o_J
add wave /testbench/main/controlUnit/o_Beq
add wave /testbench/main/controlUnit/o_ExtOp
add wave /testbench/main/controlUnit/o_memToReg
add wave /testbench/main/controlUnit/o_aluOp
add wave /testbench/main/controlUnit/o_memWrite
add wave /testbench/main/controlUnit/o_memRead
add wave /testbench/main/controlUnit/o_aluSrc
add wave /testbench/main/controlUnit/o_regWrite


#aluControl
add wave /testbench/main/aluControl/i_aluOp
add wave -radix hexadecimal /testbench/main/aluControl/i_func
add wave -radix hexadecimal  /testbench/main/aluControl/o_aluControl

#next PC
add wave -radix unsigned /testbench/main/nextPC/i_incPC
add wave -radix unsigned /testbench/main/nextPC/i_imm26
add wave /testbench/main/nextPC/i_zero
add wave /testbench/main/nextPC/i_j
add wave /testbench/main/nextPC/i_beq
add wave /testbench/main/nextPC/o_PCSrc
add wave -radix unsigned /testbench/main/nextPC/o_addr

onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full