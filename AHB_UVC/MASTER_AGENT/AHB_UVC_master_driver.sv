// ------------------------------------------------------------------------- 
// File name    : AHB_UVC_master_driver_c.sv
// Title        : AHB_UVC master driver class
// Project      : AHB_UVC
// Created On   : 2024-02-07
// Developers   : 
// -------------------------------------------------------------------------

class AHB_UVC_master_driver_c extends uvm_driver#(AHB_UVC_transaction_c);
  `uvm_component_utils(AHB_UVC_master_driver_c)    

  //Instance of the AHB interface
  virtual AHB_UVC_interface uvc_if;

  //AHB_UVC_transaction trans[$]; 

  // component constructor
  extern function new(string name = "AHB_UVC_master_driver_c", uvm_component parent);

  // component build phase
  extern virtual function void build_phase(uvm_phase phase);

  // component connect phase
  extern virtual function void connect_phase(uvm_phase phase);    

  // component run phase
  extern virtual task run_phase(uvm_phase phase); 

  extern function void reset(); 

  extern task address_phase(); 

  extern task data_phase(); 

endclass : AHB_UVC_master_driver_c

//////////////////////////////////////////////////////////////////
// Method name        : new()
// Parameter Passed   : string and handle of parent class
// Returned Parameter : none
// Description        : component constructor
//////////////////////////////////////////////////////////////////
function AHB_UVC_master_driver_c::new(string name = "AHB_UVC_master_driver_c", uvm_component parent);
    super.new(name, parent);
endfunction : new

//////////////////////////////////////////////////////////////////
// Method name        : build_phase()
// Parameter Passed   : handle of class uvm_phase
// Returned Parameter : none
// Description        : for building components
//////////////////////////////////////////////////////////////////
function void AHB_UVC_master_driver_c::build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "build phase", UVM_HIGH)
    if(!uvm_config_db#(virtual AHB_UVC_interface)::get(this,"","uvc_if",uvc_if))
      `uvm_error(get_type_name(),"Not able to get interface");
endfunction : build_phase

//////////////////////////////////////////////////////////////////
// Method name        : connect_phase()
// Parameter Passed   : handle of class uvm_phase
// Returned Parameter : none
// Description        : for connecting components
//////////////////////////////////////////////////////////////////
function void AHB_UVC_master_driver_c::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "connect phase", UVM_HIGH)
endfunction : connect_phase

//////////////////////////////////////////////////////////////////
// Method name        : run_phase()
// Parameter Passed   : handle of class uvm_phase
// Returned Parameter : none
// Description        : post build/connect phase
//////////////////////////////////////////////////////////////////
task AHB_UVC_master_driver_c::run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "run phase", UVM_HIGH)
    forever begin
       fork
         begin
            wait(!uvc_if.hresetn)
            reset();
         end

         begin  
            forever begin
              @(posedge uvc_if.hclk)
               seq_item_port.get_next_item(req);
               //trans.push_back(req);
               address_phase();
               data_phase();
               seq_item_port.item_done(req);
            end
         end
       join_any
       disable fork;
       wait(uvc_if.hresetn);
    end
endtask : run_phase

function void AHB_UVC_master_driver_c::reset();
 uvc_if.Haddr    = '0;
 uvc_if.Hburst   = '0;
 uvc_if.Hprot    = '0;
 uvc_if.Hsize    = '0;
 uvc_if.Htrans   = '0;
 uvc_if.Hwdata   = '0;
 uvc_if.Hwrite   = '0;
endfunction : reset

task AHB_UVC_master_driver_c::address_phase();
  uvc_if.Htrans  <= req.htrans_type[0];
  uvc_if.Haddr   <= req.haddr;
  uvc_if.Hwrite <= req.hwrite;
  uvc_if.Hburst <= req.hburst_type;
  uvc_if.Hsize  <= req.hsize_type;
  wait(uvc_if.Hready_out);
endtask : address_phase

task AHB_UVC_master_driver_c::data_phase();
  uvc_if.Hwdata  <= req.hwdata[0];
  wait(uvc_if.Hready_out);
endtask : data_phase

