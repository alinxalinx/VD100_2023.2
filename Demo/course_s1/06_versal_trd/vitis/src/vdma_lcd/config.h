
#ifndef SRC_CONFIG_H_
#define SRC_CONFIG_H_

#define VIDEO_MODE 1


#if VIDEO_MODE == 0
#define VIDEO_COLUMNS 1920
#define VIDEO_ROWS 1080
#elif VIDEO_MODE == 1
#define VIDEO_COLUMNS 1280
#define VIDEO_ROWS 720
#elif VIDEO_MODE == 2
#define VIDEO_COLUMNS 800
#define VIDEO_ROWS 600
#else
#define VIDEO_COLUMNS 3840
#define VIDEO_ROWS 2160
#endif

#if VIDEO_MODE == 0
#define DEMO_MAX_FRAME (1920*1080*3)
#define DEMO_STRIDE (1920 * 3)
#define DEMO_HSIZE (1920 * 3)
#define DEMO_VSIZE 1080
#elif VIDEO_MODE == 1
#define DEMO_MAX_FRAME (1920*1080*3)
#define DEMO_STRIDE (1920 * 3)
#define DEMO_HSIZE (1280 * 3)
#define DEMO_VSIZE 720
#elif VIDEO_MODE == 2
#define DEMO_MAX_FRAME (1920*1080*3)
#define DEMO_STRIDE (1920 * 3)
#define DEMO_HSIZE (800 * 3)
#define DEMO_VSIZE 600
#else
#define DEMO_MAX_FRAME (3840*2160*3)
#define DEMO_STRIDE (3840 * 3)
#define DEMO_HSIZE (3840 * 3)
#define DEMO_VSIZE 2160
#endif

#define TX_HSIZE 1280*3
#define TX_VSIZE 720

#endif /* SRC_CONFIG_H_ */
