`include "uvm_macros.svh"//using 'uvm_info macro here
import uvm_pkg::*; //for definition of classes that we will use

module tb;
  initial begin
    `uvm_info("TB_TOP","HELLO",UVM_LOW);
    $display("display says hello");
  end
  
endmodule
