`include "uvm_macros.svh"
import uvm_pkg::*;

class my_parent extends uvm_component;
  `uvm_component_utils(my_parent)
  
  function new(string name = "my_parent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
 // virtual function void build_phase(uvm_phase phase);
   // super.build_phase(phase);
  //endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("hello from my_parent");
  endtask
  
endclass

class my_child extends my_parent;
  `uvm_component_utils(my_child)
  
  function new(string name = "my_child", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  //virtual function void build_phase(uvm_phase phase);
  //  super.build_phase(phase);
 // endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("hello from my_child");
  endtask
endclass

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    
    my_parent p0;
    my_child c0;
    
    function new(string name = "my_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p0 = my_parent::type_id::create("p0", null);
      c0 = my_child::type_id::create("c0", null);
      //p0 = new("my_parent", null); //this also works
    endfunction
    
    virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      $display("hello from my_test");
    endtask
  endclass
  


module top;
  
  initial begin
    run_test("my_test");
  end
endmodule
