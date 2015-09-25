// Code your design here
module mux 
  (
input [31:0] A,
input [31:0] B,
input Sel,
input Clk,
input Reset,
output [31:0] Out
  );
  reg [31:0] A_d0;
  reg [31:0] B_d0;
  reg [31:0] Out_d0;
  reg Sel_d0;
  
  always @(posedge Clk) begin
    if(Reset) begin
      A_d0 <= 32'd0;
      B_d0 <= 32'd0;
      Sel_d0 <= 32'd0;
    end
    else begin
      A_d0 <= A;
      B_d0 <= B;
      Sel_d0 <= Sel;
    end
  end
  
  always @(posedge Clk) begin
    if (Reset) begin
      Out_d0 <= 32'd0;
    end
    else begin
      if (Sel_d0 == 1'b1) begin
        Out_d0 <= B_d0;
      end
      else begin
        Out_d0 <= A_d0;
      end
    end
  end
  
  assign Out = Out_d0;
endmodule

interface mux_if(
  input [31:0] A,
  input [31:0] B,
  input [31:0] Out,
  input Sel,
  input Clk,
  input Reset);
  clocking mux_cb @(posedge Clk);
    input A;
    input B;
    input Sel;
    input Out;
  endclocking
endinterface

//Create instance of mux interface called mux_if0 in all instances of mux module
bind mux mux_if mux_if0(.*);