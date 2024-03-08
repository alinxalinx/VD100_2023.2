# CAN
## CAN在VD100上的位置
![](../images/32.png)
## 在Linux中使用CAN
在VD100开发板上只有一路CAN接口，测试CAN接口需要借助CAN转USB的工具连接到PC机测试。\
在开发板系统上使用`ifconfig -a`命令可以看到开发板上有一路can即*can0* ：\
![](../images/33.png)\
使用这条命令来设置can0的bitrate并启动can0：\
`sudo ip link set can0 up type can bitrate 1000000`\
![](../images/34.png)\
使用这条命令可以接收can0收到的数据：\
`candump can0`\
同时打开CAN转USB工具的上位机，设置成同样的波特率，发送数据，可以看到开发板系统中收到了上位机发出的数据: \
![](../images/35.png)

---
使用这条命令可以通过can0发送id为\"5A1\"的十六进制数据\"11 22 33 44 55\"到CAN总线上：\
`cansend can0 5A1#11.2233.4455`\
我们的上位机程序中也能收到这条CAN报文:
![](../images/36.png)

---
---
- 访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。
