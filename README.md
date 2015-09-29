# MuxTb
Simple TB for an over complicated 2:1 Mux 

vcs '-timescale=1ns/1ps' '+vcs+flush+all' '+warn=all' '-sverilog' +incdir+$UVM_HOME/src/ $UVM_HOME/src/uvm.sv $UVM_HOME/src/dpi/uvm_dpi.cc -CFLAGS -DVCS deisgn.sv testbench.sv && ./simv

Use nWave to open waves using file dump.vcd
