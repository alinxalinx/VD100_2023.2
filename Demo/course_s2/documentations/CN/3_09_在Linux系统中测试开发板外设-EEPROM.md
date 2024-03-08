# EEPROM
## 在Linux系统上使用EEPROM
eeprom在我们提供的系统中的操作文件是 */sys/bus/i2c/devices/2-0050/eeprom* 。\
使用这条命令可以往eeprom中写入引号中的数据：\
`echo -e "test e2prom\n" | sudo tee /sys/bus/i2c/devices/2-0050/eeprom`\
使用这条命令可以查看eeprom中的内容：\
`sudo cat /sys/bus/i2c/devices/2-0050/eeprom`


## 使用系统内置的脚本测试EEPROM
运行 *sudo ~/test_apps/eeprom_test.sh* ：\
![](../images/58.png) 

---
---
- 访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。
