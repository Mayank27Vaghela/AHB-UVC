// ------------------------------------------------------------------------- 
// File name    : AHB_UVC_top.sv
// Title        : AHB_UVC top module 
// Project      : AHB_UVC
// Created On   : 2024-02-07
// Developers   : 
// -------------------------------------------------------------------------


//`include "AHB_UVC_package.sv"
`include "AHB_UVC_interface.sv"
`include "AHB_UVC_checker.sv"
module AHB_UVC_top;

import uvm_pkg::*;
`include "uvm_macros.svh"
import AHB_UVC_package::*;
	//interface handle declaration
	AHB_UVC_interface vif();
    
  initial begin
	  uvm_config_db#(virtual AHB_UVC_interface)::set(null, "*", "vif", vif);
    run_test();
  end
endmodule
