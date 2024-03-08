Chapter 9 EEPROM
==================================

Using EEPROM on a Linux system
------------------------------

| EEPROM The operation file in the system we provide is ``/sys/bus/i2c/devices/2-0050/eeprom``.
| Use this command to write data in quotes to the EEPROM:
| ``echo -e "test e2prom\n " | sudo tee /sys/bus/i2c/devices/2-0050/eeprom``
| Use this command to view the contents of the EEPROM:
| ``sudo cat/sys/bus/i2c/devices/2-0050/eeprom``

Test the EEPROM using the script built into the system
------------------------------------------------------

| Run ``sudo ~/test_apps/eeprom_test.sh`` :
| |IMG_256|



.. |IMG_256| image:: images/vertopal_a90a7242a14342e8a4705120db21ccad/media/image1.png
