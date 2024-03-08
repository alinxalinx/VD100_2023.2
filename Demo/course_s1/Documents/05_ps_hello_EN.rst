Chapter 6 Experience ARM, bare metal output "Hello World"
===========================================================

**From this chapter onwards, FPGA engineers and software development engineers collaborate to implement it.**

The previous experiments were all conducted on the PL side. It can be seen that there is no difference from the ordinary FPGA development process. The main advantage of ZYNQ is the reasonable combination of FPGA and ARM, which puts forward higher requirements for developers. Starting from this chapter, we start to use ARM, which is what we call PS. In this chapter, we use a simple serial port printing to experience Vivado
Vitis and PS side features.

The previous experiments are all things that FPGA engineers should do. From the beginning of this chapter, there is a division of labor. FPGA engineers are responsible for setting up the Vivado project and providing good hardware to software developers. Software developers can develop applications on this basis. . A good division of labor is also conducive to the advancement of the project. If a software developer wants to do everything, it may take a lot of time and energy to learn FPGA knowledge. Converting from software thinking to hardware thinking is a relatively painful process. If you just want to learn purely and have time, you can That's another matter. Professional people doing professional things is a good choice.

.. _Hardware Introduction-3:

Hardware introduction
----------------------------

We can see from the schematic diagram that the ZYNQ chip is divided into PL and PS. The IO allocation on the PS side is relatively fixed and cannot be allocated arbitrarily, and there is no need to allocate pins in the Vivado software. Although this experiment only used PS, it still To create a Vivado project to configure PS pins. Although the ARM on the PS side is a hard core, in ZYNQ the ARM hard core must be added to the project before it can be used. The previous chapters introduced projects in the form of codes. This chapter begins by introducing ZYNQ's graphical approach to building projects.

FPGA engineer job content
-------------------------------

The following introduces what FPGA engineers are responsible for.

.. _vivado project creation-2:

Vivado project set up
--------------------------

1) Create a project named "ps_hello". The establishment process will not be described in detail. Please refer to "PL's" Hello
World "LED Experiment".

2) Click "Create Block Design" to create a Block design

.. image:: images/media/image54.png
  :width: 2.26458in
  :height: 2.29792in

3) “Design
name" is not modified here, keep the default "design_1", you can modify it as needed, but the name should be as short as possible, otherwise there will be problems compiling under Windows.

.. image:: images/media/image88.png
  :width: 3.01319in
  :height: 1.87153in

4) Click the “Add IP” shortcut icon

.. image:: images/media/image56.png
  :width: 5.19167in
  :height: 2.67778in

5) Search for "PS" and double-click "Control, Interfaces & Processing" in the search results list
System"

.. image:: images/media/image57.png
  :width: 2.63333in
  :height: 2.09792in

6) Click Run Block Automation

.. image:: images/media/image158.png
  :width: 5.25069in
  :height: 1.81389in

7) Configure as follows, click OK

.. image:: images/media/image159.png
  :width: 4.79514in
  :height: 3.08958in

8) Automatic connection is as follows

.. image:: images/media/image160.png
  :width: 5.60139in
  :height: 2.27986in

9) Double-click CIPS to configure

.. image:: images/media/image161.png
  :width: 4.58958in
  :height: 3.92361in

.. image:: images/media/image162.png
  :width: 4.28125in
  :height: 3.73403in

select PS PMC to config

.. image:: images/media/image163.png
  :width: 3.59444in
  :height: 0.93611in

10) Config QSPI，EMMC，SD

.. image:: images/media/image164.png
  :width: 5.21736in
  :height: 2.54306in

.. image:: images/media/image165.png
  :width: 5.25in
  :height: 2.70556in

.. image:: images/media/image166.png
  :width: 5.09861in
  :height: 2.69375in

Select the corresponding MIO

.. image:: images/media/image167.png
  :width: 3.26667in
  :height: 2.32778in

11) Check USB 2.0, GEM0, UART0, TTC, GPIO and other peripherals

.. image:: images/media/image168.png
  :width: 5.39375in
  :height: 2.91806in

Configure peripherals

.. image:: images/media/image169.png
  :width: 5.53472in
  :height: 3.48264in

12) Configure MIO24 as GPIO input, corresponding to the PS side buttons, and configure MIO25 as GPIO output, corresponding to the PS side LED lights

.. image:: images/media/image170.png
  :width: 4.39028in
  :height: 3.78889in

.. image:: images/media/image171.png
  :width: 4.35347in
  :height: 3.87986in

13) In clocking, set the reference clock more accurately

.. image:: images/media/image172.png
  :width: 4.75972in
  :height: 1.51597in

14) Check all internal interrupts, the configuration is complete, and click OK

.. image:: images/media/image173.png
  :width: 5.99236in
  :height: 2.18958in

15) Click Finish

.. image:: images/media/image174.png
  :width: 4.53958in
  :height: 3.93125in

16) Double-click AXI NoC to configure DDR4

.. image:: images/media/image175.png
  :width: 1.77847in
  :height: 1.86667in

.. image:: images/media/image176.png
  :width: 6.00208in
  :height: 3.89514in

.. image:: images/media/image177.png
  :width: 6.00208in
  :height: 2.32847in

select reference clock and system clock

.. image:: images/media/image178.png
  :width: 5.21944in
  :height: 2.06736in

DDR Address Region 1, select NONE and OK

.. image:: images/media/image179.png
  :width: 5.99375in
  :height: 3.34444in

1)  Modify pin name

.. image:: images/media/image180.png
  :width: 5.99306in
  :height: 1.90556in

Double-click to configure the frequency of sys_clk to 200MHz

.. image:: images/media/image181.png
  :width: 3.59375in
  :height: 2.04861in

18) Select the Block design, right-click "Create HDLWrapper...", create a Verilog or VHDL file for blockdesign generates HDL top-level files.

.. image:: images/media/image182.png
  :width: 4.225in
  :height: 2.38819in

19) Keep the default options and click "OK"

.. image:: images/media/image183.png
  :width: 3.14452in
  :height: 1.81793in

20) Add constraint

.. image:: images/media/image184.png
  :width: 5.64444in
  :height: 2.50208in

.. image:: images/media/image185.png
  :width: 2.62708in
  :height: 2.05139in

.. image:: images/media/image186.png
  :width: 5.22708in
  :height: 1.99375in

21) Generate Device Image

.. image:: images/media/image187.png
  :width: 2.31944in
  :height: 0.92569in

22) Cancel after completion

.. image:: images/media/image188.png
  :width: 2.59167in
  :height: 1.77153in

23) File->Export->Export Hardware...

.. image:: images/media/image189.png
  :width: 3.08958in
  :height: 2.575in

.. image:: images/media/image190.png
  :width: 3.82431in
  :height: 3.21875in

.. image:: images/media/image191.png
  :width: 4.03125in
  :height: 3.31806in

.. image:: images/media/image192.png
  :width: 4.10972in
  :height: 3.42708in

.. image:: images/media/image193.png
  :width: 4.21111in
  :height: 3.55833in

At this time, you can see the xsa file in the project directory. This file contains Vivado hardware design information and can be used by software developers.

.. image:: images/media/image194.png
  :width: 2.01473in
  :height: 1.46875in

At this point, the work of the FPGA engineer comes to an end.

Software engineer job content
---------------------------------

**The Vitis project directory is "ps_hello/vitis"**

The following is the responsibility of software engineers.

Debugging
------------

Create Application project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1) Create a new folder and copy the xx.xsa file exported by vivado.

2) Vitis is an independent software. You can double-click the Vitis software to open it, or select ToolsLaunch in the Vivado software.
VitisOpen Vitis software

.. image:: images/media/image9.png
  :width: 3.18611in
  :height: 2.00833in

On the welcome interface, click Open Workspace, select the previously created folder, and click "OK"

.. image:: images/media/image195.png
  :width: 5.99931in
  :height: 2.57431in

3) After starting Vitis, the interface is as follows, click "Create Platform"
Component", this option will create a Platform project, which is similar to previous versions of hardware
platform, including hardware support related files and BSP.

.. image:: images/media/image196.png
  :width: 5.97778in
  :height: 2.38958in

4) Fill in the Component name and path on the first page, keep the default, and click Next

.. image:: images/media/image197.png
  :width: 5.98889in
  :height: 4.01319in

5) Select (XSA, select "Browse", select the previously generated xsa, click to open, and then click Next

.. image:: images/media/image198.png
  :width: 5.99306in
  :height: 3.99583in

6) Select operating system and processor, keep the default here

.. image:: images/media/image199.png
  :width: 5.99167in
  :height: 4.00556in

7) Click Finish to complete

.. image:: images/media/image200.png
  :width: 5.99722in
  :height: 3.98403in

8) After generation, a window interface appears. The following are some window introductions. They are similar to the previous version of Vitis interface, but the differences are also quite large.

.. image:: images/media/image201.png
  :width: 5.98611in
  :height: 3.26875in

9) The platform can be compiled in the Flow window

.. image:: images/media/image202.png
  :width: 2.13472in
  :height: 0.70208in

no error status

.. image:: images/media/image203.png
  :width: 2.13333in
  :height: 0.58333in

10) Click Example on the left. There are many official routines here, which are similar to previous versions. Select Hello.
World

.. image:: images/media/image204.png
  :width: 1.89167in
  :height: 4.90069in

11) Click to create project

.. image:: images/media/image205.png
  :width: 4.87361in
  :height: 2.50347in

12) Fill in the project name and path and keep the default

.. image:: images/media/image206.png
  :width: 4.04653in
  :height: 2.71181in

13) Select the platform

.. image:: images/media/image207.png
  :width: 3.95486in
  :height: 2.64167in

14) Click Next

.. image:: images/media/image208.png
  :width: 3.99306in
  :height: 2.69167in

15) Complete

.. image:: images/media/image209.png
  :width: 3.96111in
  :height: 2.65208in

16) Select hello_world and click Build

.. image:: images/media/image210.png
  :width: 2.88194in
  :height: 3.22778in

.. _Download Debug-2:

Download debugging
~~~~~~~~~~~~~~~~~~~~~~~

1) Connect the JTAG cable to the development board and the UART USB cable to the PC

.. image:: images/media/image211.png
  :width: 4.27986in
  :height: 2.48125in

2) Before powering on, it is best to set the startup mode of the development board to JTAG mode and pull it to the "ON" position.

.. image:: images/media/image82.png
  :width: 4.09375in
  :height: 2.23403in

3) Power on the development board, open the serial port debugging tool, and click Run in Flow

.. image:: images/media/image212.png
  :width: 2.37153in
  :height: 1.08958in

4) At this time, observe the serial port debugging tool and you can see the output "Hello World"

.. image:: images/media/image213.png
  :width: 2.51458in
  :height: 2.28125in

firmware
-----------

Ordinary FPGAs can generally be started from flash or passively loaded. The startup process has been introduced in the PMC architecture in Chapter 1 and will not be introduced here.

Select Create Boot in Flow
Image, you can see the generated BIF file path in the pop-up window. The BIF file is the configuration file for generating the BOOT file, and the generated Output
Image file path, that is, the BOOT.pdi file is generated. It is the startup file we need. It can be placed in the SD card for startup, or it can be programmed to QSPI.
Flash.

.. image:: images/media/image214.png
  :width: 2.99306in
  :height: 1.34792in

.. image:: images/media/image215.png
  :width: 3.94653in
  :height: 4.93542in

The boot.pdi file can be found in the generated directory

.. image:: images/media/image216.png
  :width: 6.18611in
  :height: 0.72153in

SD card boot test
~~~~~~~~~~~~~~~~~~~~~~~

1) Format the SD card. It can only be formatted to FAT32 format. Other formats cannot be started.

.. image:: images/media/image217.png
  :width: 1.62959in
  :height: 2.62898in

2) Put the boot.pdi file into the root directory

.. image:: images/media/image218.png
  :width: 2.32817in
  :height: 1.3048in

3) Insert the SD card into the SD card slot of the development board

4) Adjust the startup mode to SD card startup

.. image:: images/media/image219.png
  :width: 4.09653in
  :height: 2.91389in

5) Open the serial port software, power on and start, you can see the printed information. The red box is the FSBL startup information, and the yellow arrow part is the executed application helloworld.

.. image:: images/media/image220.png
  :width: 3.40694in
  :height: 2.99861in

QSPI startup test
~~~~~~~~~~~~~~~~~~~~~~~

1) In the Vitis menu Vitis -> Program Flash

.. image:: images/media/image221.png
  :width: 2.77778in
  :height: 1.95347in

2) Select the boot.pdi to be burned in the Image FIle file. Select Verify after flash, Flash
Select qspi-x8-dual_parallel for Type, and verify the flash after programming is completed.

.. image:: images/media/image222.png
  :width: 4.70417in
  :height: 2.5in

3) Click Program and wait for programming to complete

.. image:: images/media/image223.png
  :width: 3.61806in
  :height: 2.42986in

4) Set the startup mode to QSPI, start it again, and you can see the same startup effect as SD in the serial port software.

.. image:: images/media/image224.png
  :width: 3.06458in
  :height: 2.31667in

.. image:: images/media/image225.png
  :width: 3.58403in
  :height: 3.25347in

chapter summary
--------------------

This chapter introduces the classic process of Versal development from the perspectives of both FPGA engineers and software engineers. The main job of FPGA engineers is to build a hardware platform and provide hardware description files xsa to software engineers, who then develop applications based on this. This chapter is a simple example that introduces the collaborative work of FPGA and software engineers. It will also involve joint debugging between PS and PL later, which is more complicated and is also the core part of Versal development.

At the same time, FSBL, startup file production, SD card startup method, QSPI download and startup method are also introduced.

Chapter 7 lwip used by PS side Ethernet
=========================================

**The vivado project directory is "ps_hello/vivado"**

.. _Software Engineer Job Content-1:

Software engineer job content
-------------------------------

The following is the responsibility of software engineers.

The development board has two channels of Gigabit Ethernet, connected through the RGMII interface. This experiment demonstrates how to use the LWIP template that comes with Vitis to perform Gigabit Ethernet TCP communication on the PS side.

Although LWIP is a lightweight protocol stack, if you have never used it before, it will be difficult to use it. It is recommended to familiarize yourself with the relevant knowledge of LWIP first.

Vitis program development
----------------------------

LWIP library modification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since the built-in LWIP library can only recognize some phy chips, if the phy chip used by the development board is not within the default support range, the library file must be modified. You can also directly use the modified library to replace the original library.

1) Find the library file directory "x:\\Xilinx2023.2\\Vitis\\2023.2\\data\\embeddedsw\\ThirdParty\\sw_services"

.. image:: images/media/image226.png
  :width: 1.42708in
  :height: 2.45903in

2) Find the files "xaxiemacif_physpeed.c" and "xemacpsif_physpeed.c" in the file directory "lwip213_v1_1\\src\\contrib\\ports\\xilinx\\netif" to be modified.

.. image:: images/media/image227.png
  :width: 4.20694in
  :height: 2.40833in

Mainly added get_phy_speed_ksz9031, get_phy_speed_JL2121 to support ksz9031 and JL2121 auto-negotiation to obtain speed. The modified lwip library is provided in the information and can be directly replaced.

.. image:: images/media/image228.png
  :width: 1.24028in
  :height: 0.19097in

Create an APP project based on the LWIP template
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Add lwip213 library to BSP

.. image:: images/media/image229.png
  :width: 5.22569in
  :height: 3.67986in

2. Configure the dhcp function to True

.. image:: images/media/image230.png
  :width: 4.66528in
  :height: 3.54236in

Build platform

.. image:: images/media/image231.png
  :width: 3.29861in
  :height: 0.97153in

3. Select lwIP Echo Server template

.. image:: images/media/image232.png
  :width: 4.29028in
  :height: 3.56597in

4. Generate template

.. image:: images/media/image233.png
  :width: 4.99444in
  :height: 2.95764in

The process will not be described in detail. You can refer to Chapter 6 of Experience ARM, Bare Metal Output "Hello World"

5.Build

.. image:: images/media/image234.png
  :width: 3.12569in
  :height: 1.42014in

.. _Download Debug-3:

Download debugging
---------------------

The test environment requires a router that supports dhcp. The development board can automatically obtain an IP address when connected to the router. The experimental host and development board are on the same network and can communicate with each other.

Ethernet test
~~~~~~~~~~~~~~~~

1) Connect the serial port and open the serial debugging terminal, connect the PS end Ethernet cable to the router, and run the Vitis download program

.. image:: images/media/image235.png
  :width: 3.66319in
  :height: 2.08403in

.. image:: images/media/image236.png
  :width: 3.39028in
  :height: 1.48194in

2) You can see some information printed out by the serial port. You can see that the address automatically obtained is "192.168.1.63", the connection speed is 1000Mbps, and the tcp port is 7

.. image:: images/media/image237.png
  :width: 4.6125in
  :height: 3.15556in

3) Use telnet to connect

.. image:: images/media/image238.png
  :width: 2.92292in
  :height: 2.83194in

4) When a character is entered, the development board returns the same character

.. image:: images/media/image239.png
  :width: 3.92222in
  :height: 2.45764in

.. _Experiment Summary-2:

Experiment summary
--------------------

Through the experiment, we have a deeper understanding of the development of the Vitis program. This experiment simply explains how to create an LWIP application. LWIP can complete UDP, TCP and other protocols. In subsequent tutorials, we will provide specific applications based on Ethernet, such as cameras. The data is sent to the host computer via Ethernet for display.
