第三章 PL通过NoC读写DDR4实验
=============================

**实验VIvado工程为“pl_rw_ddr”。**

3.1 硬件介绍
--------------

开发板的PL端有4颗16bit ddr4

.. image:: images/media/image87.png
   :width: 4.39028in
   :height: 2.6in

3.2 Vivado工程建立
--------------------

Versal的DDR4是通过NoC访问，因此需要添加NoC IP进行配置。

3.2.1 创建一个Block design并配置NoC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1)  选择Create Block Design

    .. image:: images/media/image54.png
       :width: 2.26458in
       :height: 2.29792in

    .. image:: images/media/image88.png
       :width: 3.01319in
       :height: 1.87153in

2)  添加CIPS

    .. image:: images/media/image56.png
       :width: 5.19167in
       :height: 2.67778in

    .. image:: images/media/image57.png
       :width: 2.63333in
       :height: 2.09792in

3)  双击CIPS，选择PL_Subsystem，只有PL端的逻辑

    .. image:: images/media/image58.png
       :width: 4.18542in
       :height: 3.7875in

4)  添加NoC IP

    .. image:: images/media/image89.png
       :width: 2.42222in
       :height: 2.80486in

5)  配置NoC

    选择一个AXI Slave和AXI Clock，选择”Single Memory Controller”

    .. image:: images/media/image90.png
       :width: 5.60972in
       :height: 3.17778in

    选择Inputs为PL

    .. image:: images/media/image91.png
       :width: 6in
       :height: 1.225in

    连接port

    .. image:: images/media/image92.png
       :width: 6.01389in
       :height: 1.39028in

    DDR4配置

    .. image:: images/media/image93.png
       :width: 5.39792in
       :height: 3.20069in

    .. image:: images/media/image94.png
       :width: 5.99583in
       :height: 2.42569in

    配置完成，点击OK

6)  配置CIPS，添加复位

    .. image:: images/media/image95.png
       :width: 1.79444in
       :height: 0.89931in

    .. image:: images/media/image96.png
       :width: 3.64028in
       :height: 3.11458in

    .. image:: images/media/image97.png
       :width: 3.52014in
       :height: 3.04236in

    .. image:: images/media/image98.png
       :width: 2.83056in
       :height: 2.25486in

    点击Finish

7)  添加Clocking Wizard，配置输出时钟150MHz，作为PL端读写时钟

    .. image:: images/media/image99.png
       :width: 1.37014in
       :height: 0.62917in

    .. image:: images/media/image100.png
       :width: 5.625in
       :height: 1.73681in

8)  添加IBUFDS为NoC和Clocking
    Wizard提供参考时钟，并导出S00_AXI，CH0_DDR4_0等总线，添加axi_clk,axi_resetn为PL端提供时钟和复位。

    .. image:: images/media/image101.png
       :width: 5.99167in
       :height: 2.18958in

    双击参考时钟引脚，并配置频率为200MHz

    .. image:: images/media/image102.png
       :width: 2.75208in
       :height: 1.58056in

    双击AXI总线，并配置

    .. image:: images/media/image103.png
       :width: 4.45972in
       :height: 3.44375in

    .. image:: images/media/image104.png
       :width: 4.12431in
       :height: 2.81597in

9)  分配地址

    .. image:: images/media/image105.png
       :width: 5.42708in
       :height: 1.325in

    .. image:: images/media/image106.png
       :width: 6.00278in
       :height: 1.41458in

10) Create HDL

    .. image:: images/media/image107.png
       :width: 4.37083in
       :height: 1.55972in

3.2.2 添加其他测试代码
~~~~~~~~~~~~~~~~~~~~~~~~~

其他代码主要功能是读写ddr4并比较数据是否一致，这里不做详细介绍，可参考工程代码。

.. image:: images/media/image108.png
   :width: 3.17708in
   :height: 2.13056in

1) 在mem_test.v中添加mark_debug调试

.. image:: images/media/image109.png
   :width: 3.94143in
   :height: 2.8396in

2) 引脚绑定

   .. image:: images/media/image110.png
      :width: 1.65069in
      :height: 1.32917in

3) 综合

   .. image:: images/media/image111.png
      :width: 1.95694in
      :height: 0.85278in

3. 综合完成后点击Set up debug

   .. image:: images/media/image112.png
      :width: 1.72292in
      :height: 2.53125in

   .. image:: images/media/image113.png
      :width: 3.80139in
      :height: 2.40208in

   .. image:: images/media/image114.png
      :width: 3.98681in
      :height: 2.53333in

   根据需求设置采样点数

   .. image:: images/media/image115.png
      :width: 4.25069in
      :height: 2.7125in

   .. image:: images/media/image116.png
      :width: 4.31111in
      :height: 2.74792in

   之后保存，并生成pdi文件

   .. image:: images/media/image51.png
      :width: 1.8375in
      :height: 0.75069in

3.3 下载调试
--------------

生成pdi文件以后，使用JTAG下载到开发板，在MIG_1窗口会显示DDR4校准等信息

.. image:: images/media/image117.png
   :width: 6.00278in
   :height: 3.32917in

在hw_ila_1中可以查看调试信号

.. image:: images/media/image118.png
   :width: 6in
   :height: 3.0125in


3.4 实验总结
--------------

本实验通过PL端Verilog代码直接读写ddr4，主要了解NoC的配置方法，如何通过NoC访问DDR4，后续的实验中都要用到此配置。
