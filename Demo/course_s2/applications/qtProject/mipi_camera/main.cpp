#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>
#include <fcntl.h>
#include <malloc.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <opencv4/opencv2/core/core.hpp>
#include <opencv4/opencv2/highgui/highgui.hpp>
#include <opencv4/opencv2/imgproc/imgproc.hpp>
using namespace cv;

#define MIPINUM 1
#if MIPINUM == 0
#   define CV_WIN_NAME         "ALINX_MIPI_0"
#else
#   define CV_WIN_NAME         "ALINX_MIPI_1"
#endif
#define IMG_SIZE_WIDTH      600
#define IMG_SIZE_HEIGHT     800

int main(int argc, char *argv[])
{
    Mat imgUvc(IMG_SIZE_WIDTH, IMG_SIZE_HEIGHT, CV_8UC3, Scalar(0, 0, 255));
    char *img[2];
    setenv("DISPLAY", ":0.0", 0);

    int fd0 = open("/dev/mem", O_RDONLY);
    if(fd0 >= 0) {
        for(int i=0;i<1;i++) {
            img[i] = (char *)mmap(0, IMG_SIZE_WIDTH*IMG_SIZE_HEIGHT*3, PROT_READ, MAP_SHARED, fd0, 0x30000000+0x3000000
                                                                                        #if MIPINUM == 0
                                                                                            *0);
                                                                                        #else
                                                                                            *1);
                                                                                        #endif
            if(img[i] == MAP_FAILED) {
                printf("mmap fail :%s", strerror(errno));
                exit(1);
            }
        }
    }
    else {
        printf("open /dev/mem fail");
        exit(1);
    }

    //创建显示窗口
    namedWindow(CV_WIN_NAME, WINDOW_NORMAL);

    while (1)
    {
        //捕获图像
        memcpy(imgUvc.data,img[0],imgUvc.total()*imgUvc.elemSize());

        //鼠标操作关闭显示窗口时，程序退出
        if (getWindowProperty(CV_WIN_NAME, WND_PROP_AUTOSIZE) == -1)
        {
            break;
        }

        imshow(CV_WIN_NAME, imgUvc);
        waitKey(30);
    }

    return 0;
}

