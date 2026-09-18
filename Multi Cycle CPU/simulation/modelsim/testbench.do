
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA5/testbench {C:/Users/rojo/Documents/Quartus/LA5/testbench/reset_clock.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA5/testbench {C:/Users/rojo/Documents/Quartus/LA5/testbench/ROM_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA5/testbench {C:/Users/rojo/Documents/Quartus/LA5/testbench/RAM_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA5/testbench {C:/Users/rojo/Documents/Quartus/LA5/testbench/address_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA5/testbench {C:/Users/rojo/Documents/Quartus/LA5/testbench/RISCV_tb.v}


vsim work.testbench

add wave -position insertpoint  \
sim:/testbench/b2v_RISCV/b2v_datapath_0/Instr \
sim:/testbench/b2v_RISCV/b2v_datapath_0/PC \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[0] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[1] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[2] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[3] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[4] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[5] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[6] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[7] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[8] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[9] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[10] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[11] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[12] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[13] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[14] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[15] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[16] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[17] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[18] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[19] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[20] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[21] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[22] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[23] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[24] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[25] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[26] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[27] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[28] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[29] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[30] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[31] \
sim:/testbench/b2v_RAM_0/RAM[0] \
sim:/testbench/b2v_RAM_0/RAM[1] \
sim:/testbench/b2v_RAM_0/RAM[2] \
sim:/testbench/b2v_RAM_0/RAM[3] \
sim:/testbench/b2v_RAM_0/RAM[4] \
sim:/testbench/b2v_RAM_0/RAM[5] \
sim:/testbench/b2v_RAM_0/RAM[6] \
sim:/testbench/b2v_RAM_0/RAM[7] \
sim:/testbench/b2v_RAM_0/RAM[8] \
sim:/testbench/b2v_RAM_0/RAM[9] \
sim:/testbench/b2v_RAM_0/RAM[10] \
sim:/testbench/b2v_RAM_0/RAM[11] \
sim:/testbench/b2v_RAM_0/RAM[12] \
sim:/testbench/b2v_RAM_0/RAM[13] \
sim:/testbench/b2v_RAM_0/RAM[14] \
sim:/testbench/b2v_RAM_0/RAM[15] \
sim:/testbench/b2v_RAM_0/RAM[16] \
sim:/testbench/b2v_RAM_0/RAM[17] \
sim:/testbench/b2v_RAM_0/RAM[18] \
sim:/testbench/b2v_RAM_0/RAM[19] \
sim:/testbench/b2v_RAM_0/RAM[20] \
sim:/testbench/b2v_RAM_0/RAM[21] \
sim:/testbench/b2v_RAM_0/RAM[22] \
sim:/testbench/b2v_RAM_0/RAM[23] \
sim:/testbench/b2v_RAM_0/RAM[24] \
sim:/testbench/b2v_RAM_0/RAM[25] \
sim:/testbench/b2v_RAM_0/RAM[26] \
sim:/testbench/b2v_RAM_0/RAM[27] \
sim:/testbench/b2v_RAM_0/RAM[28] \
sim:/testbench/b2v_RAM_0/RAM[29] \
sim:/testbench/b2v_RAM_0/RAM[30] \
sim:/testbench/b2v_RAM_0/RAM[31] 

run 80000 ns
