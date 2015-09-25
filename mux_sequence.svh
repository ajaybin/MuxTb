`ifndef MUX_SEQUENCE_SVH
`define MUX_SEQUENCE_SVH

class mux_sequence extends uvm_sequence_base;
  `uvm_object_utils(mux_sequence);
  `uvm_declare_p_sequencer(testbench_pkg::mux_seqr);
  
  function new(string name = "mux_sequence");
    super.new();
  endfunction
  
  task body();
    super.body();
    
      forever begin
        mux_seq_item seq_item = mux_seq_item::type_id::create("seq_item");          
        if (p_sequencer.end_stimulus) begin
          return; 
        end

        wait_clocks($urandom_range(10,2));        
        if(!seq_item.randomize() with {input1 < 5;}) begin
          `uvm_error("mux_seq","Sequence item randomization failed")
        end          
        `uvm_info("mux_seq",$sformatf("Sending Request req:\n%s",seq_item.sprint()),UVM_NONE)
        start_item(seq_item);
        finish_item(seq_item);
      end
  endtask : body
  
  task wait_clocks(int clocks);
    p_sequencer.wait_clocks(clocks);
  endtask : wait_clocks
  
endclass
`endif