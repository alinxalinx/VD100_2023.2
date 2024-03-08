第七章 PS端以太网使用之lwip
=============================

**vivado工程目录为“ps_hello/vivado”**


软件工程师工作内容
------------------

以下为软件工程师负责内容。

开发板有两路千兆以太网，通过RGMII接口连接，本实验演示如何使用Vitis自带的LWIP模板进行PS端千兆以太网TCP通信。

LWIP虽然是轻量级协议栈，但如果从来没有使用过，使用起来会有一定的困难，建议先熟悉LWIP的相关知识。

7.1 Vitis程序开发
-------------------

7.1.1 LWIP库修改
~~~~~~~~~~~~~~~~~

由于自带的LWIP库只能识别部分phy芯片，如果开发板所用的phy芯片不在默认支持范围内，要修改库文件。也可以直接使用修改过的库替换原有的库。

1) 找到库文件目录“x:\\Xilinx2023.2\\Vitis\\2023.2\\data\\embeddedsw\\ThirdParty\\sw_services”

.. image:: images/media/image226.png

2) 找到要修改的文件目录“lwip213_v1_1\\src\\contrib\\ports\\xilinx\\netif”中文件“xaxiemacif_physpeed.c”和“xemacpsif_physpeed.c”要修改。

.. image:: images/media/image227.png

主要添加了get_phy_speed_ksz9031，get_phy_speed_JL2121，以支持ksz9031和JL2121自协商获取速度。在资料中提供了修改好的lwip库，可直接替换。

.. image:: images/media/image228.png

7.1.2 创建APP工程时基于LWIP模板
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. BSP中添加lwip213库

   .. image:: images/media/image229.png
      
2. 配置dhcp功能为True

   .. image:: images/media/image230.png
      
   Build platform

   .. image:: images/media/image231.png
      
3. 选择lwIP Echo Server模板

   .. image:: images/media/image232.png
      
4. 生成模板

   .. image:: images/media/image233.png
      
   过程不再赘述，可参考体验ARM，裸机输出”Hello World“一章之6.3.1

5. Build

   .. image:: images/media/image234.png
      

7.2 下载调试
-------------

测试环境要求有一台支持dhcp的路由器，开发板连接路由器可以自动获取IP地址，实验主机和开发板在一个网络，可以相互通信。

7.2.1 以太网测试
~~~~~~~~~~~~~~~~~

1) 连接串口打开串口调试终端，连接好PS端以太网网线到路由器，运行Vitis下载程序

.. image:: images/media/image235.png

.. image:: images/media/image236.png

2) 可以看到串口打印出一些信息，可以看到自动获取到地址为“192.168.1.63”，连接速度1000Mbps，tcp端口为7

.. image:: images/media/image237.png

3) 使用telnet连接

.. image:: images/media/image238.png

4) 当输入一个字符时，开发板返回相同字符

.. image:: images/media/image239.png


7.3 实验总结
----------------

通过实验我们更加深刻了解到Vitis程序的开发，本实验只是简单的讲解如何创建一个LWIP应用，LWIP可以完成UDP、TCP等协议，在后续的教程中我们会提供基于以太网的具体应用，例如摄像头数据通过以太网发送上位机显示。
