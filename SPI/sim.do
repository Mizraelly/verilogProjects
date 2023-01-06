transcript on

vlib work
vlog spi_core.v tb.v
vsim -t 1ns -voptargs="+acc" testbench

add wave -radix unsigned /testbench/o_finish
add wave -radix unsigned /testbench/o_start
add wave -radix unsigned /testbench/shift_receiver

add wave /testbench/i_clk

add wave /testbench/o_mosi
add wave /testbench/o_sck



add wave -radix unsigned /testbench/spi_core_0/state

add wave /testbench/spi_core_0/shift_register
add wave -radix unsigned /testbench/spi_core_0/cnt_data_length
add wave -radix unsigned /testbench/spi_core_0/cnt_delay


onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full