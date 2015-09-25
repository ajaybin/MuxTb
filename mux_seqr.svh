`ifndef MUX_SEQR_SVH
`define MUX_SEQR_SVH
class mux_seqr extends uvm_sequencer#(mux_seq_item);
  `uvm_component_utils(mux_seqr)
  virtual mux_if m_if;
  bit end_stimulus = 1'b0;
  function new(string name = "mux_seqr",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual mux_if)::get(this,"","dut_vif",m_if))
      `uvm_error ("Build Phase","Interface Retrieval failed")
  endfunction
  
  task wait_clocks(int clocks);
    repeat(clocks) @(m_if.mux_cb);
  endtask
    
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      wait_clocks(1000);
      end_stimulus = 1;
    endtask
endclass
`endif