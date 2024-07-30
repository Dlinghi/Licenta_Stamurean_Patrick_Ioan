# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\patri\Desktop\LicentaStagii\1\Vitis\LicentaPlatform\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\patri\Desktop\LicentaStagii\1\Vitis\LicentaPlatform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {LicentaPlatform}\
-hw {C:\Users\patri\Desktop\LicentaStagii\1\project_1\Licenta_Design_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {C:/Users/patri/Desktop/LicentaStagii/1/Vitis}

platform write
platform generate -domains 
platform active {LicentaPlatform}
platform generate
bsp reload
bsp setlib -name lwip220 -ver 1.0
bsp write
bsp reload
catch {bsp regenerate}
platform clean
platform generate
bsp config phy_link_speed "CONFIG_LINKSPEED1000"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_domain 
platform clean
platform generate
domain active {zynq_fsbl}
bsp reload
platform active {LicentaPlatform}
platform generate -domains 
platform generate -domains 
