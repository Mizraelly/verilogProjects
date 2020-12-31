

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog MCU.v SCU.v rom.v decoder.v Register.v CU.v MCU_test.v

# Open testbench module for simulation

vsim -t 1ns -voptargs="+acc" work.MCU_test

# Add all testbench signals to waveform diagram

add wave /MCU_test/Resetn
add wave /MCU_test/Mclk
add wave /MCU_test/Pclk

add wave /MCU_test/Run
add wave /MCU_test/mcu/run_r
add wave /MCU_test/Done

add wave /MCU_test/mcu/memory/data
add wave /MCU_test/bus

add wave /MCU_test/mcu/scu/control_unit/current_state
add wave /MCU_test/mcu/scu/control_unit/next_state

add wave /MCU_test/mcu/scu/control_unit/IR
add wave /MCU_test/mcu/scu/control_unit/IRin


add wave /MCU_test/mcu/scu/R0/data
add wave /MCU_test/mcu/scu/R1/data
add wave /MCU_test/mcu/scu/R2/data
add wave /MCU_test/mcu/scu/R3/data
add wave /MCU_test/mcu/scu/R4/data
add wave /MCU_test/mcu/scu/R5/data
add wave /MCU_test/mcu/scu/R6/data
add wave /MCU_test/mcu/scu/R7/data
add wave /MCU_test/mcu/scu/A/data
add wave /MCU_test/mcu/scu/G/data




onbreak resume

# Run simulation
run -all

wave zoom full