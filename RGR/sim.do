transcript on
if { [file exists "work"] } {
    vdel -all
}

vlib work

vlog stateMac.v master.v top.v count.v slave.v top_tb.v

vsim -t 1ns -voptargs="+acc" testbench

add wave /testbench/clk
add wave /testbench/rst_n
add wave /testbench/en
add wave /testbench/mosi
add wave /testbench/miso

#state mac.....................................................
add wave -radix unsigned /testbench/top1/slave1/MAC1/state
add wave /testbench/top1/slave1/MAC1/o_en_write_par_reg
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
add wave -radix unsigned /testbench/top1/slave1/shift_reg_mosi
add wave -radix ASCII /testbench/top1/slave1/shift_reg_miso
add wave /testbench/top1/slave1/syn_reg_sck_ff
add wave /testbench/top1/slave1/syn_reg_cs_ff

#front detector slave..........................................
add wave /testbench/top1/slave1/sck_detect
add wave /testbench/top1/slave1/cs_detect

#master port...................................................
add wave /testbench/top1/master1/i_rst_n
add wave /testbench/top1/master1/i_clk
add wave /testbench/top1/master1/o_sck
add wave /testbench/top1/master1/o_en
add wave /testbench/top1/master1/i_miso
add wave /testbench/top1/master1/o_mosi


#master register...............................................
add wave /testbench/top1/master1/sck_detect
add wave -radix ASCII /testbench/top1/master1/shift_reg_miso
add wave -radix unsigned /testbench/top1/master1/shift_reg_mosi
add wave -radix unsigned /testbench/top1/master1/addr
add wave -radix ASCII /testbench/top1/master1/data_reg

add wave  /testbench/top1/master1/sync_reg_miso_ff
add wave  /testbench/top1/master1/counter_sck

add wave -radix unsigned /testbench/top1/master1/sck_gen
add wave -radix unsigned /testbench/top1/master1/out_sck_gen




add wave /testbench/top1/slave1/shift_reg_miso

add wave /testbench/top1/master1/shift_reg_miso
add wave /testbench/top1/master1/sync_reg_miso_ff

onbreak resume
run -all

configure wave -timelineunits ns
wave zoom full