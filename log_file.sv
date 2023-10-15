`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver;
  `uvm_component_utils(driver)
  
  function new(string path, uvm_component parent);
    super.new(path, parent);
  endfunction
  
  task run();
    `uvm_info("DRV","driver1 executed",UVM_NONE);
    `uvm_warning("DRV", "warining msg");
    `uvm_error("DRV","error msg 1");
    `uvm_error("DRV","error msg 2");

  endtask
endclass

module tb;
  driver drv;
  int file;
  initial begin
    file = $fopen("log.txt","w");
    drv = new("DRV",null);
    drv.set_report_default_file(file);
    drv.set_report_severity_action(UVM_INFO, UVM_DISPLAY|UVM_LOG);
    drv.set_report_severity_action(UVM_WARNING, UVM_DISPLAY|UVM_LOG);
    drv.set_report_severity_action(UVM_ERROR, UVM_DISPLAY|UVM_LOG);
    drv.run();
    #1;
    $fclose(file);
  end
endmodule