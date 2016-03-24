// Code your testbench here
// or browse Examples

`include "uvm_macros.svh"
`include "testbench_pkg.svh"

module top ();
  import uvm_pkg::*;
  import testbench_pkg::*;
  mux m0 ();
  logic Clk;
  initial begin
    $fsdbDumpfile("verilog.fsdb");
    $fsdbDumpvars(0,top);
  end
  
  initial begin
    Clk = 0;
    forever #10 Clk = ~Clk;
  end
  
  initial begin
    uvm_config_db#(virtual mux_if)::set(uvm_root::get(),"*","dut_vif",m0.mux_if0);
    run_test("mux_test");
  end
  
  assign m0.mux_if0.Clk = Clk;

endmodule
