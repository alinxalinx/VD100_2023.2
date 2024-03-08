# ETH
The ETH RJ45 interface of the VD100 development board is marked in the following figure:
![](../images/44.png) \
In the petalinux project we provide, both network ports have been configured. As shown in the figure below, after connecting ETH1 and ETH2 to the LAN, both eth0 and eth1 are assigned IPs through dhcp (eth2 is the network port on the USB HUB, just ignore it). \
![](../images/45.png) \
Among them, ETH2 (ETH2 on the development board, eth1 in the system) is slightly special. ETH2 is connected to the EMIO on the PL side, and the delay of the PHY needs to be adjusted (for the reason why the delay needs to be adjusted, please refer to the [Instructions] given by the PHY chip manufacturer) (../datasheet/JL2x01_1000M_RGMII_Delay_Timing_Application_Note.pdf)). First, modify the device tree ([system-user.dtsi](../../petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi):L56~71 ), and then add an application [mdiorw](../../petalinux/project-spec/meta-user/recipes-apps/mdiorw) to the system to control mdio reading and writing. After these are ready, we need to add a [self-starting service](../../petalinux/project-spec/meta-user/recipes-core/base-files) (PS: If you also have a self-starting program at boot requirements, you can also refer to the file in this path) to configure the delay of the ETH2 PHY chip after the system starts.

---
---
- Visit [ALINX official website] (https://www.alinx.com) for more information.