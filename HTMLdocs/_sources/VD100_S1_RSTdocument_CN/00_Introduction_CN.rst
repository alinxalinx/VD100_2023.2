说明
=====

首先感谢大家购买芯驿电子科技（上海）有限公司出品的Versal的开发板！
您对我们和我们产品的支持和信任,给我们增添了永往直前的信心和勇气。

本教程为FPGA和裸机部分教程，通过不断练习，掌握FPGA和裸机开发的基本流程，虽然没有讲解很多大道理，但是熟能生巧，多多练习，逐渐掌握其中的奥秘。


准备工作及注意事项
==================

软件环境
--------

软件开发环境基于Vivado 2023.2

硬件环境
--------

+---------------------------------+------------------------------------+
| 开发板型号                      | 芯片型号                           |
+---------------------------------+------------------------------------+
| VD100                           | xcve2302-sfva784-1LP-e-s           |
+---------------------------------+------------------------------------+

脚本建立Vivado工程
==================

每个工程下面都有一个生成vivado的脚本，用于重建vivado工程，有两种方法可以使用，一是利用批处理文件，右键编辑create_project.bat

.. image:: images/media/image4.png
   :width: 1.16181in
   :height: 0.24653in

.. image:: images/media/image5.png
   :width: 2.26528in
   :height: 0.91042in

将路径换成自己电脑上的vivado安装路径，保存，然后双击即可生成vivado工程。

.. image:: images/media/image6.png
   :width: 5.09931in
   :height: 0.28889in

第二种方法是打开vivado软件，先用cd命令进入auto_create_project目录，然后运行source
./create_project.tcl命令。

脚本建立Vitis工程
=================

由于Vitis工程编译后占用空间较大，因此为了节省大家宝贵的时间，我们提供了Vitis工程的python脚本，在每个工程下都有个vitis文件夹，里面包含硬件描述文件xx.xsa，以及自动创建工程的脚本

.. image:: images/media/image7.png
   :width: 2.77083in
   :height: 0.77292in

大家需要做的是右键编辑builder.py文件，vitis路径换成自己电脑的安装路径

.. image:: images/media/image8.png
   :width: 3.76042in
   :height: 0.47014in

保存之后，打开vitis软件

.. image:: images/media/image9.png
   :width: 3.18611in
   :height: 2.00833in

打开新的terminal

.. image:: images/media/image10.png
   :width: 3.92222in
   :height: 0.67569in

使用cd命令进入vitis工程路径，并输入vitis -i，进入vitis CLI

.. image:: images/media/image11.png
   :width: 4.89236in
   :height: 1.2125in

输入run -t builder.py，回车

.. image:: images/media/image12.png
   :width: 4.07917in
   :height: 0.43889in

创建完成

.. image:: images/media/image13.png
   :width: 4.22778in
   :height: 1.40972in

点击Open Workspace切换到vitis工作目录

.. image:: images/media/image14.png
   :width: 4.29444in
   :height: 2.11319in

可以看到创建好的工程

.. image:: images/media/image15.png
   :width: 3.68264in
   :height: 1.84306in

这个时候，APP工程和platform可能没有关联好，要手动关联。可以先把platform编译一遍。

.. image:: images/media/image16.png
   :width: 3.67222in
   :height: 0.95764in

选中component，点设置，点击switch platform

.. image:: images/media/image17.png
   :width: 5.22153in
   :height: 4.05833in

.. image:: images/media/image18.png
   :width: 5.09306in
   :height: 1.38611in

再build工程，即可使用

.. image:: images/media/image19.png
   :width: 4.05625in
   :height: 1.15278in

