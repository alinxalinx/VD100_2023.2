# LCD
The LCD interface on the VD100 development board is at the location marked in the figure below:
![](../images/37.png) \
After connecting the screen, it will look like the picture below:
![](../images/38.png)

---
In the Linux system we provide, the display-related [driver](../../petalinux/project-spec/meta-user/recipes-modules/axlcd) and device tree ([system-user.dtsi ](../../petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi):L19~54) (The driver and device tree are both in the vivado project related to the configuration and need to be used in combination), X11 and MatchBox simple desktop are also configured in the root file system. \
Use the Linux system we provide to start the development board to light up the LCD screen and display the MatchBox desktop. ![](../images/39.png)

---
---
- Visit [ALINX official website](https://www.alinx.com) for more information.
