class mux_seq_item extends uvm_sequence_item;
  rand bit [31:0] input1;
  rand bit [31:0] input2;
  rand bit select;
  
  `uvm_object_utils_begin(mux_seq_item);
    `uvm_field_int(input1,UVM_ALL_ON);
    `uvm_field_int(input2,UVM_ALL_ON);
    `uvm_field_int(select,UVM_ALL_ON);
  `uvm_object_utils_end;
  
  //Constructor!!
  function new (string name = "mux_seq_item");
    super.new(name);
  endfunction
  //Random constraint.. 
  constraint c_input1 {
    input1 < 10;
  }
  constraint c_input2 {
    input2 < 10;
  }
                  
endclass