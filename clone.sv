// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class first extends uvm_object;
  rand bit[2:0] data;
  
  function new(string path = "first22");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(first)
  `uvm_field_int(data, UVM_DEFAULT);
  `uvm_object_utils_end
endclass

module tb;
  first f;
  first s;
  
  initial begin
    f = new("first1");
    //s = new("first2"); we don't need to call construtor for clone 
    f.randomize();
    //s = f.clone();  this won't work because f.clone() will have type of parent class which is uvm_object, whereas s is child class: first
    $cast(s, f.clone());

    f.print();
    s.print();
  end
endmodule
