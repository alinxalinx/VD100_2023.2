# LM75
The LM75 is a digital temperature sensor chip produced by Texas Instruments. It can measure ambient temperature and communicate with other devices via the I2C bus. It is a digital temperature sensor chip with stable performance, high precision and good reliability.
## Using LM75 on Linux system
Directly read */sys/bus/i2c/devices/2-0048/hwmon/hwmon0/temp1_input* in Linux to get the temperature value collected by LM75, **unit is m°C**:\
`sudo cat /sys/bus/i2c/devices/2-0048/hwmon/hwmon0/temp1_input`\
![](../images/59.png)\
The temperature read here is 30500m°C, which is 30.5°C.

---
---
- Visit [ALINX official website](https://www.alinx.com) for more information.

