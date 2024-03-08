/************************************************************************/
/*																		*/
/*	display_demo.c	--	ALINX AX7010 HDMI Display demonstration 						*/
/*																		*/
/************************************************************************/

/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

#include "config.h"
#include <stdio.h>
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xiicps.h"
#include "vdma.h"
#include "i2c/PS_i2c.h"
#include "xgpio.h"
#include "sleep.h"
#include "cam_config.h"
#include "xscugic.h"
#include "zynq_interrupt.h"
#include "xinterrupt_wrap.h"
#include "demosaic/demosaic.h"
#include "xgpiops.h"
#include "vtc.h"

/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */
#define LED_MIO	25
#define CAM1_EMIO	26
#define CAM2_EMIO	27



/*
 * Display Driver structs
 */
XGpio rst_gpio ;

XGpioPs GPIO_PTR ;
XIicPs ps_i2c0;
XIicPs ps_i2c1;
XScuGic XScuGicInstance;

XAxiVdma vdma_vin[2];
XAxiVdma display_vdma;

XVtc Vtc0;

static int WriteError;

int wr_index[2]={0,0};
int rd_index[2]={0,0};
int frame_length_curr;

u32 frame_cnt0 = 0 ;
u32 frame_cnt1 = 0 ;

/*
 * Framebuffers for video data
 */
u8 frameBuf0[3][DEMO_MAX_FRAME] __attribute__ ((aligned(4096)));
u8 frameBuf1[3][DEMO_MAX_FRAME] __attribute__ ((aligned(4096)));
u8 *pFrames0[3]; //array of pointers to the frame buffers
u8 *pFrames1[3];

int WriteOneFrameEnd[2]={-1,-1};


/* ------------------------------------------------------------ */
/*				Procedure Definitions							*/
/* ------------------------------------------------------------ */
static void WriteCallBack0(void *CallbackRef, u32 Mask);
static void WriteCallBack1(void *CallbackRef, u32 Mask);
static void WriteErrorCallBack(void *CallbackRef, u32 Mask);
int PsGpioSetup() ;
int PLGpioSetup() ;



void resetVideoFmt(int w, int h, int ch)
{

	frame_length_curr = 0;
	/* Stop vdma write process, disable vdma interrupt */
	vdma_write_stop(&vdma_vin[ch]);
	XAxiVdma_IntrDisable(&vdma_vin[ch], XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_WRITE);

	/* reconfig Sensor horizontal width and vertical height */
	if(ch == 0)
	{
		i2c_reg16_write(&ps_i2c0, 0x36, 0x3808, (w>>8)&0xff);
		i2c_reg16_write(&ps_i2c0, 0x36, 0x3809, (w>>0)&0xff);
		i2c_reg16_write(&ps_i2c0, 0x36, 0x380a, (h>>8)&0xff);
		i2c_reg16_write(&ps_i2c0, 0x36, 0x380b, (h>>0)&0xff);
	}
	else
	{
		i2c_reg16_write(&ps_i2c1, 0x36, 0x3808, (w>>8)&0xff);
		i2c_reg16_write(&ps_i2c1, 0x36, 0x3809, (w>>0)&0xff);
		i2c_reg16_write(&ps_i2c1, 0x36, 0x380a, (h>>8)&0xff);
		i2c_reg16_write(&ps_i2c1, 0x36, 0x380b, (h>>0)&0xff);
	}

	/*
	 * Initial vdma write path, set call back function and register interrupt to GIC
	 */
	if(ch == 0)
	{

		XGpio_DiscreteWrite(&rst_gpio, 1, 0x0);
		usleep(10);
		XGpio_DiscreteWrite(&rst_gpio, 1, 0x1);
		usleep(10);
		demosaic_init(XPAR_V_DEMOSAIC_0_BASEADDR,w,h);


        vdma_write_init(XPAR_AXIVDMA_1_DEVICE_ID, &vdma_vin[ch], w * 3, h, w * 3,
				(unsigned int)pFrames0[0], (unsigned int)pFrames0[1], (unsigned int)pFrames0[2]);

		
		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_GENERAL,WriteCallBack0, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);
		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_ERROR,WriteErrorCallBack, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);

        #ifdef SDT
        XSetupInterruptSystem((void *)&vdma_vin[ch], &XAxiVdma_WriteIntrHandler,
				       XPAR_FABRIC_AXI_VDMA_1_S2MM_INTROUT_INTR, XPAR_AXI_VDMA_1_INTERRUPT_PARENT,
				       XINTERRUPT_DEFAULT_PRIORITY);
        #else
        InterruptConnect(&XScuGicInstance,XPAR_FABRIC_AXI_VDMA_1_S2MM_INTROUT_INTR,XAxiVdma_WriteIntrHandler,(void *)&vdma_vin[ch]);    
        #endif
	}
	else
	{
		XGpio_DiscreteWrite(&rst_gpio, 2, 0x0);
		usleep(10);
		XGpio_DiscreteWrite(&rst_gpio, 2, 0x1);
		usleep(10);
		demosaic_init(XPAR_V_DEMOSAIC_1_BASEADDR,w,h);

		vdma_write_init(XPAR_AXIVDMA_2_DEVICE_ID, &vdma_vin[ch], w * 3, h, w * 3,
				(unsigned int)pFrames1[0], (unsigned int)pFrames1[1], (unsigned int)pFrames1[2]);
		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_GENERAL,WriteCallBack1, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);
		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_ERROR,WriteErrorCallBack, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);
		#ifdef SDT
        XSetupInterruptSystem((void *)&vdma_vin[ch], &XAxiVdma_WriteIntrHandler,
				       XPAR_FABRIC_AXI_VDMA_2_S2MM_INTROUT_INTR, XPAR_AXI_VDMA_2_INTERRUPT_PARENT,
				       XINTERRUPT_DEFAULT_PRIORITY);
        #else
        InterruptConnect(&XScuGicInstance,XPAR_FABRIC_AXI_VDMA_2_S2MM_INTROUT_INTR,XAxiVdma_WriteIntrHandler,(void *)&vdma_vin[ch]);    
        #endif
	}
	/* Start vdma write process, enable vdma interrupt */
	XAxiVdma_IntrEnable(&vdma_vin[ch], XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_WRITE);
	vdma_write_start(&vdma_vin[ch]);
	frame_length_curr = w*h*3;
	xil_printf("Frame length = %d\r\n",frame_length_curr);
}

int lwip_loop();

int main(void)
{
	int i;
	int j;

	/*
	 * Initialize an array of pointers to the 3 frame buffers
	 */
	for (i = 0; i < 3; i++)
	{
		pFrames0[i] = frameBuf0[i];
		pFrames1[i] = frameBuf1[i];
		memset(pFrames0[i], 0, DEMO_MAX_FRAME);
		Xil_DCacheFlushRange((INTPTR) pFrames0[i], DEMO_MAX_FRAME) ;
		memset(pFrames1[i], 0, DEMO_MAX_FRAME);
		Xil_DCacheFlushRange((INTPTR) pFrames1[i], DEMO_MAX_FRAME) ;
	}

	/*
	 * Interrupt initialization
	 */
	InterruptInit(XPAR_SCUGIC_0_DEVICE_ID,&XScuGicInstance);

	PsGpioSetup() ;
	PLGpioSetup() ;

	XGpioPs_WritePin(&GPIO_PTR, CAM1_EMIO, 1) ;
	XGpioPs_WritePin(&GPIO_PTR, CAM2_EMIO, 1) ;
	usleep(500000);
	XGpioPs_WritePin(&GPIO_PTR, CAM1_EMIO, 0) ;
	XGpioPs_WritePin(&GPIO_PTR, CAM2_EMIO, 0) ;
	usleep(500000);
	XGpioPs_WritePin(&GPIO_PTR, CAM1_EMIO, 1) ;
	XGpioPs_WritePin(&GPIO_PTR, CAM2_EMIO, 1) ;
	usleep(500000);


	/*
	 * initial i2c and sensor
	 */
	i2c_init(&ps_i2c0, XPAR_XIICPS_0_DEVICE_ID,100000);
	i2c_init(&ps_i2c1, XPAR_XIICPS_1_DEVICE_ID,100000);
	sensor_init(&ps_i2c0);
	sensor_init(&ps_i2c1);

    demosaic_init(XPAR_V_DEMOSAIC_0_BASEADDR,1280,720);
    demosaic_init(XPAR_V_DEMOSAIC_1_BASEADDR,1280,720);
	/*
	 * Reconfiguration Sensor and VDMA
	 */
	resetVideoFmt(1280, 720, 0);
	resetVideoFmt(1280, 720, 1);

	/*
	 * Start lwip engine
	 */
	lwip_loop();

	return 0;
}

/*****************************************************************************/
/*
 * Call back function for write channel
 *
 * This callback only clears the interrupts and updates the transfer status.
 *
 * @param	CallbackRef is the call back reference pointer
 * @param	Mask is the interrupt mask passed in from the driver
 *
 * @return	None
 *
 ******************************************************************************/
static void WriteCallBack0(void *CallbackRef, u32 Mask)
{
	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK)
	{
		frame_cnt0++;
				if(WriteOneFrameEnd[0] >= 0)
				{
					return;
				}
		int hold_rd = rd_index[0];
		if(wr_index[0]==2)
		{
			wr_index[0]=0;
			rd_index[0]=2;
		}
		else
		{
			rd_index[0] = wr_index[0];
			wr_index[0]++;
		}
		/* Set park pointer */
		XAxiVdma_StartParking((XAxiVdma*)CallbackRef, wr_index[0], XAXIVDMA_WRITE);
		if (frame_cnt0%2 == 0)
			WriteOneFrameEnd[0] = hold_rd;
	}
}

static void WriteCallBack1(void *CallbackRef, u32 Mask)
{
	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK)
	{
		frame_cnt1++;
				if(WriteOneFrameEnd[1] >= 0)
				{
					return;
				}
		int hold_rd = rd_index[1];
		if(wr_index[1]==2)
		{
			wr_index[1]=0;
			rd_index[1]=2;
		}
		else
		{
			rd_index[1] = wr_index[1];
			wr_index[1]++;
		}
		/* Set park pointer */
		XAxiVdma_StartParking((XAxiVdma*)CallbackRef, wr_index[1], XAXIVDMA_WRITE);
		if (frame_cnt1%2 == 0)
			WriteOneFrameEnd[1] = hold_rd;
	}
}

/*****************************************************************************/
/*
 * Call back function for write channel error interrupt
 *
 * @param	CallbackRef is the call back reference pointer
 * @param	Mask is the interrupt mask passed in from the driver
 *
 * @return	None
 *
 ******************************************************************************/
static void WriteErrorCallBack(void *CallbackRef, u32 Mask)
{

	if (Mask & XAXIVDMA_IXR_ERROR_MASK) {
		WriteError += 1;
		// xil_printf("vdma error\r\n");
	}
}



int PsGpioSetup()
{
	XGpioPs_Config *GPIO_CONFIG ;
	int Status ;
	int i ;

	GPIO_CONFIG = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID) ;

	Status = XGpioPs_CfgInitialize(&GPIO_PTR, GPIO_CONFIG, GPIO_CONFIG->BaseAddr) ;
	if (Status != XST_SUCCESS)
	{
		return XST_FAILURE ;
	}


	XGpioPs_SetDirectionPin(&GPIO_PTR, CAM1_EMIO, 1) ;
	XGpioPs_SetOutputEnablePin(&GPIO_PTR, CAM1_EMIO, 1) ;
	XGpioPs_SetDirectionPin(&GPIO_PTR, CAM2_EMIO, 1) ;
	XGpioPs_SetOutputEnablePin(&GPIO_PTR, CAM2_EMIO, 1) ;




	return XST_SUCCESS ;
}

int PLGpioSetup()
{
	int Status ;

	/* initial gpio key */
	Status = XGpio_Initialize(&rst_gpio, XPAR_RST_GPIO_DEVICE_ID) ;
	if (Status != XST_SUCCESS)
		return XST_FAILURE ;


	/* set led as output */
	XGpio_SetDataDirection(&rst_gpio, 1, 0x0);


	XGpio_DiscreteWrite(&rst_gpio, 1, 0x1);

	return XST_SUCCESS ;
}