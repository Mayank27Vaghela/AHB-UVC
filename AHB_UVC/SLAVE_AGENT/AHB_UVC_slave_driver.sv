// ------------------------------------------------------------------------- 
// File name    : AHB_UVC_slave_driver_c.sv
// Title        : AHB_UVC slave driver class
// Project      : AHB_UVC
// Created On   : 2024-02-07
// Developers   : 
// -------------------------------------------------------------------------

class AHB_UVC_slave_driver_c extends uvm_driver#(AHB_UVC_slave_transaction_c);
  `uvm_component_utils(AHB_UVC_slave_driver_c)    

  virtual AHB_UVC_interface slv_vif;
  // component constructor
  extern function new(string name = "AHB_UVC_slave_driver_c", uvm_component parent);

  // component build phase
  extern virtual function void build_phase(uvm_phase phase);

  // component connect phase
  extern virtual function void connect_phase(uvm_phase phase);    

  // component run phase
  extern virtual task run_phase(uvm_phase phase); 

  // send to dut task 
  extern virtual task send_to_dut(AHB_UVC_slave_transaction_c req);
  
  //reset task
  extern virtual task reset();


endclass : AHB_UVC_slave_driver_c

//////////////////////////////////////////////////////////////////
// Method name        : new()
// Parameter Passed   : string and handle of parent class
// Returned Parameter : none
// Description        : component constructor
//////////////////////////////////////////////////////////////////
function AHB_UVC_slave_driver_c::new(string name = "AHB_UVC_slave_driver_c", uvm_component parent);
  super.new(name, parent);
endfunction : new

//////////////////////////////////////////////////////////////////
// Method name        : build_phase()
// Parameter Passed   : handle of class uvm_phase
// Returned Parameter : none
// Description        : for building components
//////////////////////////////////////////////////////////////////
function void AHB_UVC_slave_driver_c::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name(), "build phase", UVM_HIGH)
endfunction : build_phase

//////////////////////////////////////////////////////////////////
// Method name        : connect_phase()
// Parameter Passed   : handle of class uvm_phase
// Returned Parameter : none
// Description        : for connecting components
//////////////////////////////////////////////////////////////////
function void AHB_UVC_slave_driver_c::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name(), "connect phase", UVM_HIGH)
endfunction : connect_phase

//////////////////////////////////////////////////////////////////
// Method name        : run_phase()
// Parameter Passed   : handle of class uvm_phase
// Returned Parameter : none
// Description        : post build/connect phase
//////////////////////////////////////////////////////////////////
task AHB_UVC_slave_driver_c::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name(), "run phase", UVM_HIGH)

  wait(!slv_vif.hresetn)
  reset();
  
   forever begin
    fork
      forever begin
      @(slv_vif.clk);
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
      end
     wait(!slv_vif.hresetn)
    join_any
      disable fork;

    if(!slv_vif.hresetn)
      reset();
  end

endtask : run_phase

task AHB_UVC_slave_driver_c::send_to_dut(AHB_UVC_slave_transaction_c req);
  
  `uvm_info(get_type_name(), "Inside send_to_dut task", UVM_HIGH)
  req.print();
    
  if(req.htrans_type == IDLE || req.htrans_type == BUSY)
    begin
      slv_vif.hready_out <= req.hready_out;
      slv_vif.hresp      <= hresp_enum'(OKAY); 
      slv_vif.hradat     <= req.hrdata;
    end

  else if(req.hresp_type) 
    begin
      slv_vif.hresp       <= hresp_enum'(ERROR);
      slv_vif.hrdata      <= '0;
      slv_vif.hready_out  <= '1;
      @(slv_vif.clk)
      slv_vif.hready_out      <= '1;
      slv_vif.hresp       <= hresp_enum'(OKAY);
    end
  else
    begin
      slv_vif.hreadyout    <= req.hreadyout;
      slv_vif.hresp        <= req.hresp_type;
      slv_vif.hrdata       <= req.hrdata;
      
    end

   if(!req.hreadyout && !slv_vif.hresp) begin
    slv_vif.hready_out <= '1;
    end
   else if(slv_vif.hresp && slv_vif.htrans==htrans_enum'(IDLE))
    slv_vif.hready_out <= '1;


endtask


task AHB_UVC_slave_driver_c::reset();
  slv_vif.hready_out <='1;
  slv_vif.hresp <= '0;
  slv_vif.hrdata <= 0;
endtask
