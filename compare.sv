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

module tb;
  
  first s1, s2;
  int status = 0;
  
  initial begin
    s1 = new("second1");
    s2 = new("second2");
    s1.randomize();//s1.data.randomize() does not work
    s2.randomize();
    
    s1.print();
    s2.print();
    
    status = s1.compare(s2);
    $display("value of status is %0d", status);
    
    //result of print shows that we have a single data handle f for both the instances.
  end
endmodule

    
  
  
  
  
  
  
  
  
