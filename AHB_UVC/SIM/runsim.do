vsim -assertdebug AHB_UVC_top +UVM_TESTNAME=$1 +UVM_VERBOSITY=UVM_HIGH
run -all
wave zoom full
# {0 ps} {341250 ps}
config wave -signalnamewidth 1
