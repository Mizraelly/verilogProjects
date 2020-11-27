transcript on
if { [file exists "work"] } {
    vdel -all
}

vlib work

vlog stateMac.v master.v top.v count.v slave.v top_tb.v

vsim -t 1ns -voptargs="+acc" testbench

add wave /testbench/clk
add wave /testbench/sck
add wave /testbench/rst_n
add wave /testbench/en
add wave /testbench/mosi
add wave /testbench/miso

#state mac.....................................................
add wave -radix unsigned /testbench/top1/slave1/MAC1/state
add wave /testbench/top1/slave1/MAC1/o_en_write_par_reg
add wave /testbench/top1/slave1/MAC1/o_en_write_word_to_par_reg
add wave /testbench/top1/slave1/MAC1/o_en_write_word_to_shreg
add wave /testbench/top1/slave1/MAC1/o_en_shift_reg
add wave /testbench/top1/slave1/MAC1/o_en_miso
add wave /testbench/top1/slave1/MAC1/o_en_count
add wave /testbench/top1/slave1/MAC1/o_res_count
add wave /testbench/top1/slave1/MAC1/o_inc_reg

#counter.......................................................
add wave -radix unsigned /testbench/top1/slave1/count1/counter

#slave register................................................
add wave -radix unsigned /testbench/top1/slave1/par_reg1
add wave -radix ASCII /testbench/top1/slave1/par_reg2
add wave -radix ASCII /testbench/top1/slave1/shift_reg
add wave /testbench/top1/slave1/syn_reg_sck_ff
add wave /testbench/top1/slave1/syn_reg_cs_ff


#master port...................................................
add wave /testbench/top1/master1/i_clk
add wave /testbench/top1/master1/i_sck
add wave /testbench/top1/master1/i_rst_n
add wave -radix hexadecimal /testbench/top1/master1/i_data
add wave /testbench/top1/master1/i_load
add wave /testbench/top1/master1/i_miso
add wave /testbench/top1/master1/o_en
add wave /testbench/top1/master1/o_mosi
add wave /testbench/top1/master1/sck_detect

#master register...............................................
add wave -radix ASCII /testbench/top1/master1/shiftReg

#front detector................................................
add wave /testbench/top1/slave1/sck_detect
add wave /testbench/top1/slave1/cs_detect

onbreak resume
run -all

configure wave -timelineunits ns
wave zoom full