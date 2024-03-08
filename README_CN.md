# VD100开发板
## 简介
VD100开发板基于Xilinx Versal AI Edge系列芯片xcve2302，采用核心板加底板的方式设计。核心板包含xcve2302,DDR4,QSPI FLASH,EMMC.底板包含千兆以太网，USB Uart接口，PCIe x4接口，USB 2.0接口，MIPI接口，LVDS接口，SFP+光纤接口，CAN接口等丰富外设。
## 主要参数
* xcve2302
* 4GB DDR4
* 8GB EMMC
* 512Mb QSPI FLASH
* 2路千兆以太网，PS,PL各1路
* USB Uart调试接口
* PCIe x4接口
* Micro SD卡座
* USB 2.0接口
* 2路MIPI接口
* 1路LVDS LCD接口
* 2路SFP+光纤接口
* 1路CAN/CANFD接口
* 12针PMOD扩展口
* 10针JTAG接口
* 按键与LED灯

# VD100 文档教程链接
https://vd100-20232-v101.readthedocs.io/zh-cn/latest/VD100_S1_RSTdocument_CN/00_%E5%85%B3%E4%BA%8EALINX_CN.html

 注意：文档的末尾页脚处可以切换中英文语言

## 运行环境
* Vitis 2023.2.1 [下载页面](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis.html)
下载 **AMD Unified Installer for FPGAs & Adaptive SoCs 2023.2 SFD**  和 **AMD Unified Installer for FPGAs & Adaptive SoCs 2023.2.1: All OS installer Single-File Download**
* Petalinux 2023.2 [下载页面](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html)
下载 **PetaLinux Installer**
* Ubuntu 20.04.6 LTS 更多支持的版本请参考 AMD|XILINX 官方文档[UG1144(v2023.2)](https://docs.xilinx.com/r/en-US/ug1144-petalinux-tools-reference-guide)。
## 资料目录结构
   │
   ├──── HTMLdocs  //开发板教程文档html版本
   ├──── RSTdocxs  //开发板教程文档rst版本
   │	│
   │ 	├── VD100_S1_RSTdocument_CN  //course_s1教程文档
   │ 	│	
   │ 	└── VD100_S2_RSTdocument_CN  //course_s2教程文档
   ├──── demo  //开发板例程
   │	│
   │ 	├── course_s1  //纯FPGA和裸机例程
   │ 	│	
   │ 	└── course_s2  //Linux例程
   │
   └──── hardware    //硬件资料
更多信息, 请访问[ALINX网站](https://www.alinx.com)