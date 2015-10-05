`ifndef MUX_MON_SVH
`define MUX_MON_SVH
class mux_mon extends uvm_monitor;
  `uvm_component_utils(mux_mon)
  virtual mux_if m_if;
  
  uvm_analysis_port #(mux_seq_item) input_ap;
  uvm_analysis_port #(bit [31:0]) output_ap;
  uvm_analysis_port #(reset_state_e) reset_ap;
  
  mux_seq_item mon_item;
  bit [31:0] output_data;
  testbench_pkg::reset_state_e reset;
  
  function new(string name = "mux_mon", uvm_component parent);
    super.new(name,parent);
	input_ap = new("input_ap",this);
	output_ap = new("output_ap",this);
 reset_ap = new("reset_ap",this);
	output_data = 32'd0;
	reset = RESET_INACTIVE;
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(!uvm_config_db#(virtual mux_if)::get(this,"","dut_vif",m_if)) begin
	  `uvm_error("Build Phase","Could not find virtual interface mux_if")
	end
	
	
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork : run_phase
      forever begin
	    @(m_if.mux_cb);
     if (m_if.mux_cb.in_val) begin
	      mon_item = mux_seq_item::type_id::create("mon_item");
  	    mon_item.input1 = m_if.mux_cb.A;
	      mon_item.input2 = m_if.mux_cb.B;
	      mon_item.select = m_if.mux_cb.Sel;

		     input_ap.write(mon_item);
     end
     if (m_if.mux_cb.out_val) begin
       output_data = m_if.mux_cb.Out;
     		output_ap.write(output_data);
     end
      end
	  
	  forever begin
	    @(m_if.Reset)
     reset = m_if.Reset;
		reset_ap.write(reset);
	  end
	  
    join
  endtask
  
endclass
`endif
