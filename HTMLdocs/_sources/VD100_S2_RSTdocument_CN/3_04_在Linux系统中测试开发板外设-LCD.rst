第四章 LCD
============

| VD100开发板上的LCD接口在下图中标记的位置： 
| |IMG_256|
| 接上屏幕后如下图: 
| |IMG_257|

| 在我们提供的Linux系统中，添加了显示相关的驱动程序：*demo/course_s2/petalinux/project-spec/meta-user/recipes-modules/axlcd*，
| 以及设备树：*demo/course_s2/petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi - L19~54*，
| (**驱动程序和设备树都与vivado工程中的配置有关，需要结合使用**)在根文件系统中配置了X11和MatchBox简易桌面。
| 使用我们提供的Linux系统启动开发板即可点亮LCD屏幕并且显示MatchBox桌面。 
| |IMG_258|



.. |IMG_256| image:: images/vertopal_82720a85882047ebb9a3e3477c9d34f3/media/image1.png
.. |IMG_257| image:: images/vertopal_82720a85882047ebb9a3e3477c9d34f3/media/image2.jpeg
.. |IMG_258| image:: images/vertopal_82720a85882047ebb9a3e3477c9d34f3/media/image3.png
