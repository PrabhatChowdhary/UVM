//DUT
module adder(
  input [3:0] a,b,
  output [4:0] y
);

  assign y = a + b;

endmodule

//INTERFACE
interface adder_if;
  logic [3:0] a;
  logic [3:0] b;
  logic [4:0] y;

endinterface

//TESTBENCH
`include "uvm_macros.svh"
import uvm_pkg::*;

class drv extends uvm_driver;
  `uvm_component_utils(drv)
  
  virtual adder_if aif;
  
  function new(input string path = "drv", uvm_component parent = null);
    super.new(path, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual adder_if)::get(this,"","aif",aif))
  //reference to component that is trying to acess configuration data = this = uvm_test_top.env.agent.drv,
  //heirarchial path = location of config data in hierarchy = "" means default of global namespace instance name, 
  //key, 
  //value
      `uvm_error("drv","unable to access interface");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    for(int i = 0; i< 10; i++)
      begin
        aif.a = $urandom;
        aif.b = $urandom;
      end
    phase.drop_objection(this);
  endtask
  
endclass

//agent class
class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  function new(input string inst = "agent", uvm_component c);
    super.new(inst, c);
  endfunction
  
  drv d;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d = drv::type_id::create("drv", this);
  endfunction
  
endclass

//environment
class env extends uvm_env;
  `uvm_component_utils(env)
  
  function new(input string inst = "env", uvm_component c);
    super.new(inst, c);
  endfunction
  
  agent a;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = agent::type_id::create("agent", this);
  endfunction
  
endclass

//uvm test
class test extends uvm_test;
  `uvm_component_utils(test)
  
  function new(input string inst = "test", uvm_component c);
    super.new(inst, c);
  endfunction
  
  env e;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("env", this);
  endfunction
  
endclass

//module
module tb;
  
  adder_if aif();
  
  adder dut(.a(aif.a), .b(aif.b), .y(aif.y));
  
  initial begin
    uvm_config_db#(virtual adder_if)::set(null,"uvm_test_top.env.agent.drv","aif",aif);
    //refers to UVM component where the function is being called. Null means it is not tied to a particular class and belongs to default or global space
    //hpath = path of class where we are storing the value
    //key
    //value
    
    run_test("test");
  end
  
 /* initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  */
endmodule
