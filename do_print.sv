`include "uvm_macros.svh"
import uvm_pkg::*;

class object extends uvm_object;
  `uvm_object_utils(object)
  
  function new(string path = "object");
    super.new(path);
  endfunction
  
  int data;
  string name;
  real c;
  
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    
    printer.print_field_int("data", $bits(data), UVM_DEFAULT);
    printer.print_string("name", name);
    printer.print_real("c", c);
  endfunction
	
endclass

module tb;
  object o;
  initial begin
    o = new("object");
    o.print();
  end
endmodule
