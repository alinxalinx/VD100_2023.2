set tclpath [pwd]
#puts "INFO: Creating new project in $tclpath"
cd $tclpath
#source $tclpath/project_info.tcl
set src_dir $tclpath/src
set projName "ps_hello"
#set projName "axu2cgb_trd"

#create project path
cd ..
set projpath [pwd]
#set rootpath [pwd]
#file mkdir project
#set projpath $rootpath/project
#cd $rootpath/project

source $projpath/auto_create_project/project_info.tcl
create_project -force $projName $projpath -part $devicePart



# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

#file mkdir $projpath/$projName.srcs/sources_1/ip
file mkdir $projpath/$projName.srcs/sources_1/new

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
file mkdir $projpath/$projName.srcs/constrs_1/new

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -simset sim_1
}
file mkdir $projpath/$projName.srcs/sim_1/new

#set ip repo
# set_property  ip_repo_paths  $projpath/ip_repo [current_project]
# update_ip_catalog

set bdname "design_1"
create_bd_design $bdname

open_bd_design $projpath/$projName.srcs/sources_1/bd/$bdname/$bdname.bd

create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.4 versal_cips_0

source $projpath/auto_create_project/ps_config.tcl
set_ps_config versal_cips_0


source $tclpath/pl_config.tcl

regenerate_bd_layout

validate_bd_design
save_bd_design		 

make_wrapper -files [get_files $projpath/$projName.srcs/sources_1/bd/$bdname/$bdname.bd] -top
# add_files -norecurse $projpath/$projName.srcs/sources_1/bd/$bdname/hdl/$wrapperName.v 
add_files -norecurse [glob -nocomplain $projpath/$projName.gen/sources_1/bd/$bdname/hdl/*.v]

puts $bdname
append bdWrapperName $bdname "_wrapper"
puts $bdWrapperName
set_property top $bdWrapperName [current_fileset]

# add_files -fileset sources_1  -copy_to $projpath/$projName.srcs/sources_1/new -force -quiet [glob -nocomplain $src_dir/hdl/*.v]
# update_compile_order -fileset sources_1
# set_property top top [current_fileset]
# update_compile_order -fileset sources_1
add_files -fileset constrs_1  -copy_to $projpath/$projName.srcs/constrs_1/new -force -quiet [glob -nocomplain $src_dir/constraints/*.xdc]
# add_files -fileset sim_1  -copy_to $projpath/$projName.srcs/sim_1/new -force -quiet [glob -nocomplain $src_dir/simulation/*.sv]

# launch_runs impl_1 -to_step write_bitstream -jobs $runs_jobs
# wait_on_run impl_1 

# write_hw_platform -fixed -force -include_bit -file $projpath/$bdWrapperName.xsa

# close_project

