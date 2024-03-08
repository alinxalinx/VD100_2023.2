快速启动Linux-制作启动开发板linux系统的SD卡
===========================================

1.调整拨码开关
--------------

| 把开发板上的拨码开关调整到从SD卡启动的状态，如下图：
| |IMG_256|
| 拨码开关在开发板的这个位置：
| |IMG_257|

2.设置SD卡分区
--------------

| 接下来需要制作用于启动Linux的SD卡。把SD卡(例如通过读卡器)连接到Ubuntu系统，然后在Ubuntu系统中打开Disks工具：
| |IMG_258|
| 我的SD卡是这里的 **31 GB Drive** 。选则它，可以看到SD卡中有三块区域分别是：
| a. 名为 **BOOT** 的FAT类型的分区
| b. 名为 **ROOTFS** 的Ext4类型的分区
| c. Free Space
| |IMG_259|
| 这就是我们需要的状态，如果你的SD卡也是这样的状态(对分区的大小没有严格要求)，可以直接跳过本节去看 `3.填充SD卡分区`_ 。但是为了演示一个完整的流程，我先把SD恢复成没有分过区的状态，选择对应的分区，点击" **-** "图标可以删除当前分区，最终变成如下图的状态：
| |IMG_260|
| 点击" **+** "图标可以创建新的分区，第一个分区需要是 **FAT** 格式，大小分配2G，名字命名为 **BOOT** ：
| |IMG_261|
| |IMG_262|
| 点击 **Create** 按钮完成分区创建，点击"**▶**"按钮挂载分区：
| |IMG_263|
| 点击 **Free Space** ，用类似的步骤创建第二个分区，格式选 **Ext4** ，大小分配20G(根据你的实际需求和限制调整)，命名为 **ROOTFS** ：
| |IMG_264|
| |IMG_265|
| 最终状态如下图，注意，需要把两个分区都挂载上：
| |IMG_266|

3.填充SD卡分区
--------------

| SD卡分区完成后，把启动系统需要的文件拷贝到对应分区。
| 解压 *course_s2/sdCardSystemFiles/sdCardSystemFiles.zip* 以获得boot.scr 、BOOT.bin 、image.ub、rootfs.tar.gz 等文件。
| 把boot.scr 、BOOT.bin 、image.ub 三个文件拷贝到 **BOOT** 分区：
| |IMG_267|
| 把 rootfs.tar.gz 用root权限解压到 **ROOTFS** 分区，在 **rootfs.tar.gz** 所在路径打开终端，输入下面的命令：
| ``sudo tar zxvf ./rootfs.tar.gz -C /media/alinx/ROOTFS/ && sync``
| |IMG_268|
| |IMG_269|
| 然后从Ubuntu中弹出SD卡。

4.启动Linux
-----------

| 把刚才制作的SD卡插到开发板的SD卡槽中：
| |IMG_270|
| 连接开发板的UART到PC(**PC上需要安装CP210x的驱动**： *course_s2/documentations/drivers/CP210x_Windows_Drivers.zip* )：
| |IMG_271|
| 打开串口工具，选择我们刚才连接的COM口，波特率设置为115200，关闭流控制，点击OK按钮：
| |IMG_272|
| 连接12V电源：
| |IMG_273|
| 可以看到串口工具中输出信息：
| |IMG_274|
| 系统已经成功启动，输入用户名 **petalinux** ，第一次登录系统会提示输入密码并且再次输入以确认。之后登陆就使用第一次登陆输入的密码即可。
| |IMG_275|



.. |IMG_256| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image1.png
.. |IMG_257| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image2.png
.. |IMG_258| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image3.png
.. |IMG_259| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image4.png
.. |IMG_260| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image5.png
.. |IMG_261| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image6.png
.. |IMG_262| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image7.png
.. |IMG_263| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image8.png
.. |IMG_264| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image9.png
.. |IMG_265| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image10.png
.. |IMG_266| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image11.png
.. |IMG_267| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image12.png
.. |IMG_268| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image13.png
.. |IMG_269| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image14.png
.. |IMG_270| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image15.png
.. |IMG_271| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image16.png
.. |IMG_272| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image17.png
.. |IMG_273| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image18.png
.. |IMG_274| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image19.png
.. |IMG_275| image:: images/vertopal_ce3458e5376b4314ab5a7ab398e75772/media/image20.png
