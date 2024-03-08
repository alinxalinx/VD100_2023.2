# VD100 development board
## Introduction
The VD100 development board is based on the Xilinx Versal AI Edge series chip xcve2302 and is designed with a core board and a bottom board. The core board includes xcve2302, DDR4, QSPI FLASH, EMMC. The bottom board includes a variety of peripherals such as Gigabit Ethernet, USB Uart interface, PCIe x4 interface, USB 2.0 interface, MIPI interface, LVDS interface, SFP+fiber interface, CAN interface, etc.
## Main parameters
* xcve2302
* 4GB DDR4
* 8GB EMMC
* 512Mb QSPI FLASH
* 2 Gigabit Ethernet, 1 PS and 1 PL each
* USB Uart debugging interface
* PCIe x4 interface
* Micro SD card holder
* USB 2.0 interface
* 2 MIPI interface
* 1 LVDS LCD interface
* 2 SFP+ fiber optic interface
* 1 CAN/CANFD interface
* 12 pin PMOD expansion port
* 10 pin JTAG interface
* Keys and LEDs

# VD100 document tutorial link
https://vd100-20232-v101.readthedocs.io/zh-cn/en/VD100_S1_RSTdocument_EN/00_aboutALINX_EN.html

 Note: You can switch between Chinese and English languages at the footer at the end of the document

## Operating environment
* Vitis 2023.2.1 [download page](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis.html)
download **AMD Unified Installer for FPGAs & Adaptive SoCs 2023.2 SFD**  and **AMD Unified Installer for FPGAs & Adaptive SoCs 2023.2.1: All OS installer Single-File Download**
* Petalinux 2023.2 [download page](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html)
download **PetaLinux Installer**
* Ubuntu 20.04.6 LTS, For more OS version, please refer to AMD|XILINX document[UG1144(v2023.2)](https://docs.xilinx.com/r/en-US/ug1144-petalinux-tools-reference-guide)。
## Directory structure
    │
    ├──── HTMLdocs  //Development board tutorial documentation html version
    ├──── RSTdocxs  //Development board tutorial documentation rst version
    │	│
    │ 	├── VD100_S1_RSTdocument_CN  //course s1 Tutorial documentation
    │ 	│	
    │ 	└── VD100_S2_RSTdocument_CN  //course s2 tutorial documentation
	│
	├──── Demo  
	│	│
	│ 	├── course_s1  //FPGA and standalone demo
	│ 	│	
	│ 	└── course_s2  //Linux demo
	│
	└──── Hardware    //hardware information
For more information, please visit the [ALINX website](https://www.alinx.com)