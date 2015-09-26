`ifndef MUX_AGENT_SVH
`define MUX_AGENT_SVH
class mux_agent extends uvm_agent;
  `uvm_component_utils(mux_agent)
  mux_seqr seqr;
  mux_driver driver;
  mux_mon monitor;
  
  function new (string name = "mux_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
	if(is_active == UVM_ACTIVE) begin
      seqr = mux_seqr::type_id::create("mux_seqr",this);
      driver = mux_driver::type_id::create("mux_driver",this);
	end
	monitor = mux_mon::type_id::create("mux_monitor",this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    if(is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(seqr.seq_item_export);
	end
  endfunction
endclass
`endif