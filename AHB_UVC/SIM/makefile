#makefile

PKG		= ../MASTER_AGENT/AHB_UVC_master_package.sv ../SLAVE_AGENT/AHB_UVC_slave_package.sv ../ENV/AHB_UVC_env_package.sv ../SEQ/AHB_UVC_seq_package.sv ../TEST/AHB_UVC_test_package.sv  ../TB/AHB_UVC_package.sv  
INCLUDE = +incdir+../INCLUDE +incdir+../SRC +incdir+../MASTER_AGENT +incdir+../SLAVE_AGENT +incdir+../ENV +incdir+../SEQ +incdir+../TEST +incdir+../TB
TOP 	= ../TB/AHB_UVC_top.sv
TOP_N 	= AHB_UVC_top


#To make a work file
lib:
	vlib work

#To compile the code
comp:
	vlog $(PKG) $(TOP) $(INCLUDE)

#To run the simulation in questasim
sim:
	vsim -assertdebug  $(TOP_N) 
	
#To run the simulation in command prompt
sim_c:
	vsim $(TOP_N) -c