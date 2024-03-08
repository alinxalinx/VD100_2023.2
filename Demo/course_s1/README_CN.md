# Course S1使用介绍
course_s1为纯FPGA和裸机工程，提供了脚本文件用于快速恢复工程。
## 创建Vivado工程
有两种方法创建Vivado工程，如下所示：
### 利用Vivado tcl console创建Vivado工程
1. 打开Vivado软件并且利用**cd**命令进入"**auto_create_project**"目录，并回车
```
cd \<archive extracted location\>/course_s1/01_led/vivado/auto_create_project
```
2. 输入 **source ./create_project.tcl** 并且回车
```
source ./create_project.tcl
```

### 利用bat创建Vivado工程
1. 在 "**auto_create_project**" 文件夹, 有个 "**create_project.bat**"文件, 右键以编辑模式打开，并且修改vivado路径为本主机vivado安装路径，保存并关闭。
```
CALL E:\Xilinx\Vivado\2023.2\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. 在Windows下双击bat文件即可。
## 创建Vitis工程
创建Vitis工程方法如下：
1. 打开Vitis软件，可以在Vivado中点击Tools-->Launch Vitis IDE, 或者双击Vitis图标打开。
2. 在Vitis软件中，点击菜单栏的Terminal-->New Terminal
3. 在Terminal中利用cd命令进入builder.py所在的目录。
```
cd \<archive extracted location\>/course_s1/05_ps_hello/vitis
```
4. 在Terminal中输入vitis -i进入vitis CLI模式。
```
vitis -i
```
5. 输入运行python命令
```
run -t builder.py
```
6. 等待vitis工程创建结束，可点击Open Workspace进入工程

更多信息, 请访问[ALINX网站] (https://www.alinx.com)