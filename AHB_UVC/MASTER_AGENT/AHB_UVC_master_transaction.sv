// ------------------------------------------------------------------------- 
// File name    : AHB_UVC_master_transaction.sv
// Title        : AHB_UVC master_transaction class
// Project      : AHB_UVC VIP
// Created On   : 2024-02-07
// Developers   : 
// -------------------------------------------------------------------------

class AHB_UVC_master_transaction_c extends uvm_sequence_item;
    `uvm_object_utils(AHB_UVC_master_transaction_c)

    // object constructor
    extern function new(string name = "AHB_UVC_master_transaction_c");
endclass : AHB_UVC_master_transaction_c

//////////////////////////////////////////////////////////////////
// Method name        : new()
// Parameter Passed   : string and handle of parent class
// Returned Parameter : none
// Description        : component constructor
//////////////////////////////////////////////////////////////////
function AHB_UVC_master_transaction_c::new(string name = "AHB_UVC_master_transaction_c");
    super.new(name);
endfunction : new
