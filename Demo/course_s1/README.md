# Course s1 introduction
The course_s1 provides scripts for pure FPGA and bare-metal projects to quickly restore the project.
## Create Vivado Project
There are two methods to create vivado project as below:
### Create Vivado Project in Vivado tcl console
1. Open Vivado software and switch to "**auto_create_project**" path with **cd** command and **Enter**
```
cd \<archive extracted location\>/course_s1/01_led/vivado/auto_create_project
```
2. Type **source ./create_project.tcl** and **Enter**
```
source ./create_project.tcl
```

### Create Vivado Project using bat
1. In "**auto_create_project**" folder, there is "**create_project.bat**", open it in edit mode, and change to your own vivado software installation path. Save and close.
```
CALL E:\Xilinx\Vivado\2023.2\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. Double click bat file in Windows environment

## Create Vitis Project
Here's how to create a Vitis project:
1. Open the Vitis software by either clicking on Tools --> Launch Vitis IDE in Vivado, or by double-clicking the Vitis icon.
2. In the Vitis software, click on the menu bar Terminal --> New Terminal.
3. In the Terminal, use the cd command to navigate to the directory where builder.py is located.
```
cd \<archive extracted location\>/course_s1/05_ps_hello/vitis
```
4. In the Terminal, type vitis -i to enter the Vitis CLI mode.
```
vitis -i
```
5. Enter the command to run the Python script.
```
run -t builder.py
```
6. Wait for the Vitis project creation to finish, and then you can click on Open Workspace to enter the project.

For more information, please post on the [ALINX Website] (https://www.alinx.com/en).