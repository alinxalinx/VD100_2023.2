Chapter 11 QSPI FLASH
============================================================

Using QSPI FLASH on Linux systems
---------------------------------

| The operation file of QSPI FLASH in the system is/dev/mtd0.
| The FLASH device needs to be erased before writing. Use the following command to erase the first sector of QSPI FLASH:
| ``sudo flash_erase/dev/mtd0 0 1``
| /dev/mtd0 is a block device, and you can use **dd** commands to read and write files to ``/dev/mtd0``.
| 
| Write the file to ``/dev/mtd0`` using the following command:
| ``sudo touch/home/petalinux/.qspiflashwrite``
| ``sudo echo "qspiflash test" | sudo tee/home/petalinux/.qspiflashwrite``
| ``sudo dd of=/dev/mtd0 if=/home/petalinux/.qspiflashwrite bs=4096 count=1``
| 
| Read data from/dev/mtd0 to a file with the following command:
| ``sudo touch/home/petalinux/.qspiflashread``
| ``sudo dd if=/dev/mtd0 of=/home/petalinux/.qspiflashread  bs=4096 count=1``
| ``sudo cat/home/petalinux/.qspiflashread``


