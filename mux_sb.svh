`ifndef MUX_SB_SVH
`define MUX_SB_SVH
class mux_sb extends uvm_scoreboard;
  
  `uvm_component_utils_begin(mux_sb)
    `uvm_config_int(enable,UVM_ALL_ON)
  `uvm_component_utils_end
  
  `uvm_analysis_imp_decl( _input )
  uvm_analysis_imp_input #(mux_seq_item,mux_sb) input_xp;
  
  `uvm_analysis_imp_decl( _output )
  uvm_analysis_imp_output #(bit [31:0],mux_sb) output_xp;
  
  `uvm_analysis_imp_decl( _reset )
  uvm_analysis_imp_reset #(reset_state_e,mux_sb) reset_xp;
  
  reset_state_e reset;
  
  bit enable = 1;
  
  mux_seq_item sb_q[$];
  
  function new (string name = "mux_sb", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
	input_xp = new("input_xp",this);
	output_xp = new("output_xp",this);
	reset_xp = new("reset_xp",this);
  endfunction
  
  function void write_input(mux_seq_item mux_in);
    if (enable && reset == RESET_INACTIVE) begin
	  sb_q.push_back(mux_in);
	end
  endfunction
  
  function void write_output(bit [31:0] out);
    if (enable && reset == RESET_INACTIVE) begin
	  mux_seq_item entry = sb_q.pop_front();
	  if (out !== selector(entry)) begin
	    `uvm_error("CHECK_OUTPUT",$sformatf("Incorrect Output.\n%s",entry.sprint())
	  end
	end
  endfunction

  function void write_reset(reset_state_e rst);
    if (enable) begin
      reset_state_e = rst;
	end
  end
  
  function bit [31:0] selector (mux_seq_item entry);
    if (entry.select == 1'b0) begin
	  return entry.input1;
	end
	else begin
	  return entry.input2;
	end
  endfunction
  
endclass
`endif