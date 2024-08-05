# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\patri\Desktop\LicentaStagii\6_GPIO\Vitis\Licenta_Design_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\patri\Desktop\LicentaStagii\6_GPIO\Vitis\Licenta_Design_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {Licenta_Design_wrapper}\
-hw {C:\Users\patri\Desktop\LicentaStagii\6_GPIO\Vivado\Licenta_Design_wrapper.xsa}\
-out {C:/Users/patri/Desktop/LicentaStagii/6_GPIO/Vitis}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {Licenta_Design_wrapper}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate
bsp reload
domain active {zynq_fsbl}
bsp reload
bsp setlib -name lwip220 -ver 1.0
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains zynq_fsbl 
bsp reload
domain active {standalone_ps7_cortexa9_0}
bsp setlib -name lwip220 -ver 1.0
bsp setlib -name libmetal -ver 2.7
bsp setlib -name openamp -ver 1.10
bsp setlib -name xilffs -ver 5.2
bsp setlib -name xilpm -ver 5.2
bsp removelib -name xilpm
bsp setlib -name xilflash -ver 4.11
bsp setlib -name xilpm -ver 5.2
bsp setlib -name xilrsa -ver 1.8
bsp setlib -name xilskey -ver 7.6
bsp setlib -name xiltimer -ver 2.0
bsp write
bsp reload
catch {bsp regenerate}
bsp reload
catch {bsp regenerate}
bsp write
domain active {zynq_fsbl}
bsp write
platform clean
domain active {standalone_ps7_cortexa9_0}
bsp write
catch {bsp regenerate}
bsp removelib -name libmetal
bsp removelib -name lwip220
bsp removelib -name openamp
bsp removelib -name xilffs
bsp removelib -name xilflash
bsp removelib -name xilpm
bsp removelib -name xilrsa
bsp removelib -name xilskey
bsp removelib -name xiltimer
bsp setlib -name lwip220 -ver 1.0
bsp write
bsp reload
catch {bsp regenerate}
platform generate
platform clean
platform generate
platform clean
platform generate
