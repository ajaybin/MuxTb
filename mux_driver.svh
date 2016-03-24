`ifndef MUX_DRIVER_SVH
`define MUX_DRIVER_SVH
class mux_driver extends uvm_driver#(mux_seq_item);
  `uvm_component_utils(mux_driver)

  `uvm_register_cb(mux_driver, mux_callback_interface)
  
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
    //Init
    m_if.A <= 0;
    m_if.B <= 0;
    m_if.Sel <= 0;
    m_if.in_val <= 0;
    m_if.Reset <= 0;
    //Drive Reset
    repeat(10) @(m_if.mux_cb);
    m_if.Reset = 1;
    repeat(10) @(m_if.mux_cb);
    m_if.Reset = 0;
    repeat(10) @(m_if.mux_cb);
    
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_do_callbacks(mux_driver, mux_callback_interface, pre_send())
      m_if.A <= req.input1;
      m_if.B <= req.input2;
      m_if.Sel <= req.select;
      m_if.in_val <= 1'b1;
      @(m_if.mux_cb)
      m_if.in_val <= 1'b0;
      seq_item_port.item_done();
      `uvm_do_callbacks(mux_driver, mux_callback_interface, post_send())
    end
  endtask
endclass : mux_driver
`endif
