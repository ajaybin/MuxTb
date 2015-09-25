`ifndef MUX_ENV_SVH
`define MUX_ENV_SVH
class mux_env extends uvm_env;
  `uvm_component_utils(mux_env)
  
  mux_agent agent;
  
  function new(string name = "mux_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = mux_agent::type_id::create("mux_agent",this);
  endfunction
  
endclass
`endif