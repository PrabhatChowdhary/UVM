`include "uvm_macros.svh"
import uvm_pkg::*;

//dut
module dut(
  input logic clk,
  input logic rst,
  input logic data_in[1:0],
  output logic data_out[1:0]
);
  	
  always @(posedge clk)
    data_out <= data_in;
  
  
endmodule

//interface
interface dut_if(input clk);
  
  logic rst;
  logic data_in[1:0];
  logic data_out[1:0];

endinterface


module dut_wrapper(dut_if _if);
  
  //instantiate the design module and connect interface signals to DUT
  dut dut1(.clk (_if.clk),
           .rst (_if.rst),
           .data_in(_if.data_in),
           .data_out(_if.data_out));
  
endmodule           
  

//###env###
class my_env extends uvm_env;
  `uvm_component_utils (my_env);
  
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase
  
  task run_phase (uvm_phase phase);
    set_report_verbosity_level (UVM_MEDIUM);
    uvm_report_info (get_name(), $sformatf("Hello UVM! Simulation has started"), UVM_MEDIUM);
    `uvm_info (get_name(), $sformatf("Finishing up with run_phase ... "), UVM_LOW)
  endtask : run_phase;
endclass : my_env

//###test###
class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  
  my_env m_top_env;
  virtual dut_if dut_vi;
  
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    m_top_env = my_env::type_id::create("m_top_env", this);
    
    if(! uvm_config_db #(virtual dut_if) :: get (this, "", "dut_if", dut_vi)) begin
      `uvm_error (get_type_name (), "DUT_INTERFACE_NOT_FOUND");
    end
  endfunction: build_phase
  
  virtual function void end_of_elaboration_phase (uvm_phase phase);
    uvm_top.print_topology ();
  endfunction
  
endclass
//top
module tb;
 /* 
  logic clk;

  dut_if _if(clk);

  dut dut1( .clk(clk),
           .rst(_if.rst),
           .data_in(_if.data_in),
           .data_out(_if.data_out)
  );
  */
  //dut_wrapper dut_wr0 (._if (dut_if1));

  initial begin
    run_test("test");
  end

endmodule
