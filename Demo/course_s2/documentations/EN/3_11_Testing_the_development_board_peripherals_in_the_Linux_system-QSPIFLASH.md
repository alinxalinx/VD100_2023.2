# QSPIFLASH
## Using QSPI FLASH on Linux system
The operating file of QSPI FLASH in the system is */dev/mtd0*. \
The FLASH device needs to be erased before writing. Use the following command to erase the first sector of QSPI FLASH:\
`sudo flash_erase /dev/mtd0 0 1`\
*/dev/mtd0* is a block device. You can use the **dd** command to read and write files to */dev/mtd0*. \
Use the following command to write a file to */dev/mtd0*:
```
sudo touch /home/petalinux/.qspiflashwrite
sudo echo "qspiflash test" | sudo tee /home/petalinux/.qspiflashwrite
sudo dd of=/dev/mtd0 if=/home/petalinux/.qspiflashwrite bs=4096 count=1
```
Use the following command to read data from */dev/mtd0* to a file:
```
sudo touch /home/petalinux/.qspiflashread
sudo dd if=/dev/mtd0 of=/home/petalinux/.qspiflashread bs=4096 count=1
sudo cat /home/petalinux/.qspiflashread
```

---
---
- Visit [ALINX official website](https://www.alinx.com) for more information.

