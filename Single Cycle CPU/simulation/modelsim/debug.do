
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA6/testbench {C:/Users/rojo/Documents/Quartus/LA6/testbench/reset_clock.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA6/testbench {C:/Users/rojo/Documents/Quartus/LA6/testbench/RISCV_tb.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA6/testbench {C:/Users/rojo/Documents/Quartus/LA6/testbench/RAM_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA6/testbench {C:/Users/rojo/Documents/Quartus/LA6/testbench/ROM_memory.v}


vsim work.testbench

add wave -position insertpoint  \
sim:/testbench/PC\
sim:/testbench/Instr \
sim:/testbench/b2v_RISCV/b2v_datapath_0/* \
sim:/testbench/b2v_RISCV/b2v_controller_0/b2v_control_signals/* \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[0] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[1] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[2] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[3] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[4] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[5] \
sim:/testbench/b2v_RISCV/b2v_datapath_0/b2v_rf_0/Q[6] \

run 600 ns
