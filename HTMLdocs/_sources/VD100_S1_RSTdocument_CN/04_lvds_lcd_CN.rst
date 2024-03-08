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

AN7000 LCD屏正面图

4.2 程序设计
-------------

1) 与PL的“Hello World” LED实验一样，添加一个block
   design，并添加CIPS核，配置成PL Subsystem

   .. image:: images/media/image120.png
      
2. 添加LVDS LCD的控制器IP

   .. image:: images/media/image121.png
      
3. 添加Advanced IO Wizard，并配置

   .. image:: images/media/image122.png
      
   .. image:: images/media/image123.png
      
   .. image:: images/media/image124.png
      
4. 连接如下

   .. image:: images/media/image125.png
      
5. 添加color bar文件，并拖到block design中，并连接

   .. image:: images/media/image126.png
      
   在video_define.v中定义VIDEO_1280_720，因为LCD分辨率是1280*720

   .. image:: images/media/image127.png
      
6. 生成HDL文件

   .. image:: images/media/image128.png
      
7. 添加其他一些信号

   .. image:: images/media/image129.png
      
8. 约束引脚

   .. image:: images/media/image130.png
      
9. 生成pdi文件

   .. image:: images/media/image51.png
      
4.3 实验现象
--------------

连接好LCD屏，下载程序，即可看到彩条显示。

.. image:: images/media/image131.png

.. image:: images/media/image132.png
