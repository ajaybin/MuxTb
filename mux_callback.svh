`ifndef MUX_CALLBACK_SVH
`define MUX_CALLBACK_SVH
class mux_callback_interface extends uvm_callback;
  `uvm_object_utils(mux_callback_interface)

  function new (string name = "mux_callback_interface");
    super.new(name);
  endfunction

  virtual function void pre_send();
  endfunction

  virtual function void post_send();
  endfunction
  
endclass

class mux_callback extends mux_callback_interface;
  `uvm_object_utils(mux_callback)

  function new (string name = "mux_callback");
    super.new(name);
  endfunction

  function void pre_send();
    `uvm_info(get_type_name(),"Driving item",UVM_NONE)
  endfunction

  function void post_send();
    `uvm_info(get_type_name(),"Item driven", UVM_NONE)
  endfunction 
endclass
`endif
