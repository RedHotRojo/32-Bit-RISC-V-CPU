
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA7/testbench {C:/Users/rojo/Documents/Quartus/LA7/testbench/reset_clock.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA7/testbench {C:/Users/rojo/Documents/Quartus/LA7/testbench/RISCV_tb.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA7/testbench {C:/Users/rojo/Documents/Quartus/LA7/testbench/RAM_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/rojo/Documents/Quartus/LA7/testbench {C:/Users/rojo/Documents/Quartus/LA7/testbench/ROM_memory.v}


vsim work.testbench

add wave -position insertpoint  \
sim:/testbench/b2v_RISCV/b2v_datapath_0/InstrF \
sim:/testbench/b2v_RISCV/b2v_datapath_0/InstrD \
sim:/testbench/b2v_RISCV/b2v_datapath_0/InstrE \
sim:/testbench/b2v_RISCV/b2v_datapath_0/InstrM \
sim:/testbench/b2v_RISCV/b2v_datapath_0/InstrW \
sim:/testbench/b2v_RISCV/b2v_datapath_0/HazardUnit/flushD \
sim:/testbench/b2v_RISCV/b2v_datapath_0/HazardUnit/flushE \

run 25250 ns
