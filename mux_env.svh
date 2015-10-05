`ifndef MUX_ENV_SVH
`define MUX_ENV_SVH
class mux_env extends uvm_env;
  `uvm_component_utils(mux_env)
  
  mux_agent agent;
  mux_sb sb;
  
  function new(string name = "mux_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = mux_agent::type_id::create("mux_agent",this);
	sb = mux_sb::type_id::create("mux_sb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  	agent.monitor.input_ap.connect(sb.input_xp);
	  agent.monitor.output_ap.connect(sb.output_xp);
	  agent.monitor.reset_ap.connect(sb.reset_xp);
  endfunction
  
endclass
`endif
