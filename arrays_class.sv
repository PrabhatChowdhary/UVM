`include "uvm_macros.svh"
import uvm_pkg::*;

class array extends uvm_object;
  
  //static array
  int arr1[3] = {12, 13, 15};
  
  //dynamic array
  int arr2[];
  
  //queue
  int arr3[$];
  
  //associative array
  int arr4[int];
  
  function new(string path = "array");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(array)
  `uvm_field_sarray_int(arr1, UVM_DEFAULT);
  `uvm_field_array_int(arr2, UVM_DEFAULT);
  `uvm_field_queue_int(arr3, UVM_DEFAULT);
  `uvm_field_aa_int_int(arr4, UVM_DEFAULT);
  `uvm_object_utils_end
  
  task run();
    //dynamic array value update
    arr2 = new[3];
    arr2[0] = 21;
    arr2[1] = 22;
    arr2[2] = 24;
    
    //queue value update
    arr3.push_back(44);
    arr3.push_back(45);
    
    //associative array
    arr4[1] = 56;
    arr4[2] = 66;
    arr4[3] = 76;
  endtask
endclass

module tb;
  array a;
  initial begin
    a = new("array");
    a.run();
    a.print();
  end
endmodule

    
    
    
