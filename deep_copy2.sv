`include "uvm_macros.svh"
import uvm_pkg::*;

class first extends uvm_object;
  rand bit[3:0] data;
  
  function new(string path="first");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(first)
  `uvm_field_int(data, UVM_DEFAULT);
  `uvm_object_utils_end
  
endclass

class second extends uvm_object;
  first f;
  
  function new(string path = "second");
    super.new(path);
    f = new("first");
  endfunction
  
  `uvm_object_utils_begin(second)
  `uvm_field_object(f, UVM_DEFAULT);
  `uvm_object_utils_end
  
endclass

module tb;
  second s1, s2;
  initial begin
    s1 = new("second1");
    s2 = new("second2");
    s1.f.randomize();
    
    s1.print();
    
    $cast(s2, s1.clone());
    s2.print();
    
    s2.f.data = 20;
    s1.print();
    s2.print();
    //result of print shows that we have a different data handle f for both the instances, as values of both variables are different.
    //hence clone method is also a deep copy method.
  end
endmodule

    
  
  
  
  
  
  
  
  
