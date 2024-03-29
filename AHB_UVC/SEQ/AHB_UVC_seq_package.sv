`ifndef AHB_UVC_SEQ_PKG_SV
`define AHB_UVC_SEQ_PKG_SV

package AHB_UVC_seq_package;
   
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import AHB_UVC_master_package::*;
  import AHB_UVC_slave_package::*;

  /** Base sequence file*/
  `include "AHB_UVC_master_base_sequence.sv"
  `include "AHB_UVC_slave_base_sequence.sv"

  /** Other sequences*/
  `include "AHB_UVC_master_wr_seq.sv"
endpackage : AHB_UVC_seq_package
`endif /** AHB_UVC_SEQ_PKG*/

