第三章 PL通过NoC读写DDR4实验
=============================

**实验VIvado工程为“pl_rw_ddr”。**

3.1 硬件介绍
--------------

开发板的PL端有4颗16bit ddr4

.. image:: images/media/image87.png

3.2 Vivado工程建立
--------------------

Versal的DDR4是通过NoC访问，因此需要添加NoC IP进行配置。

3.2.1 创建一个Block design并配置NoC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1)  选择Create Block Design

    .. image:: images/media/image54.png
        
    .. image:: images/media/image88.png
        
2)  添加CIPS

    .. image:: images/media/image56.png
        
    .. image:: images/media/image57.png
        
3)  双击CIPS，选择PL_Subsystem，只有PL端的逻辑

    .. image:: images/media/image58.png
        
4)  添加NoC IP

    .. image:: images/media/image89.png
        
5)  配置NoC

    选择一个AXI Slave和AXI Clock，选择”Single Memory Controller”

    .. image:: images/media/image90.png
        
    选择Inputs为PL

    .. image:: images/media/image91.png
        
    连接port

    .. image:: images/media/image92.png
        
    DDR4配置

    .. image:: images/media/image93.png
        
    .. image:: images/media/image94.png
        
    配置完成，点击OK

6)  配置CIPS，添加复位

    .. image:: images/media/image95.png
        
    .. image:: images/media/image96.png
        
    .. image:: images/media/image97.png
        
    .. image:: images/media/image98.png
        
    点击Finish

7)  添加Clocking Wizard，配置输出时钟150MHz，作为PL端读写时钟

    .. image:: images/media/image99.png
        
    .. image:: images/media/image100.png
        
8)  添加IBUFDS为NoC和Clocking
    Wizard提供参考时钟，并导出S00_AXI，CH0_DDR4_0等总线，添加axi_clk,axi_resetn为PL端提供时钟和复位。

    .. image:: images/media/image101.png
        
    双击参考时钟引脚，并配置频率为200MHz

    .. image:: images/media/image102.png
        
    双击AXI总线，并配置

    .. image:: images/media/image103.png
        
    .. image:: images/media/image104.png
        
9)  分配地址

    .. image:: images/media/image105.png
        
    .. image:: images/media/image106.png
        
10) Create HDL

    .. image:: images/media/image107.png
        
3.2.2 添加其他测试代码
~~~~~~~~~~~~~~~~~~~~~~~~~

其他代码主要功能是读写ddr4并比较数据是否一致，这里不做详细介绍，可参考工程代码。

.. image:: images/media/image108.png

1) 在mem_test.v中添加mark_debug调试

.. image:: images/media/image109.png

2) 引脚绑定

   .. image:: images/media/image110.png
      
3) 综合

   .. image:: images/media/image111.png
      
3. 综合完成后点击Set up debug

   .. image:: images/media/image112.png
      
   .. image:: images/media/image113.png
      
   .. image:: images/media/image114.png
      
   根据需求设置采样点数

   .. image:: images/media/image115.png
      
   .. image:: images/media/image116.png
      
   之后保存，并生成pdi文件

   .. image:: images/media/image51.png
      
3.3 下载调试
--------------

生成pdi文件以后，使用JTAG下载到开发板，在MIG_1窗口会显示DDR4校准等信息

.. image:: images/media/image117.png

在hw_ila_1中可以查看调试信号

.. image:: images/media/image118.png


3.4 实验总结
--------------

本实验通过PL端Verilog代码直接读写ddr4，主要了解NoC的配置方法，如何通过NoC访问DDR4，后续的实验中都要用到此配置。
