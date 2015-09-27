package testbench_pkg;
import uvm_pkg::*;
`include "mux_seq_item.svh"
`include "mux_seqr.svh"
`include "mux_driver.svh"
`include "mux_sequence.svh"
`include "mux_agent.svh"
`include "mux_sb.svh"
`include "mux_mon.svh"
`include "mux_env.svh"
`include "mux_test.svh"

enum {RESET_INACTIVE,RESET_ACTIVE} reset_state_e;

endpackage : testbench_pkg