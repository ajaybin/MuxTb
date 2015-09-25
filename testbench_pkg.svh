package testbench_pkg;
import uvm_pkg::*;
`include "mux_seq_item.svh"
`include "mux_seqr.svh"
`include "mux_driver.svh"
`include "mux_sequence.svh"
`include "mux_agent.svh"
`include "mux_env.svh"
//`include "mux_sb.svh"
//`include "mux_mon.svh"
//`include "mux_test.svh"

class mux_test extends uvm_test;
  `uvm_component_utils(mux_test)
  mux_env env;
  mux_sequence seq;
  
  function new(string name = "mux_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = mux_env::type_id::create("mux_env",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = mux_sequence::type_id::create("mux_seq");
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
  endtask
endclass
endpackage : testbench_pkg