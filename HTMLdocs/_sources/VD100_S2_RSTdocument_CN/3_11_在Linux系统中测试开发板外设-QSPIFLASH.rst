第十一章 QSPI FLASH
======================

在Linux系统上使用QSPI FLASH
---------------------------

| QSPI FLASH在系统中的操作文件是 /dev/mtd0。
| FLASH设备在写之前需要先擦，使用下面的命令可以擦除QSPI FLASH的第一个扇区：
| ``sudo flash_erase /dev/mtd0 0 1``
| /dev/mtd0 是块设备，可以用 **dd** 命令来读写文件到 ``/dev/mtd0``。
| 
| 用下面的命令写文件到 ``/dev/mtd0`` ：
| ``sudo touch /home/petalinux/.qspiflashwrite``
| ``sudo echo "qspiflash test" | sudo tee /home/petalinux/.qspiflashwrite``
| ``sudo dd of=/dev/mtd0 if=/home/petalinux/.qspiflashwrite bs=4096 count=1``
| 
| 用下面的命令从 /dev/mtd0 读取数据到文件：
| ``sudo touch /home/petalinux/.qspiflashread``
| ``sudo dd if=/dev/mtd0 of=/home/petalinux/.qspiflashread  bs=4096 count=1``
| ``sudo cat /home/petalinux/.qspiflashread``


