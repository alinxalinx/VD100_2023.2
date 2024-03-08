安装QT和OPENCV库以及在QTCreator中设置编译环境
=============================================

安装QT和OPENCV库
----------------

-  | Petalinux工程编译完成后执行命令： ``petalinux-build --sdk以获得sdk.sh``。编译sdk.h比较耗时，可以下载我们编译好的 `sdk.sh <http://www.alinx.vip:81/extra_support/2023_2_sdk_sh/sdk.sh>`_ 。
   | 把sdk.sh拷贝到QTCreator所在的Ubuntu系统中，并在sdk.sh所在的路径打开终端，执行命令: 
   | ``chmod +x ./sdk.sh && ./sdk.sh``
   | |IMG_256|

-  | 提示输入安装路径，这里我使用默认路径安装，安装完成后在对应的路径中可以看到这些文件:
   | |IMG_257|

-  | 解压 *demo/course_s2/libs/opencv4_include.tar.gz* ，把解压获得的 opencv4 文件夹递归替换掉下图路径中的同名文件夹:
   | |IMG_258|

在QTCreator中设置编译环境
-------------------------

-  | 打开QTCreator，点击上方菜单栏中的Tools ，选择Options : 
   | |IMG_259|

-  | 用之前安装的sdk.sh得到的库来添加一个 Kits : 
   | |IMG_260| 
   | |IMG_261|
   | |IMG_262|
   | |IMG_263|
   | |IMG_264|
   | 点击OK保存设置。

-  | 打开一个QT工程，以 *demo/course_s2/applications/qtProject/mipi_camera* 为例:
   | |IMG_265|
   | |IMG_266|

-  | 选择Versal的Kits来编译:
   | |IMG_267|

-  | 在编译结果路径中可以看到可执行文件
   | |IMG_268|



.. |IMG_256| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image1.png
.. |IMG_257| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image2.png
.. |IMG_258| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image3.png
.. |IMG_259| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image4.png
.. |IMG_260| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image5.png
.. |IMG_261| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image6.png
.. |IMG_262| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image7.png
.. |IMG_263| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image8.png
.. |IMG_264| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image9.png
.. |IMG_265| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image10.png
.. |IMG_266| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image11.png
.. |IMG_267| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image12.png
.. |IMG_268| image:: images/vertopal_7e0cd79c29c7473fab4303bd47f323b8/media/image13.png
