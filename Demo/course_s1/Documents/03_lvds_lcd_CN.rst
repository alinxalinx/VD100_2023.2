第四章 LVDS液晶屏显示实验
==========================

**实验Vivado工程为“lvds_lcd”。**

本章介绍lvds lcd液晶屏的color bar显示。


4.1 硬件介绍
---------------

ALINX黑金7寸LCD屏模块(AN7000)采用IVO的7寸TFT LCD液晶屏,
液晶屏的型号为M070AWAD R0。AN7000 LCD屏模块由TFT
液晶屏和驱动板组成，具体参数可以参考AN7000的用户手册。AN7000实物照片如下：

.. image:: images/media/image119.png
   :alt: \_K4A5291
   :width: 5.37431in
   :height: 3.34722in

AN7000 LCD屏正面图

4.2 程序设计
-------------

1) 与PL的“Hello World” LED实验一样，添加一个block
   design，并添加CIPS核，配置成PL Subsystem

   .. image:: images/media/image120.png
      :width: 2.17639in
      :height: 1.05556in

2. 添加LVDS LCD的控制器IP

   .. image:: images/media/image121.png
      :width: 1.78542in
      :height: 1.19028in

3. 添加Advanced IO Wizard，并配置

   .. image:: images/media/image122.png
      :width: 4.32222in
      :height: 3.34167in

   .. image:: images/media/image123.png
      :width: 4.3in
      :height: 2.89028in

   .. image:: images/media/image124.png
      :width: 4.62847in
      :height: 2.30694in

4. 连接如下

   .. image:: images/media/image125.png
      :width: 5.68681in
      :height: 2.65486in

5. 添加color bar文件，并拖到block design中，并连接

   .. image:: images/media/image126.png
      :width: 3.91597in
      :height: 1.97222in

   在video_define.v中定义VIDEO_1280_720，因为LCD分辨率是1280*720

   .. image:: images/media/image127.png
      :width: 1.94861in
      :height: 0.59722in

6. 生成HDL文件

   .. image:: images/media/image128.png
      :width: 2.46181in
      :height: 1.31875in

7. 添加其他一些信号

   .. image:: images/media/image129.png
      :width: 5.85069in
      :height: 2.89861in

8. 约束引脚

   .. image:: images/media/image130.png
      :width: 2.33611in
      :height: 1.44097in

9. 生成pdi文件

   .. image:: images/media/image51.png
      :width: 1.8375in
      :height: 0.75069in

4.3 实验现象
--------------

连接好LCD屏，下载程序，即可看到彩条显示。

.. image:: images/media/image131.png
   :width: 3.72014in
   :height: 4.87708in

.. image:: images/media/image132.png
   :width: 5.35347in
   :height: 3.80694in
