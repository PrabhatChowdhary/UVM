`include "uvm_macros.svh"
import uvm_pkg::*;

class obj extends uvm_object;
  //`uvm_object_utils(obj) commenting this because we want to use a registered variable/member  and in turn use automation on that variable/member
  
  function new(string path = "obj");
    super.new(path);
  endfunction
   
  rand bit [3:0] a;
  rand bit [7:0] b;
  typedef enum bit[1:0]{s0, s1, s2, s3} state_type;
  rand state_type state;
  real temp = 12.24;
  string str = "hello";
  
  //only a,b and state_type variables will be randomized
  
  //below allows us to use automatic implementations of core data methods
  `uvm_object_utils_begin(obj)
  `uvm_field_int(a, UVM_DEFAULT); //UVM_DEFAULT|UVM_BIN can be used if we want result in binary in place of hex which is default
  `uvm_field_int(b, UVM_DEFAULT|UVM_DEC);
  `uvm_field_enum(state_type, state, UVM_DEFAULT);
  `uvm_field_real(temp, UVM_DEFAULT);
  `uvm_field_string(str, UVM_DEFAULT);
  `uvm_object_utils_end
  //if variable is not registered and the above 3 lines are commented out, there will be no compilation error. But an empty table with just variable name will be printed, and variable value will not be printed
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
