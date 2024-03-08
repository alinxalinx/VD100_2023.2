# ETH
VD100开发板的ETH RJ45接口在下图中标出的位置:
![](../images/44.png) \
在我们提供的petalinux工程中，两个网口都已经配置好了。如下图，将ETH1和ETH2都接到局域网后，eth0和eth1都通过dhcp分配到了IP(eth2是USB HUB上带的网口，忽略即可)。\
![](../images/45.png) \
其中ETH2(开发板上的ETH2，系统中的eth1)稍有特殊，ETH2接在PL端的EMIO上，需要调整PHY的延时(需要调整延时的原因请参考PHY芯片厂家给出的[说明](../datasheet/JL2x01_1000M_RGMII_Delay_Timing_Application_Note.pdf))。首先要修改设备树([system-user.dtsi](../../petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi):L56~71)，然后在系统中添加一个应用程序[mdiorw](../../petalinux/project-spec/meta-user/recipes-apps/mdiorw)用来控制mdio读写。这些都准备好之后我们需要添加一个[自启动服务](../../petalinux/project-spec/meta-user/recipes-core/base-files)(PS:如果你也有开机自启动程序的需求，也可以参考这个路径中的文件)，让系统启动后就配置ETH2的PHY芯片的延时。

---
---
- 访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。
