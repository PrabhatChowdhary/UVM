`include "uvm_macros.svh"
import uvm_pkg::*;

class obj extends uvm_object;
  //`uvm_object_utils(obj) commenting this because we want to use a registered variable/member  and in turn use automation on that variable/member
  
  function new(string path = "obj");
    super.new(path);
  endfunction
   
  rand bit [3:0] a;
  //below allows us to use automatic implementations of core data methods
  `uvm_object_utils_begin(obj)
  `uvm_field_int(a, UVM_DEFAULT); //UVM_DEFAULT|UVM_BIN can be used if we want result in binary in place of hex which is default
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
    //number.print(uvm_default_tree_printer); to be used for printing in tree format in  place of default which is a table format
    //number.print(uvm_default_line_printer);  to see the result in a single line
  end
endmodule
