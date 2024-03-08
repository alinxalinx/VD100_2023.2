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

3) “Design
   name”这里不做修改，保持默认“design_1”，这里可以根据需要修改，不过名字要尽量简短，否则在Windows下编译会有问题。

.. image:: images/media/image88.png

4) 点击“Add IP”快捷图标

.. image:: images/media/image56.png

5) 搜索“PS”，在搜索结果列表中双击”Control,Interfaces & Processing
   System”

.. image:: images/media/image57.png

6) 点击Run Block Automation

.. image:: images/media/image158.png

7)  配置如下，点击OK

    .. image:: images/media/image159.png
        
8)  自动连接如下

    .. image:: images/media/image160.png
        
9)  双击CIPS进行配置

    .. image:: images/media/image161.png
        
    .. image:: images/media/image162.png
        
    点击PSPMC进行配置

    .. image:: images/media/image163.png
        
10) 配置QSPI，EMMC，SD

    .. image:: images/media/image164.png
        
    .. image:: images/media/image165.png
        
    .. image:: images/media/image166.png
        
    选择相应MIO

    .. image:: images/media/image167.png
        
11) 勾选USB 2.0，GEM0，UART0，TTC，GPIO等外设

    .. image:: images/media/image168.png
        
    配置外设

    .. image:: images/media/image169.png
        
12) 将MIO24配置成GPIO输入，对应PS端按键，MIO25配置成GPIO输出，对应PS端LED灯

    .. image:: images/media/image170.png
        
    .. image:: images/media/image171.png
        
13) 在clocking中，将参考时钟设置更精确些

    .. image:: images/media/image172.png
        
14) 将内部中断都勾选上，配置完成，点击OK

    .. image:: images/media/image173.png
        
15) 点击Finish

    .. image:: images/media/image174.png
        
16) 双击AXI NoC配置DDR4

    .. image:: images/media/image175.png
        
    .. image:: images/media/image176.png
        
    .. image:: images/media/image177.png
        
    选择参考时钟和system clock

    .. image:: images/media/image178.png
        
    DDR Address Region 1选择NONE，点击OK

    .. image:: images/media/image179.png
        
17) 修改引脚名称

    .. image:: images/media/image180.png
        
    双击配置sys_clk的频率为200MHz

    .. image:: images/media/image181.png
        
18) 选择Block设计，右键“Create HDL
    Wrapper...”,创建一个Verilog或VHDL文件，为block
    design生成HDL顶层文件。

.. image:: images/media/image182.png

19) 保持默认选项，点击“OK”

.. image:: images/media/image183.png

20) 添加约束

    .. image:: images/media/image184.png
        
    .. image:: images/media/image185.png
        
    .. image:: images/media/image186.png
        
21) Generate Device Image

    .. image:: images/media/image187.png
        
22) 完成后取消

.. image:: images/media/image188.png

23) File->Export->Export Hardware...

.. image:: images/media/image189.png

.. image:: images/media/image190.png

.. image:: images/media/image191.png

.. image:: images/media/image192.png

.. image:: images/media/image193.png

此时在工程目录下可以看到xsa文件，这个文件就包含了Vivado硬件设计的信息，可交由软件开发人员使用。

.. image:: images/media/image194.png

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

在欢迎界面，点击Open Workspace，选择之前新建的文件夹，点击”OK”

.. image:: images/media/image195.png

3) 启动Vitis之后界面如下，点击“Create Platform
   Component”，这个选项会创建Platfrom工程，Platform工程类似于以前版本的hardware
   platform，包含了硬件支持的相关文件以及BSP。

.. image:: images/media/image196.png

4) 第一页填写Component name和路径，保持默认，点击Next

.. image:: images/media/image197.png

5) 选择(XSA，选择“Browse”，选择之前生成的xsa，点击打开，之后点击Next

.. image:: images/media/image198.png

6) 选择操作系统和处理器，这里保持默认

.. image:: images/media/image199.png

7)  点击Finish完成

    .. image:: images/media/image200.png
        
8)  生成之后出现窗口界面，以下是一些窗口介绍，与之前版本的Vitis界面有相似之处，但差别也比较大。

    .. image:: images/media/image201.png
        
9)  可以在Flow窗口编译平台

    .. image:: images/media/image202.png
        
    没有错误状态

    .. image:: images/media/image203.png
        
10) 点击左侧Example，这里面有很多官方的例程，与以前版本也比较类似，选择Hello
    World

    .. image:: images/media/image204.png
        
11) 点击创建工程

    .. image:: images/media/image205.png
        
12) 填写工程名称和路径，保持默认

    .. image:: images/media/image206.png
        
13) 选中平台

    .. image:: images/media/image207.png
        
14) 点击Next

    .. image:: images/media/image208.png
        
15) 完成

    .. image:: images/media/image209.png
        
16) 选中hello_world，点击Build

    .. image:: images/media/image210.png
        

6.3.2 下载调试
~~~~~~~~~~~~~~~~

1) 连接JTAG线到开发板、UART的USB线到PC

   .. image:: images/media/image211.png
      
2) 在上电之前最好将开发板的启动模式设置到JTAG模式，拔到”ON”的位置

.. image:: images/media/image82.png

3) 开发板上电，并且打开串口调试工具，点击Flow中的Run

   .. image:: images/media/image212.png
      
4) 这个时候观察串口调试工具，即可以看到输出”Hello World”

.. image:: images/media/image213.png

6.4 固化程序
--------------

普通的FPGA一般是可以从flash启动，或者被动加载，在第一章的PMC架构中已经介绍启动过程，这里不再介绍。

在Flow中选择Creat Boot
Image，弹出的窗口中可以看到生成的BIF文件路径，BIF文件是生成BOOT文件的配置文件，还有生成的Output
Image文件路径，也就是生成BOOT.pdi文件，它是我们需要的启动文件，可以放到SD卡启动，也可以烧写到QSPI
Flash。

.. image:: images/media/image214.png

.. image:: images/media/image215.png

在生成的目录下可以找到boot.pdi文件

.. image:: images/media/image216.png

6.4.1 SD卡启动测试
~~~~~~~~~~~~~~~~~~~

1) 格式化SD卡，只能格式化为FAT32格式，其他格式无法启动

.. image:: images/media/image217.png

2) 放入boot.pdi文件，放在根目录

.. image:: images/media/image218.png

3) SD卡插入开发板的SD卡插槽

4) 启动模式调整为SD卡启动

.. image:: images/media/image219.png

5) 打开串口软件，上电启动，即可看到打印信息，红色框为FSBL启动信息，黄色箭头部分为执行的应用程序helloworld

.. image:: images/media/image220.png

6.4.2 QSPI启动测试
~~~~~~~~~~~~~~~~~~~

1) 在Vitis菜单Vitis -> Program Flash

.. image:: images/media/image221.png

2) Image FIle文件选择要烧写的boot.pdi。选择Verify after flash，Flash
   Type选择qspi-x8-dual_parallel，在烧写完成后校验flash。

.. image:: images/media/image222.png

3) 点击Program等待烧写完成

.. image:: images/media/image223.png

4) 设置启动模式为QSPI，再次启动，可以在串口软件里看到与SD同样的启动效果。

.. image:: images/media/image224.png

.. image:: images/media/image225.png

6.5 本章小结
---------------

本章从FPGA工程师和软件工程师两者角度出发，介绍了Versal开发的经典流程，FPGA工程师的主要工作是搭建好硬件平台，提供硬件描述文件xsa给软件工程师，软件工程师在此基础上开发应用程序。本章是一个简单的例子介绍了FPGA和软件工程师协同工作，后续还会牵涉到PS与PL之间的联合调试，较为复杂，也是Versal开发的核心部分。

同时也介绍了FSBL，启动文件的制作，SD卡启动方式，QSPI下载及启动方式。

