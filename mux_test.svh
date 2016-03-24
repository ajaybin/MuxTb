`ifndef MUX_TEST_SVH
`define MUX_TEST_SVH
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
    // TO prevent the test from quitting mid sequence raise an objection
    phase.raise_objection(this);
    seq = mux_sequence::type_id::create("mux_seq");
    seq.start(env.agent.seqr);
	   // Drop it here after the sequence is completed.
    phase.drop_objection(this);
  endtask

endclass
`endif
