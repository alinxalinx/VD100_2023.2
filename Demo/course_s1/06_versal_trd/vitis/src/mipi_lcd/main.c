
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
#include "i2c/PS_i2c.h"
#include "demosaic/demosaic.h"
#include "cam_config.h"
#include "config.h"
#include "sleep.h"

#include "xinterrupt_wrap.h"
#include "xil_cache.h"
#include "zynq_interrupt.h"
#include "vdma.h"
#include "xgpiops.h"
#include "xscugic.h"
#include "xgpio.h"
#include "vtc.h"
//#include "ff.h"
/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */

#define LED_MIO	25
#define CAM1_EMIO	26
#define CAM2_EMIO	27

XAxiVdma vdma_vin[2];
XAxiVdma display_vdma;

XVtc Vtc_inst;

static int WriteError;

int wr_index=0;
int rd_index=0;


XIicPs ps_i2c0;
XIicPs ps_i2c1;
XGpioPs GPIO_PTR ;


/*
 * Interrupt struct and function
 */
XScuGic XScuGicInstance ;

XGpio rst_gpio;

int PsGpioSetup() ;
int PLGpioSetup();
/*
 * Framebuffers for video data
 */

u8 frameBuf0[3][DEMO_MAX_FRAME] __attribute__ ((aligned(4096)));
u8 frameBuf1[3][DEMO_MAX_FRAME] __attribute__ ((aligned(4096)));
u8 *pFrames0[3]; //array of pointers to the frame buffers
u8 *pFrames1[3];


static void WriteCallBack0(void *CallbackRef, u32 Mask);
static void WriteCallBack1(void *CallbackRef, u32 Mask);
static void WriteErrorCallBack(void *CallbackRef, u32 Mask);

static void ReadCallBack(void *CallbackRef, u32 Mask);



void InitVideoFmt(XIicPs *IicInstance,int w, int h, int ch)
{

	i2c_reg16_write(IicInstance, 0x36, 0x3808, (w>>8)&0xff);
	i2c_reg16_write(IicInstance, 0x36, 0x3809, (w>>0)&0xff);
	i2c_reg16_write(IicInstance, 0x36, 0x380a, (h>>8)&0xff);
	i2c_reg16_write(IicInstance, 0x36, 0x380b, (h>>0)&0xff);

	/*
	 * Initial vdma write path, set call back function and register interrupt to GIC
	 */
	if(ch == 0)
	{
        vdma_write_init(XPAR_AXIVDMA_1_DEVICE_ID, &vdma_vin[ch], w * 3, h, DEMO_STRIDE,(unsigned int)pFrames0[0], 3);

		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_GENERAL,WriteCallBack0, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);
		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_ERROR,WriteErrorCallBack, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);

        #ifdef SDT
        XSetupInterruptSystem((void *)&vdma_vin[ch], &XAxiVdma_WriteIntrHandler,
				       XPAR_FABRIC_AXI_VDMA_1_S2MM_INTROUT_INTR, XPAR_AXI_VDMA_1_INTERRUPT_PARENT,
				       XINTERRUPT_DEFAULT_PRIORITY);
        #else
        InterruptConnect(&XScuGicInstance,XPAR_FABRIC_AXI_VDMA_1_S2MM_INTROUT_INTR,XAxiVdma_WriteIntrHandler,(void *)&vdma_vin[ch]);    
        #endif
        XAxiVdma_IntrEnable(&vdma_vin[ch], XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_WRITE);
	}
    else
    {
        #if (CAMERA_TYPE == SINGLE_2)
        vdma_write_init(XPAR_AXIVDMA_2_DEVICE_ID, &vdma_vin[ch], w * 3, h, DEMO_STRIDE,(unsigned int)pFrames1[0], 3);
        #else
        vdma_write_init(XPAR_AXIVDMA_2_DEVICE_ID, &vdma_vin[ch], w * 3, h, DEMO_STRIDE,(unsigned int)pFrames0[0]+VIDEO_COLUMNS*3, 3);
        #endif

		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_GENERAL,WriteCallBack0, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);
		XAxiVdma_SetCallBack(&vdma_vin[ch], XAXIVDMA_HANDLER_ERROR,WriteErrorCallBack, (void *)&vdma_vin[ch], XAXIVDMA_WRITE);

        #ifdef SDT
        XSetupInterruptSystem((void *)&vdma_vin[ch], &XAxiVdma_WriteIntrHandler,
				       XPAR_FABRIC_AXI_VDMA_2_S2MM_INTROUT_INTR, XPAR_AXI_VDMA_2_INTERRUPT_PARENT,
				       XINTERRUPT_DEFAULT_PRIORITY);
        #else
        InterruptConnect(&XScuGicInstance,XPAR_FABRIC_AXI_VDMA_2_S2MM_INTROUT_INTR,XAxiVdma_WriteIntrHandler,(void *)&vdma_vin[ch]);    
        #endif
        XAxiVdma_IntrEnable(&vdma_vin[ch], XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_WRITE);
	}
}

void InitDisplay()
{
    Vtc_init(&Vtc_inst,XPAR_V_TC_0_DEVICE_ID, VMODE_1280x720);
    #if (CAMERA_TYPE == SINGLE_2)
	vdma_read_init(XPAR_AXIVDMA_0_DEVICE_ID, &display_vdma, TX_HSIZE, TX_VSIZE, DEMO_STRIDE,	(unsigned int)pFrames1[0], 3);
    #else
    vdma_read_init(XPAR_AXIVDMA_0_DEVICE_ID, &display_vdma, TX_HSIZE, TX_VSIZE, DEMO_STRIDE,	(unsigned int)pFrames0[0], 3);
    #endif
	/* Set General Callback for dispaly Vdma */
	XAxiVdma_SetCallBack(&display_vdma, XAXIVDMA_HANDLER_GENERAL,ReadCallBack, (void *)&display_vdma, XAXIVDMA_READ);
	/* Connect interrupt to GIC */
    #ifdef SDT
    XSetupInterruptSystem((void *)&display_vdma, &XAxiVdma_ReadIntrHandler,
				       XPAR_FABRIC_AXI_VDMA_0_MM2S_INTROUT_INTR, XPAR_AXI_VDMA_0_INTERRUPT_PARENT,
				       XINTERRUPT_DEFAULT_PRIORITY);
    #else
    InterruptConnect(&XScuGicInstance,XPAR_FABRIC_AXI_VDMA_0_MM2S_INTROUT_INTR,XAxiVdma_ReadIntrHandler,(void *)&display_vdma);    
    #endif
	/* enable vdma interrupt */
	XAxiVdma_IntrEnable(&display_vdma, XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_READ);
}

int main(void)
{



	int i,j;


	PsGpioSetup() ;
	PLGpioSetup() ;

	


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
	 * Initial GIC
	 */
	InterruptInit(XPAR_SCUGIC_0_DEVICE_ID,&XScuGicInstance);
    #if (CAMERA_TYPE == SINGLE_1 || CAMERA_TYPE == DOUBLE)
	demosaic_init(XPAR_V_DEMOSAIC_0_BASEADDR,VIDEO_COLUMNS,VIDEO_ROWS);
    #endif

    #if (CAMERA_TYPE == SINGLE_2 || CAMERA_TYPE == DOUBLE)
	demosaic_init(XPAR_V_DEMOSAIC_1_BASEADDR,VIDEO_COLUMNS,VIDEO_ROWS);
    #endif
    

    #if (CAMERA_TYPE == SINGLE_1 || CAMERA_TYPE == DOUBLE)
	i2c_init(&ps_i2c0, XPAR_XIICPS_0_DEVICE_ID,100000);
    #endif
    #if (CAMERA_TYPE == SINGLE_2 || CAMERA_TYPE == DOUBLE)
	i2c_init(&ps_i2c1, XPAR_XIICPS_1_DEVICE_ID,100000);
    #endif


    XGpioPs_WritePin(&GPIO_PTR, CAM1_EMIO, 1) ;
	XGpioPs_WritePin(&GPIO_PTR, CAM2_EMIO, 1) ;
	usleep(500000);
	XGpioPs_WritePin(&GPIO_PTR, CAM1_EMIO, 0) ;
	XGpioPs_WritePin(&GPIO_PTR, CAM2_EMIO, 0) ;
	usleep(500000);
	XGpioPs_WritePin(&GPIO_PTR, CAM1_EMIO, 1) ;
	XGpioPs_WritePin(&GPIO_PTR, CAM2_EMIO, 1) ;
	usleep(500000);
    #if (CAMERA_TYPE == SINGLE_1 || CAMERA_TYPE == DOUBLE)
	sensor_init(&ps_i2c0);
    InitVideoFmt(&ps_i2c0,VIDEO_COLUMNS,VIDEO_ROWS,0);
    #endif
    #if (CAMERA_TYPE == SINGLE_2 || CAMERA_TYPE == DOUBLE)
	sensor_init(&ps_i2c1);
    InitVideoFmt(&ps_i2c1,VIDEO_COLUMNS,VIDEO_ROWS,1);
    #endif


	InitDisplay();

	xil_printf("config done!\r\n");


	while(1){
		XGpioPs_WritePin(&GPIO_PTR, LED_MIO, 0) ;
		usleep(500000);
		XGpioPs_WritePin(&GPIO_PTR, LED_MIO, 1) ;
		usleep(500000);
	}


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

		if(wr_index==2)
		{
			wr_index=0;
			rd_index=2;
		}
		else
		{
			rd_index = wr_index;
			wr_index++;
		}
		/* Set park pointer */
		XAxiVdma_StartParking((XAxiVdma*)CallbackRef, wr_index, XAXIVDMA_WRITE);
	}
}
static void WriteCallBack1(void *CallbackRef, u32 Mask)
{
	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK)
	{

		/* Set park pointer */
		XAxiVdma_StartParking((XAxiVdma*)CallbackRef, wr_index, XAXIVDMA_WRITE);
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
	}
}


static void ReadCallBack(void *CallbackRef, u32 Mask)
{
	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK)
	{
		/* Set park pointer */
		XAxiVdma_StartParking((XAxiVdma*)CallbackRef, rd_index, XAXIVDMA_READ);
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



	XGpioPs_SetDirectionPin(&GPIO_PTR, LED_MIO, 1) ;
	XGpioPs_SetOutputEnablePin(&GPIO_PTR, LED_MIO, 1) ;



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


