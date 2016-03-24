`ifndef MUX_ENV_SVH
`define MUX_ENV_SVH
class mux_env extends uvm_env;
  `uvm_component_utils(mux_env)
  
  mux_agent agent;
  mux_sb sb;
  mux_callback mux_cb;

  uvm_event end_stim_event;
  uvm_event_pool event_pool;
  
  function new(string name = "mux_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = mux_agent::type_id::create("mux_agent",this);
	   sb = mux_sb::type_id::create("mux_sb",this);
    mux_cb = mux_callback::type_id::create("mux_cb",this);

    event_pool = uvm_event_pool::get_global_pool();
    end_stim_event = new ("end_stim_event");
    event_pool.add("end_stim_event", end_stim_event);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   	agent.monitor.input_ap.connect(sb.input_xp);
	   agent.monitor.output_ap.connect(sb.output_xp);
	   agent.monitor.reset_ap.connect(sb.reset_xp);
    uvm_callbacks#(mux_driver)::add(null, mux_cb); 
  endfunction

  task run_phase (uvm_phase phase);
    event_pool = uvm_event_pool::get_global_pool();
    end_stim_event = event_pool.get("end_stim_event");

    super.run_phase(phase);
    agent.seqr.wait_clocks(1000);
    end_stim_event.trigger();
  endtask

endclass
`endif
