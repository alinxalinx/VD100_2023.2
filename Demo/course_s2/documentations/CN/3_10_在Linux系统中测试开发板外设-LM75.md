# LM75
LM75是一种数字温度传感器芯片，由德州仪器（Texas Instruments）公司生产。它可以测量环境温度，并通过I2C总线与其他设备进行通信。是一个性能稳定、精度高、可靠性好的数字温度传感器芯片。
## 在Linux系统上使用LM75
在Linux中直接读取 */sys/bus/i2c/devices/2-0048/hwmon/hwmon0/temp1_input* 就可以获取到LM75采集的温度值，**单位是m°C**：\
`sudo cat /sys/bus/i2c/devices/2-0048/hwmon/hwmon0/temp1_input`\
![](../images/59.png)\
这里读到的温度是30500m°C，也就是30.5°C。

---
---
- 访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。
