transcript on

if { [file exists "work"] } {
    vdel -all
}
vlib work
vlog  pc.v regFile.v shiftLeftBy2.v signExtend.v mux2in1.v lab1_tb.v
vsim -t 1ns -voptargs="+acc" testbench
#def clk
add wave testbench/clk

#def wave for test mux2in1

add wave -radix unsigned /testbench/dat0
add wave -radix unsigned /testbench/dat1
add wave -radix unsigned /testbench/control
add wave -radix unsigned /testbench/odat

#def wave for test regFile


#def wave for test shiftLeftBy2


#def wave for test signExtend
add wave /testbench/iDatSignEx
add wave /testbench/SignExEn
add wave /testbench/oDatSignEx

#def wave for test PC
add wave /testbench/i_rst_n_pc
add wave -radix unsigned /testbench/in_pc
add wave -radix unsigned /testbench/out_pc

#def wave for test shiftLeftBy2
add wave /testbench/i_data_shift_by_2
add wave /testbench/o_data_shift_by_2

#def wave for test regFile
add wave -radix unsigned /testbench/i_raddr1_reg
add wave -radix unsigned /testbench/i_raddr2_reg
add wave -radix unsigned /testbench/i_waddr_reg
add wave -radix unsigned /testbench/i_wdata_reg
add wave /testbench/i_we_reg
add wave -radix unsigned /testbench/regFile/register
add wave -radix unsigned /testbench/o_rdata1_reg
add wave -radix unsigned /testbench/o_rdata2_reg

#def clk
add wave testbench/clk


onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full


