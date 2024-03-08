第六章 体验ARM，裸机输出“Hello World”
======================================

**从本章开始由FPGA工程师与软件开发工程师协同实现。**

前面的实验都是在PL端进行的，可以看到和普通FPGA开发流程没有任何区别，ZYNQ的主要优势就是FPGA和ARM的合理结合，这对开发人员提出了更高的要求。从本章开始，我们开始使用ARM，也就是我们说的PS，本章我们使用一个简单的串口打印来体验一下Vivado
Vitis和PS端的特性。

前面的实验都是FPGA工程师应该做的事情，从本章节开始就有了分工，FPGA工程师负责把Vivado工程搭建好，提供好硬件给软件开发人员，软件开发人员便能在这个基础上开发应用程序。做好分工，也有利于项目的推进。如果是软件开发人员想把所有的事情都做了，可能需要花费很多时间和精力去学习FPGA的知识，由软件思维转成硬件思维是个比较痛苦的过程，如果纯粹的学习，又有时间，就另当别论了。专业的人做专业的事，是个很好的选择。


6.1 硬件介绍
--------------

我们从原理图中可以看到Versal芯片分为PL和PS，PS端的IO分配相对是固定的，不能任意分配，而且不需要在Vivado软件里分配管脚，虽然本实验仅仅使用了PS，但是还要建立一个Vivado工程，用来配置PS管脚。虽然PS端的ARM是硬核，但是在Versal当中也要将ARM硬核添加到工程当中才能使用。前面章节介绍的是代码形式的工程，本章开始介绍ZYNQ的图形化方式建立工程。

FPGA工程师工作内容
------------------

下面介绍FPGA工程师负责内容。


6.2 Vivado工程建立
-------------------

1) 创建一个名为“ps_hello”的工程，建立过程不再赘述，参考“PL的”Hello
   World”LED实验”。

2) 点击“Create Block Design”，创建一个Block设计

.. image:: images/media/image54.png
   :width: 2.26458in
   :height: 2.29792in

3) “Design
   name”这里不做修改，保持默认“design_1”，这里可以根据需要修改，不过名字要尽量简短，否则在Windows下编译会有问题。

.. image:: images/media/image88.png
   :width: 3.01319in
   :height: 1.87153in

4) 点击“Add IP”快捷图标

.. image:: images/media/image56.png
   :width: 5.19167in
   :height: 2.67778in

5) 搜索“PS”，在搜索结果列表中双击”Control,Interfaces & Processing
   System”

.. image:: images/media/image57.png
   :width: 2.63333in
   :height: 2.09792in

6) 点击Run Block Automation

.. image:: images/media/image158.png
   :width: 5.25069in
   :height: 1.81389in

7)  配置如下，点击OK

    .. image:: images/media/image159.png
       :width: 4.79514in
       :height: 3.08958in

8)  自动连接如下

    .. image:: images/media/image160.png
       :width: 5.60139in
       :height: 2.27986in

9)  双击CIPS进行配置

    .. image:: images/media/image161.png
       :width: 4.58958in
       :height: 3.92361in

    .. image:: images/media/image162.png
       :width: 4.28125in
       :height: 3.73403in

    点击PSPMC进行配置

    .. image:: images/media/image163.png
       :width: 3.59444in
       :height: 0.93611in

10) 配置QSPI，EMMC，SD

    .. image:: images/media/image164.png
       :width: 5.21736in
       :height: 2.54306in

    .. image:: images/media/image165.png
       :width: 5.25in
       :height: 2.70556in

    .. image:: images/media/image166.png
       :width: 5.09861in
       :height: 2.69375in

    选择相应MIO

    .. image:: images/media/image167.png
       :width: 3.26667in
       :height: 2.32778in

11) 勾选USB 2.0，GEM0，UART0，TTC，GPIO等外设

    .. image:: images/media/image168.png
       :width: 5.39375in
       :height: 2.91806in

    配置外设

    .. image:: images/media/image169.png
       :width: 5.53472in
       :height: 3.48264in

12) 将MIO24配置成GPIO输入，对应PS端按键，MIO25配置成GPIO输出，对应PS端LED灯

    .. image:: images/media/image170.png
       :width: 4.39028in
       :height: 3.78889in

    .. image:: images/media/image171.png
       :width: 4.35347in
       :height: 3.87986in

13) 在clocking中，将参考时钟设置更精确些

    .. image:: images/media/image172.png
       :width: 4.75972in
       :height: 1.51597in

14) 将内部中断都勾选上，配置完成，点击OK

    .. image:: images/media/image173.png
       :width: 5.99236in
       :height: 2.18958in

15) 点击Finish

    .. image:: images/media/image174.png
       :width: 4.53958in
       :height: 3.93125in

16) 双击AXI NoC配置DDR4

    .. image:: images/media/image175.png
       :width: 1.77847in
       :height: 1.86667in

    .. image:: images/media/image176.png
       :width: 6.00208in
       :height: 3.89514in

    .. image:: images/media/image177.png
       :width: 6.00208in
       :height: 2.32847in

    选择参考时钟和system clock

    .. image:: images/media/image178.png
       :width: 5.21944in
       :height: 2.06736in

    DDR Address Region 1选择NONE，点击OK

    .. image:: images/media/image179.png
       :width: 5.99375in
       :height: 3.34444in

17) 修改引脚名称

    .. image:: images/media/image180.png
       :width: 5.99306in
       :height: 1.90556in

    双击配置sys_clk的频率为200MHz

    .. image:: images/media/image181.png
       :width: 3.59375in
       :height: 2.04861in

18) 选择Block设计，右键“Create HDL
    Wrapper...”,创建一个Verilog或VHDL文件，为block
    design生成HDL顶层文件。

.. image:: images/media/image182.png
   :width: 4.225in
   :height: 2.38819in

19) 保持默认选项，点击“OK”

.. image:: images/media/image183.png
   :width: 3.14452in
   :height: 1.81793in

20) 添加约束

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

22) 完成后取消

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

此时在工程目录下可以看到xsa文件，这个文件就包含了Vivado硬件设计的信息，可交由软件开发人员使用。

.. image:: images/media/image194.png
   :width: 2.01473in
   :height: 1.46875in

到此为止，FPGA工程师工作告一段落。

软件工程师工作内容
------------------

**Vitis工程目录为“ps_hello/vitis”**

以下为软件工程师负责内容。

6.3 Vitis调试
---------------

6.3.1 创建Application工程
~~~~~~~~~~~~~~~~~~~~~~~~~~

1) 新建一个文件夹，将vivado导出的xx.xsa文件拷贝进来。

2) Vitis是独立的软件，可以双击Vitis软件打开，也可以通过在Vivado软件中选择ToolsLaunch
   Vitis打开Vitis软件

.. image:: images/media/image9.png
   :width: 3.18611in
   :height: 2.00833in

在欢迎界面，点击Open Workspace，选择之前新建的文件夹，点击”OK”

.. image:: images/media/image195.png
   :width: 5.99931in
   :height: 2.57431in

3) 启动Vitis之后界面如下，点击“Create Platform
   Component”，这个选项会创建Platfrom工程，Platform工程类似于以前版本的hardware
   platform，包含了硬件支持的相关文件以及BSP。

.. image:: images/media/image196.png
   :width: 5.97778in
   :height: 2.38958in

4) 第一页填写Component name和路径，保持默认，点击Next

.. image:: images/media/image197.png
   :width: 5.98889in
   :height: 4.01319in

5) 选择(XSA，选择“Browse”，选择之前生成的xsa，点击打开，之后点击Next

.. image:: images/media/image198.png
   :width: 5.99306in
   :height: 3.99583in

6) 选择操作系统和处理器，这里保持默认

.. image:: images/media/image199.png
   :width: 5.99167in
   :height: 4.00556in

7)  点击Finish完成

    .. image:: images/media/image200.png
       :width: 5.99722in
       :height: 3.98403in

8)  生成之后出现窗口界面，以下是一些窗口介绍，与之前版本的Vitis界面有相似之处，但差别也比较大。

    .. image:: images/media/image201.png
       :width: 5.98611in
       :height: 3.26875in

9)  可以在Flow窗口编译平台

    .. image:: images/media/image202.png
       :width: 2.13472in
       :height: 0.70208in

    没有错误状态

    .. image:: images/media/image203.png
       :width: 2.13333in
       :height: 0.58333in

10) 点击左侧Example，这里面有很多官方的例程，与以前版本也比较类似，选择Hello
    World

    .. image:: images/media/image204.png
       :width: 1.89167in
       :height: 4.90069in

11) 点击创建工程

    .. image:: images/media/image205.png
       :width: 4.87361in
       :height: 2.50347in

12) 填写工程名称和路径，保持默认

    .. image:: images/media/image206.png
       :width: 4.04653in
       :height: 2.71181in

13) 选中平台

    .. image:: images/media/image207.png
       :width: 3.95486in
       :height: 2.64167in

14) 点击Next

    .. image:: images/media/image208.png
       :width: 3.99306in
       :height: 2.69167in

15) 完成

    .. image:: images/media/image209.png
       :width: 3.96111in
       :height: 2.65208in

16) 选中hello_world，点击Build

    .. image:: images/media/image210.png
       :width: 2.88194in
       :height: 3.22778in


6.3.2 下载调试
~~~~~~~~~~~~~~~~

1) 连接JTAG线到开发板、UART的USB线到PC

   .. image:: images/media/image211.png
      :width: 4.27986in
      :height: 2.48125in

2) 在上电之前最好将开发板的启动模式设置到JTAG模式，拔到”ON”的位置

.. image:: images/media/image82.png
   :width: 4.09375in
   :height: 2.23403in

3) 开发板上电，并且打开串口调试工具，点击Flow中的Run

   .. image:: images/media/image212.png
      :width: 2.37153in
      :height: 1.08958in

4) 这个时候观察串口调试工具，即可以看到输出”Hello World”

.. image:: images/media/image213.png
   :width: 2.51458in
   :height: 2.28125in

6.4 固化程序
--------------

普通的FPGA一般是可以从flash启动，或者被动加载，在第一章的PMC架构中已经介绍启动过程，这里不再介绍。

在Flow中选择Creat Boot
Image，弹出的窗口中可以看到生成的BIF文件路径，BIF文件是生成BOOT文件的配置文件，还有生成的Output
Image文件路径，也就是生成BOOT.pdi文件，它是我们需要的启动文件，可以放到SD卡启动，也可以烧写到QSPI
Flash。

.. image:: images/media/image214.png
   :width: 2.99306in
   :height: 1.34792in

.. image:: images/media/image215.png
   :width: 3.94653in
   :height: 4.93542in

在生成的目录下可以找到boot.pdi文件

.. image:: images/media/image216.png
   :width: 6.18611in
   :height: 0.72153in

6.4.1 SD卡启动测试
~~~~~~~~~~~~~~~~~~~

1) 格式化SD卡，只能格式化为FAT32格式，其他格式无法启动

.. image:: images/media/image217.png
   :width: 1.62959in
   :height: 2.62898in

2) 放入boot.pdi文件，放在根目录

.. image:: images/media/image218.png
   :width: 2.32817in
   :height: 1.3048in

3) SD卡插入开发板的SD卡插槽

4) 启动模式调整为SD卡启动

.. image:: images/media/image219.png
   :width: 4.09653in
   :height: 2.91389in

5) 打开串口软件，上电启动，即可看到打印信息，红色框为FSBL启动信息，黄色箭头部分为执行的应用程序helloworld

.. image:: images/media/image220.png
   :width: 3.40694in
   :height: 2.99861in

6.4.2 QSPI启动测试
~~~~~~~~~~~~~~~~~~~

1) 在Vitis菜单Vitis -> Program Flash

.. image:: images/media/image221.png
   :width: 2.77778in
   :height: 1.95347in

2) Image FIle文件选择要烧写的boot.pdi。选择Verify after flash，Flash
   Type选择qspi-x8-dual_parallel，在烧写完成后校验flash。

.. image:: images/media/image222.png
   :width: 4.70417in
   :height: 2.5in

3) 点击Program等待烧写完成

.. image:: images/media/image223.png
   :width: 3.61806in
   :height: 2.42986in

4) 设置启动模式为QSPI，再次启动，可以在串口软件里看到与SD同样的启动效果。

.. image:: images/media/image224.png
   :width: 3.06458in
   :height: 2.31667in

.. image:: images/media/image225.png
   :width: 3.58403in
   :height: 3.25347in

6.5 本章小结
---------------

本章从FPGA工程师和软件工程师两者角度出发，介绍了Versal开发的经典流程，FPGA工程师的主要工作是搭建好硬件平台，提供硬件描述文件xsa给软件工程师，软件工程师在此基础上开发应用程序。本章是一个简单的例子介绍了FPGA和软件工程师协同工作，后续还会牵涉到PS与PL之间的联合调试，较为复杂，也是Versal开发的核心部分。

同时也介绍了FSBL，启动文件的制作，SD卡启动方式，QSPI下载及启动方式。

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
   :width: 1.42708in
   :height: 2.45903in

2) 找到要修改的文件目录“lwip213_v1_1\\src\\contrib\\ports\\xilinx\\netif”中文件“xaxiemacif_physpeed.c”和“xemacpsif_physpeed.c”要修改。

.. image:: images/media/image227.png
   :width: 4.20694in
   :height: 2.40833in

主要添加了get_phy_speed_ksz9031，get_phy_speed_JL2121，以支持ksz9031和JL2121自协商获取速度。在资料中提供了修改好的lwip库，可直接替换。

.. image:: images/media/image228.png
   :width: 1.24028in
   :height: 0.19097in

7.1.2 创建APP工程时基于LWIP模板
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. BSP中添加lwip213库

   .. image:: images/media/image229.png
      :width: 5.22569in
      :height: 3.67986in

2. 配置dhcp功能为True

   .. image:: images/media/image230.png
      :width: 4.66528in
      :height: 3.54236in

   Build platform

   .. image:: images/media/image231.png
      :width: 3.29861in
      :height: 0.97153in

3. 选择lwIP Echo Server模板

   .. image:: images/media/image232.png
      :width: 4.29028in
      :height: 3.56597in

4. 生成模板

   .. image:: images/media/image233.png
      :width: 4.99444in
      :height: 2.95764in

   过程不再赘述，可参考体验ARM，裸机输出”Hello World“一章之6.3.1

5. Build

   .. image:: images/media/image234.png
      :width: 3.12569in
      :height: 1.42014in


7.2 下载调试
-------------

测试环境要求有一台支持dhcp的路由器，开发板连接路由器可以自动获取IP地址，实验主机和开发板在一个网络，可以相互通信。

7.2.1 以太网测试
~~~~~~~~~~~~~~~~~

1) 连接串口打开串口调试终端，连接好PS端以太网网线到路由器，运行Vitis下载程序

.. image:: images/media/image235.png
   :width: 3.66319in
   :height: 2.08403in

.. image:: images/media/image236.png
   :width: 3.39028in
   :height: 1.48194in

2) 可以看到串口打印出一些信息，可以看到自动获取到地址为“192.168.1.63”，连接速度1000Mbps，tcp端口为7

.. image:: images/media/image237.png
   :width: 4.6125in
   :height: 3.15556in

3) 使用telnet连接

.. image:: images/media/image238.png
   :width: 2.92292in
   :height: 2.83194in

4) 当输入一个字符时，开发板返回相同字符

.. image:: images/media/image239.png
   :width: 3.92222in
   :height: 2.45764in


7.3 实验总结
----------------

通过实验我们更加深刻了解到Vitis程序的开发，本实验只是简单的讲解如何创建一个LWIP应用，LWIP可以完成UDP、TCP等协议，在后续的教程中我们会提供基于以太网的具体应用，例如摄像头数据通过以太网发送上位机显示。
