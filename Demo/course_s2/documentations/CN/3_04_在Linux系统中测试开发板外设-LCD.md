# LCD
VD100开发板上的LCD接口在下图中标记的位置：
![](../images/37.png) \
接上屏幕后如下图:
![](../images/38.png) 

---
在我们提供的Linux系统中，添加了显示相关的[驱动程序](../../petalinux/project-spec/meta-user/recipes-modules/axlcd)和设备树([system-user.dtsi](../../petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi):L19~54)(驱动程序和设备树都与vivado工程中的配置有关，需要结合使用)，也在根文件系统中配置了X11和MatchBox简易桌面。\
使用我们提供的Linux系统启动开发板即可点亮LCD屏幕并且显示MatchBox桌面。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ![](../images/39.png) 

---
---
- 访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。
