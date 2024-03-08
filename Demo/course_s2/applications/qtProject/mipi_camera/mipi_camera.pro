QT =

TARGET = mipi_senser1_show

INCLUDEPATH += /opt/petalinux/2023.2/sysroots/cortexa72-cortexa53-xilinx-linux/usr/include

LIBS += \
        -lopencv_core \
        -lopencv_highgui \
        -lopencv_videoio \
        -lopencv_imgproc

target.path=/home/root
INSTALLS += target

SOURCES += \
    main.cpp
