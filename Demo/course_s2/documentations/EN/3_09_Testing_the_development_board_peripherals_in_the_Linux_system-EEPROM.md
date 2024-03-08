# EEPROM
## Using EEPROM on Linux systems
The operating file of eeprom in the system we provide is */sys/bus/i2c/devices/2-0050/eeprom*. \
Use this command to write data in quotes into eeprom:\
`echo -e "test e2prom\n" | sudo tee /sys/bus/i2c/devices/2-0050/eeprom`\
Use this command to view the contents of eeprom:\
`sudo cat /sys/bus/i2c/devices/2-0050/eeprom`


## Use the system's built-in script to test EEPROM
Run `sudo ~/test_apps/eeprom_test.sh` :\
![](../images/58.png)

---
---
- Visit [ALINX official website](https://www.alinx.com) for more information.