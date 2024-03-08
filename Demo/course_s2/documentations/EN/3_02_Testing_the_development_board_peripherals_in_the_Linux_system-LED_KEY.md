#LEDS、KEYS
## LED and KEY on VD100 development board
There are two sets of controllable LEDs and KEYs on the development board. At the location indicated in the following icon: \
![](../images/28.png)
## Using LED and KEY in Linux
Using LED and KEY actually means configuring and using GPIO. In Linux, you only need to know the GPIO number to use the corresponding IO port. The GPIO number needs to be viewed in conjunction with the schematic diagram. Taking PS_LED as an example, the schematic diagram connects the LPD_MIO25 pin on the Versal chip: \
![](../images/29.png) \
Enter the command `ls /sys/class/gpio/gpiochip*` in the development board system. The smallest value 450 after the *gpiochip* we see is the starting number of the LPD_MIO group IO
![](../images/30.png) \
The number of IO corresponding to PS_LED is *450+25*, which is 475. \
In the development board system we provide, the GPIO number of PS_LED is 475, and the GPIO number of PS_KEY is 474. \
The IO corresponding to the LED needs to be configured as output. The steps for configuration and use are as follows:
```
#Export the corresponding port
sudo echo 475 >> /sys/class/gpio/export
#Set this port as output
sudo echo out >> /sys/class/gpio/gpio475/direction
#Make this port output high level and light up the LED
sudo echo 1 >> /sys/class/gpio/gpio475/value
#Make this port output low level and turn off the LED
sudo echo 0 >> /sys/class/gpio/gpio475/value
```
The IO corresponding to KEY needs to be configured as input. The steps for configuration and use are as follows:
```
#Export the corresponding port
sudo echo 474 >> /sys/class/gpio/export
#Set this port as input
sudo echo in >> /sys/class/gpio/gpio474/direction
#Read the current level status of this IO
cat /sys/class/gpio/gpio474/value
```
---
In addition to this method, you can also directly read and write registers to use GPIO. PL_LED and PL_KEY are both implemented using *axi-gpio* IP. Their register addresses can be found in the vivado project as PL_LED:0x80040000 and PL_KEY: 0x80030000. \
Use the command `sudo devmem 0x80030000` to read the value of PL_KEY. \
Use the command `sudo devmem 0x80040000 32 1` to light up PL_LED;\
Use the command `sudo devmem 0x80040000 32 0` to turn off PL_LED.
## Use the system's built-in script to test LED and KEY
Run `sudo ~/test_apps/leds_keys_test.sh` (*ps: press **ctrl+c** key combination to exit*). Then you can use PS_KEY to control PS_LED to turn on and off, and PL_KEY to control PS_LED to turn on and off. \
![](../images/31.png)

---
---
- Visit [ALINX official website](https://www.alinx.com) for more information.

