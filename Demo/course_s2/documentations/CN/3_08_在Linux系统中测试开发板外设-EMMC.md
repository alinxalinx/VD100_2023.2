# EMMC
## 在Linux系统上使用EMMC
EMMC在Linux系统中的操作文件是 */dev/mmcblk0* ，在Linux系统中使用EMMC需要设置分区、格式化分区、挂载分区。例如：
```
#如果已经存在分区则需要先解挂分区
sudo umount /dev/mmcblk0p1
#删除/dev/mmcblk0的一个分区并新建一个分区
echo "d

n
p
1


w
" | sudo fdisk /dev/mmcblk0
#把/dev/mmcblk0p1分区格式化成ext4格式
echo "y

" | sudo mkfs.ext4 /dev/mmcblk0p1
#挂载/dev/mmcblk0p1到/media/sd-mmcblk0p1
sudo mkdir /media/sd-mmcblk0p1 && sudo mount /dev/mmcblk0p1 /media/sd-mmcblk0p1
```
挂载之后，就可以在挂载的路径中操作文件了，而这些文件最终都会被保存在EMMC中。
## 使用系统内置的脚本测试EMMC
运行 *sudo ~/test_apps/emmc_test.sh* ：\
![](../images/57.png)

---
---
- 访问[ALINX官方网站](https://www.alinx.com)以获取更多信息。
