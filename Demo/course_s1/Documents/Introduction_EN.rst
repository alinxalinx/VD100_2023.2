illustrate
===========

First of all, thank you for purchasing the Versal development board produced by Xinyi Electronic Technology (Shanghai) Co., Ltd.!
Your support and trust in us and our products gives us the confidence and courage to move forward.

This tutorial is part of the FPGA and bare metal tutorial. Through continuous practice, you can master the basic process of FPGA and bare metal development. Although it does not explain many major principles, practice makes perfect. Practice more and gradually master the secrets.


Preparation work and precautions
==================================

Software Environment
------------------------

The software development environment is based on Vivado 2023.2

Hardware environment
-----------------------

+----------------------------------+--------------------------------------------+
| Development board model          | Chip model                                 |
+----------------------------------+--------------------------------------------+
| VD100                            | xcve2302-sfva784-1LP-es                    |
+----------------------------------+--------------------------------------------+

Script to create Vivado project
==================================

There is a script to generate vivado under each project, which is used to rebuild the vivado project. There are two methods to use. One is to use the batch file and right-click to edit create_project.bat

.. image:: images/media/image4.png
  :width: 1.16181in
  :height: 0.24653in

.. image:: images/media/image5.png
  :width: 2.26528in
  :height: 0.91042in

Change the path to the vivado installation path on your computer, save it, and then double-click to generate the vivado project.

.. image:: images/media/image6.png
  :width: 5.09931in
  :height: 0.28889in

The second method is to open the vivado software, first use the cd command to enter the auto_create_project directory, and then run source
./create_project.tcl command.

Script to create Vitis project
================================

Since the Vitis project takes up a lot of space after compilation, in order to save everyone's precious time, we provide the python script of the Vitis project. There is a vitis folder under each project, which contains the hardware description file xx.xsa, and the automatic Script to create project

.. image:: images/media/image7.png
  :width: 2.77083in
  :height: 0.77292in

What you need to do is to right-click on the builder.py file and change the vitis path to the installation path of your computer.

.. image:: images/media/image8.png
  :width: 3.76042in
  :height: 0.47014in

After saving, open the vitis software

.. image:: images/media/image9.png
  :width: 3.18611in
  :height: 2.00833in

Open a new terminal

.. image:: images/media/image10.png
  :width: 3.92222in
  :height: 0.67569in

Use the cd command to enter the vitis project path, and enter vitis -i to enter the vitis CLI.

.. image:: images/media/image11.png
  :width: 4.89236in
  :height: 1.2125in

Type run -t builder.py and press Enter

.. image:: images/media/image12.png
  :width: 4.07917in
  :height: 0.43889in

Creation completed

.. image:: images/media/image13.png
  :width: 4.22778in
  :height: 1.40972in

Click Open Workspace to switch to the vitis working directory

.. image:: images/media/image14.png
  :width: 4.29444in
  :height: 2.11319in

You can see the created project

.. image:: images/media/image15.png
  :width: 3.68264in
  :height: 1.84306in

At this time, the APP project and platform may not be related well, and they need to be related manually. You can compile the platform first.

.. image:: images/media/image16.png
  :width: 3.67222in
  :height: 0.95764in

Select component, click settings, click switch platform

.. image:: images/media/image17.png
  :width: 5.22153in
  :height: 4.05833in

.. image:: images/media/image18.png
  :width: 5.09306in
  :height: 1.38611in

Build the project again and you can use it

.. image:: images/media/image19.png
  :width: 4.05625in
  :height: 1.15278in

Chapter 1 Introduction to Versal
=================================

Versal includes Cortex-A72 processor and Cortex-R5 processor, PL programmable logic part, PMC platform management controller, AI
Engine and other modules are different from the previous ZYNQ
Unlike MPSoC 7000, Versal is interconnected internally through the NoC on-chip network.

.. image:: images/media/image20.png
  :width: 5.83819in
  :height: 5.02917in

Overall block diagram of the Versal chip

PS: Processing System is the part of ARM SoC that has nothing to do with FPGA.

PL: Programmable Logic, which is the FPGA part.

NoC architecture
-----------------

Versal programmable network-on-chip (NoC) is an AXI interconnect network used to share data between programmable logic PL, processor system PS, etc. The previous Versal series used the AXI cross-interconnect module, which is Versal's the difference.

NoC is designed for scalability. It consists of a series of interconnected horizontal (HNoC) and vertical (VNoC) paths supported by a set of customizable hardware implementation components that can be configured in different ways to meet design timing, speed and logic utilization requirements . The following is the structure diagram of the NoC

.. image:: images/media/image21.png
  :width: 5.84931in
  :height: 3.97153in

From the structure diagram of NoC, we can see that it mainly consists of NMU (NoC master units), NSU (NoC slave
units), NPI (NoC programming interface), NPS (NoC packet
switch). The PS side can connect to NMU and then access DDRMC through NPS connection. Similarly, the PL side can also access DDRMC through NMU and NPS. Access each module flexibly through NPS routing.

.. image:: images/media/image22.png
  :width: 5.71319in
  :height: 3.05764in

NMU structure

.. image:: images/media/image23.png
  :width: 6.00069in
  :height: 2.40208in

NSU structure

From the above NMU,
It can be seen from the NSU structure that the interface to the user is still the AXI bus. Inside it, AXI data is packaged or unpacked and connected to the NoC network.

.. image:: images/media/image24.png
  :width: 2.71458in
  :height: 2.71944in

NPS structure

Both NMU and NSU are connected to the NPS, which is equivalent to a router and forwards data to the destination device. It's a full 4x4
switch, each port supports 8 virtual channels in each direction, using credit-based flow control, similar to TCP's sliding window.

NoC is a very important component in the development of Versal. The PS side accesses DDR and the PL side accesses DDR through NoC. Different from Versal, versal does not have a DDR controller on the PS side and all accesses through NoC. Therefore, understanding the NoC structure is It is necessary. For more information, please refer to the official pg313 document.

PMC architecture
------------------

PMC (Platform Management Controller) manages the platform during startup, configuration, and operation. As can be seen from the structure diagram below, PMC consists of ROM
Code Unit, Platform Processing Unit, PMC I/O
It is composed of Peripherals and other units and has rich functions. Here we mainly introduce how PMC bootstraps startup.

.. image:: images/media/image25.png
  :width: 5.84861in
  :height: 6.04444in

PMC structure diagram

.. image:: images/media/image26.png
  :width: 4.77431in
  :height: 3.00417in

The first stage: Pre-Boot

1. PMC detects PMC power supply and POR_B release

2. PMC reads the boot mode pin and stores it in the boot mode register

3. PMC sends reset to RCU (ROM code unit)

.. image:: images/media/image27.png
  :width: 4.62431in
  :height: 3.62917in

The second stage: Boot Setup

4. RCU executes BootROM from RCU ROM

5. BootROM reads the boot mode register and selects the boot device

6. BootROM reads PDI (programmable device image) from the boot device and verifies it

7. BootROM releases the PPU reset, loads the PLM into the PPU RAM and verifies it. After verification, PPU wakes up and PLM
The software starts executing.

8. BootROM enters sleep state

.. image:: images/media/image28.png
  :width: 4.77431in
  :height: 3.27153in

The third stage: Load Platform

9. PPU starts executing PLM from PPU RAM

10. PLM starts to read and run the PDI module

11. PLM uses PDI content to configure other parts of Versal

11a: PLM configures data for the following modules: PMC, PS clocks

(MIO, clocks, resets, etc.) (CDO file)

NoC initialization and NPI module (DDR controller, NoC,

GT, XPIPE, I/Os, clocking and other NPI modules

PLM loads the application ELF of APU and RPU into storage space,

Such as DDR, OCM, TCM, etc.

11b: PL side logic configuration

PL side data (CFI file)

AI Engine configuration (AI Engine CDO)

.. image:: images/media/image28.png
  :width: 4.77431in
  :height: 3.27153in

The fourth stage: Post-Boot

12. PLM continues to operate until the next POR or system reset. And responsible for DFX reconfiguration, power management, subsystemsRestart, error management, security services.

An introduction to the Versal chip development process
--------------------------------------------------------

Since Versal integrates the CPU and FPGA, developers need to design not only ARM operating system applications and device drivers, but also the hardware logic design of the FPGA part. During development, you need to understand the Linux operating system and system architecture, and you also need to build a hardware design platform between FPGA and ARM systems. Therefore, the development of Versal requires collaborative design and development by software personnel and hardware personnel. This is the so-called "software and hardware co-design" in Versal development.

The design and development of the hardware system and software system of the Versal system requires the following development environment and debugging tools:
Xilinx
Vivado. The Vivado design suite implements the design and development of the FPGA part, pin and timing constraints, compilation and simulation, and implements the RTL to bitstream design process.

Xilinx
Vitis is the Xilinx software development kit (SDK). Based on the Vivado hardware system, the system will automatically configure some important parameters, including tool and library paths, compiler options, JTAG and flash memory settings, debugger connection and bare metal board support package (BSP). SDK is also available for all supported Xilinx
The IP hard core provides drivers. Vitis supports collaborative debugging of IP hard core (on FPGA) and processor software. We can use high-level C or C++ language to develop and debug ARM and FPGA systems to test whether the hardware system is working properly. Vitis software also comes with Vivado software and does not need to be installed separately.

The development of Versal is also a hardware-first-software approach. The specific process is as follows:

1) Create a new project on Vivado and add an embedded source file.

2) Add and configure some basic peripherals of PS and PL in Vivado, or need to add customized peripherals.

3) Generate the top-level HDL file in Vivado and add the constraint file. Then compile and generate bitstream file ( XX.pdi).

4) Export the hardware information to the Vitis software development environment. In the Vitis environment, you can write some debugging software to verify the hardware and software, and combine the bitstream files to debug the Versal system alone.

5) Generate u-boot.elf and bootloader images in the VMware virtual machine.

6) Generate a BOOT.pdi file from the bitstream file and u-boot.elf file in Vitis.

7) Generate Ubuntu kernel image file Zimage and Ubuntu root file system in VMware. In addition, you need to write a driver for the FPGA's custom IP.

8) Put the BOOT, kernel, device tree, and root file system files into the SD card, turn on the power of the development board, and the Linux operating system will boot from the SD card.

What skills are required to learn Versal?
-------------------------------------------

Learning Versal is more demanding than learning traditional tool development such as FPGA, MCU, ARM, etc. Learning Versal well is not something that can be accomplished overnight.

software developer
~~~~~~~~~~~~~~~~~~~~~~~~

- Principles of computer composition

- C, C++ language

- Computer operating system

- tcl script

- Good foundation in English reading

logic developer
~~~~~~~~~~~~~~~~~~

- Principles of computer composition

- C language

- Basics of digital circuits
