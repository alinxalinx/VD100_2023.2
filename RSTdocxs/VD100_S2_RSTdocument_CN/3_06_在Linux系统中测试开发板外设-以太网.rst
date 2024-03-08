第六章 ETH
============

| VD100开发板的ETH RJ45接口在下图中标出的位置:
| |IMG_256|
| 在我们提供的petalinux工程中，两个网口都已经配置好了。如下图，将ETH1和ETH2都接到局域网后，eth0和eth1都通过dhcp分配到了IP(eth2是USB HUB上带的网口，忽略即可)。
| |IMG_257|
| 其中ETH2(开发板上的ETH2，系统中的eth1)稍有特殊，ETH2接在PL端的EMIO上，需要调整PHY的延时(需要调整延时的原因请参考PHY芯片厂家给出的说明： *demo/course_s2/documentations/datasheet/JL2x01_1000M_RGMII_Delay_Timing_Application_Note.pdf* )。
| 首先要修改设备树 *demo/course_s2/petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi - L56~71*，
| 然后在系统中添加一个应用程序 *demo/course_s2/petalinux/project-spec/meta-user/recipes-apps/mdiorw* 用来控制mdio读写。
| 这些都准备好之后我们需要添加一个自启动服务 *demo/course_s2/petalinux/project-spec/meta-user/recipes-core/base-files* (PS:如果你也有开机自启动程序的需求，也可以参考这个路径中的文件)，
| 这样设置之后系统启动后就会配置ETH2的PHY芯片的延时。



.. |IMG_256| image:: images/vertopal_843f0326da2f4d38b5dab3b5cd5b616b/media/image1.png
.. |IMG_257| image:: images/vertopal_843f0326da2f4d38b5dab3b5cd5b616b/media/image2.png
