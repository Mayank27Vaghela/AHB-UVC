// ------------------------------------------------------------------------- 
// File name    : AHB_UVC_top.sv
// Title        : AHB_UVC top module 
// Project      : AHB_UVC
// Created On   : 2024-02-07
// Developers   : 
// -------------------------------------------------------------------------

`timescale 10ns/1ps
`include "AHB_UVC_defines.sv"
`include "AHB_UVC_common_defines.sv"
import AHB_UVC_package::*;
`include "AHB_UVC_interface.sv"
`include "AHB_UVC_checker.sv"
module AHB_UVC_top;

import uvm_pkg::*;
`include "uvm_macros.svh"

  bit hclk;
  bit hresetn;

  always #5 hclk = ~hclk;

	//interface handle declaration
	AHB_UVC_interface uvc_if(hclk,hresetn);
    
  /*initial begin
    assign uvc_if.Hready_in = uvc_if.Hready_out;
  end*/

  initial begin
	  uvm_config_db#(virtual AHB_UVC_interface)::set(null, "*", "uvc_if", uvc_if);
    run_test("");
  end

  initial begin
    hresetn = 0;
    #5;
    hresetn = 1;
  end

  initial begin
    uvc_if.Hready_out = 1'b1;
    #35;
    uvc_if.Hready_out = 1'b0;
    #10;
    uvc_if.Hready_out = 1'b1;
  end
endmodule
