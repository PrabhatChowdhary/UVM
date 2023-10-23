// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class comp extends uvm_component;
  `uvm_component_utils(comp)
  
  function new(string path = "comp", uvm_component parent = null);//if we want any class to be child of UVM_TOP we label its parent as null 
    super.new(path, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ph","build phase is executed",UVM_LOW);
  endfunction
endclass


module tb;
  initial begin
    run_test("comp");// since comp class is registered with uvm_factory we can use run_test without even initializing the class with an object
  end
endmodule


//below is the traditional method used in systemverilog. The above one is used in UVM
/*
module tb;
  comp c;
  initial begin;
    c = comp::type_id::create("c", null);//labelling its parent as null because we want comp to be child of UVM_TOP
    c.build_phase(null);//null because we don't have anything like phase in  test bench top
  end
endmodule
*/
