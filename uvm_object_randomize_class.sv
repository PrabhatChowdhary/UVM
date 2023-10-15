`include "uvm_macros.svh"
import uvm_pkg::*;

class obj extends uvm_object;
  `uvm_object_utils(obj)
  
  function new(string path = "obj");
    super.new(path);
  endfunction
  
  rand bit [3:0] a;
  
endclass

module tb;
  obj number;
  
  initial begin
    number = new("obj");
    number.randomize();
    //`uvm_info("obj",$sformatf("value of random number is %0d",o.a),UVM_LOW);
    `uvm_info("TB_TOP",$sformatf("value of random number is %0d",number.a),UVM_NONE);
  end
endmodule
