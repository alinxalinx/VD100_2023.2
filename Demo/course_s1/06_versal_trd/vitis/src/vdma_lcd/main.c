
/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

#include <stdio.h>
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xiicps.h"
#include "config.h"
#include "sleep.h"

#include "xil_cache.h"
#include "vdma.h"
#include "xgpiops.h"
#include "xscugic.h"
#include "xgpio.h"
#include "vtc.h"

/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */


XAxiVdma display_vdma;



/*
 * Display Driver structs
 */


XVtc Vtc0;




u8 color[8][3] = {
		{255,255,255},//White color
		{255,255,0},//YELLOW color
		{0,255,255},//CYAN color
		{0,255,0},//GREEN color
		{255,0,255},//MAGENTA color
		{255,0,0},//RED color
		{0,0,255},//BLUE color
		{0,0,0}//BLACK color
};


/*
 * Framebuffers for video data
 */
u8 frameBuf[3][DEMO_MAX_FRAME] __attribute__ ((aligned(4096)));
u8 *pFrames[3]; //array of pointers to the frame buffers


int main(void)
{

	int i,j;


	for (i = 0; i < 3; i++) {
		pFrames[i] = frameBuf[i];
		memset(pFrames[i], 0, DEMO_MAX_FRAME);


		for (i = 0; i < DEMO_VSIZE; i++) {
			for (j = 0; j < DEMO_HSIZE; j+=3)
			{
				if(j<DEMO_HSIZE/8){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[0][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[0][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[0][2];
				}
				else if(j<2*(DEMO_HSIZE/8)){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[1][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[1][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[1][2];
				}
				else if(j<3*(DEMO_HSIZE/8)){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[2][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[2][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[2][2];
				}
				else if(j<4*(DEMO_HSIZE/8)){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[3][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[3][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[3][2];
				}
				else if(j<5*(DEMO_HSIZE/8)){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[4][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[4][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[4][2];
				}
				else if(j<6*(DEMO_HSIZE/8)){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[5][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[5][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[5][2];
				}
				else if(j<7*(DEMO_HSIZE/8)){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[6][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[6][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[6][2];
				}
				else if(j<8*(DEMO_HSIZE/8)){
					pFrames[0][i*DEMO_STRIDE+j+0] = color[7][0];
					pFrames[0][i*DEMO_STRIDE+j+1] = color[7][1];
					pFrames[0][i*DEMO_STRIDE+j+2] = color[7][2];
				}
			}
		}
        Xil_DCacheFlushRange((INTPTR) pFrames[0], DEMO_MAX_FRAME) ;

		sleep(1);

		Vtc_init(&Vtc0,XPAR_V_TC_0_BASEADDR, VMODE_1280x720);

		VDMA_ReadStart(XPAR_AXI_VDMA_0_BASEADDR, (unsigned int)pFrames[0], TX_HSIZE,  DEMO_STRIDE,	TX_VSIZE);


		return 0;
	}
}
