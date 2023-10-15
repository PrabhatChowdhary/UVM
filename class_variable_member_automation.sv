`include "uvm_macros.svh"
import uvm_pkg::*;

class obj extends uvm_object;
  //`uvm_object_utils(obj) commenting this because we want to use a registered variable/member and in turn use automation on that variable/member
  
  function new(string path = "obj");
    super.new(path);
  endfunction
   
  rand bit [3:0] a;
  
  `uvm_object_utils_begin(obj)
  `uvm_field_int(a, UVM_DEFAULT);
  `uvm_object_utils_end
  
endclass

module tb;
  obj number;
  
  initial begin
    number = new("obj");
    number.randomize();
    //`uvm_info("obj",$sformatf("value of random number is %0d",o.a),UVM_LOW); incorrect usage
    //`uvm_info("TB_TOP",$sformatf("value of random number is %0d",number.a),UVM_NONE); we want to use print macro
    number.print();
  end
endmodule
