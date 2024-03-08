第二章 LEDS、KEYS
==================

VD100开发板上的LED和KEY
-----------------------

| 开发板上有两组可控制的LED和KEY。在如下图标出的位置:
| |IMG_256|

在Linux中使用LED和KEY
---------------------

| 使用LED和KEY实际上就是配置和使用GPIO，在Linux中只需要知道GPIO号就可以使用对应的IO口。GPIO号需要结合原理图来看，以PS_LED为例，原理图中连接的是Versal芯片上的LPD_MIO25引脚:
| |IMG_257|
| 在开发板系统中输入命令 ``ls /sys/class/gpio/gpiochip`` ，我们看到的这些 gpiochip 后面最小的值450就是LPD_MIO组IO的起始编号 
| |IMG_258|
| PS_LED对应IO的编号就是 450+25 也就是475。
| 在我们的提供的开发板系统中，PS_LED的GPIO号为475，PS_KEY的GPIO号为474。
| LED对应的IO需要配置成输出，配置和使用的步骤如下：

| ``#导出对应的端口``
| ``sudo echo 475 >> /sys/class/gpio/export``
| ``#设置这个端口为输出``
| ``sudo echo out >> /sys/class/gpio/gpio475/direction``
| ``#使这个端口输出高电平，点亮LED``
| ``sudo echo 1 >> /sys/class/gpio/gpio475/value``
| ``#使这个端口输出低电平，熄灭LED``
| ``sudo echo 0 >> /sys/class/gpio/gpio475/value``

| KEY对应的IO需要配置成输入，配置和使用的步骤如下：

| ``#导出对应的端口``
| ``sudo echo 474 >> /sys/class/gpio/export``
| ``#设置这个端口为输入``
| ``sudo echo in >> /sys/class/gpio/gpio474/direction``
| ``#读取这个IO当前的电平状态``
| ``cat /sys/class/gpio/gpio474/value``

| 除了这种方式之外，还可以直接读写寄存器来使用GPIO，PL_LED和PL_KEY都是使用 axi-gpio IP实现的，从vivado工程中可以找到他们的寄存器地址分别是PL_LED:0x80040000，PL_KEY:0x80030000。
| 使用命令 ``sudo devmem 0x80030000`` 即可读出PL_KEY的值。
| 使用命令 ``sudo devmem 0x80040000 32 1`` 即可点亮PL_LED；
| 使用命令 ``sudo devmem 0x80040000 32 0`` 即可熄灭PL_LED。

使用系统内置的脚本测试LED和KEY
------------------------------

| 运行 ``sudo ~/test_apps/leds_keys_test.sh`` (ps：按 **ctrl+c** 组合键退出)。然后可以用PS_KEY控制PS_LED点亮和熄灭，PL_KEY控制PS_LED点亮和熄灭。
| |IMG_259|



.. |IMG_256| image:: images/vertopal_c0c9b22143474809806c5e7bca7ff569/media/image1.png
.. |IMG_257| image:: images/vertopal_c0c9b22143474809806c5e7bca7ff569/media/image2.png
.. |IMG_258| image:: images/vertopal_c0c9b22143474809806c5e7bca7ff569/media/image3.png
.. |IMG_259| image:: images/vertopal_c0c9b22143474809806c5e7bca7ff569/media/image4.png
