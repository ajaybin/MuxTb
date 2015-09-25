`ifndef MUX_DRIVER_SVH
`define MUX_DRIVER_SVH
class mux_driver extends uvm_driver#(mux_seq_item);
  `uvm_component_utils(mux_driver)
  
  virtual mux_if m_if;
  
  function new (string name = "mux_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual mux_if)::get(this,"","dut_vif",m_if))
      `uvm_error("Build Phase","Interface not found")
  endfunction
      
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    //Drive Reset
    m_if.Reset = 1;
    repeat(10) @(m_if.mux_cb);
    m_if.Reset = 0;
    
    forever begin
      seq_item_port.get_next_item(req);
      @(m_if.mux_cb)
      m_if.A <= req.input1;
      m_if.B <= req.input2;
      m_if.Sel <= req.select;
      seq_item_port.item_done();
    end
  endtask
endclass : mux_driver
`endif