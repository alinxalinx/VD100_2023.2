#include "xil_printf.h"
#include "vdma.h"

u32 vdma_version(XAxiVdma *Vdma) {
	return XAxiVdma_GetVersion(Vdma);
}

int vdma_read_start(XAxiVdma *Vdma) {
	int Status;

	// MM2S Startup
	Status = XAxiVdma_DmaStart(Vdma, XAXIVDMA_READ);
	if (Status != XST_SUCCESS)
	{
	   xil_printf("Start read transfer failed %d\n\r", Status);
	   return XST_FAILURE;
	}

	return XST_SUCCESS;
}


int vdma_read_stop(XAxiVdma *Vdma) {
	XAxiVdma_DmaStop(Vdma, XAXIVDMA_READ);
	return XST_SUCCESS;
}


int vdma_read_init(u32 DeviceID,short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr)
{
	XAxiVdma Vdma;
	XAxiVdma_Config *Config;
	XAxiVdma_DmaSetup ReadCfg;
	int Status;


	Config = XAxiVdma_LookupConfig(DeviceID);
	if (NULL == Config) {
		xil_printf("XAxiVdma_LookupConfig failure\r\n");
		return XST_FAILURE;
	}

	Status = XAxiVdma_CfgInitialize(&Vdma, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("XAxiVdma_CfgInitialize failure\r\n");
		return XST_FAILURE;
	}

	

	ReadCfg.EnableCircularBuf = 0;
	ReadCfg.EnableFrameCounter = 0;
	ReadCfg.FixedFrameStoreAddr = 0;

	ReadCfg.EnableSync = 1;
	ReadCfg.PointNum = 1;

	ReadCfg.FrameDelay = 0;

	ReadCfg.VertSizeInput = VertSizeInput;
	ReadCfg.HoriSizeInput = HoriSizeInput;
	ReadCfg.Stride = Stride;

	Status = XAxiVdma_DmaConfig(&Vdma, XAXIVDMA_READ, &ReadCfg);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,
				"Read channel config failed %d\r\n", Status);

			return XST_FAILURE;
	}


	ReadCfg.FrameStoreStartAddr[0] = FrameStoreStartAddr;

	Status = XAxiVdma_DmaSetBufferAddr(&Vdma, XAXIVDMA_READ, ReadCfg.FrameStoreStartAddr);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,"Read channel set buffer address failed %d\r\n", Status);
			return XST_FAILURE;
	}


	Status = vdma_read_start(&Vdma);
	if (Status != XST_SUCCESS) {
		   xil_printf("error starting VDMA..!");
		   return Status;
	}
	return XST_SUCCESS;

}


int vdma_write_start(XAxiVdma *Vdma)
{
	int Status;

	// MM2S Startup
	Status = XAxiVdma_DmaStart(Vdma, XAXIVDMA_WRITE);
	if (Status != XST_SUCCESS)
	{
	   xil_printf("Start write transfer failed %d\n\r", Status);
	   return XST_FAILURE;
	}
	return XST_SUCCESS;
}


int vdma_write_stop(XAxiVdma *Vdma)
{
	XAxiVdma_DmaStop(Vdma, XAXIVDMA_WRITE);
	return XST_SUCCESS;
}


int vdma_write_init(u32 DeviceID,XAxiVdma *Vdma,short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr0,unsigned int FrameStoreStartAddr1,unsigned int FrameStoreStartAddr2)
{
	//XAxiVdma Vdma;
	XAxiVdma_Config *Config;
	XAxiVdma_FrameCounter FrameCfg;
	XAxiVdma_DmaSetup WriteCfg;
	int Status;
	xil_printf("HSIZE:%d VSIZE:%d STRIDE:%d\r\n",HoriSizeInput,VertSizeInput,Stride);

	Config = XAxiVdma_LookupConfig(DeviceID);
	if (NULL == Config) {
		xil_printf("XAxiVdma_LookupConfig failure\r\n");
		return XST_FAILURE;
	}
	Status = XAxiVdma_CfgInitialize(Vdma, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("XAxiVdma_CfgInitialize failure\r\n");
		return XST_FAILURE;
	}
/*
	Status = XAxiVdma_SetFrmStore(Vdma, 3,XAXIVDMA_WRITE);
	if (Status != XST_SUCCESS) {

		xil_printf(
		    "Setting Frame Store Number Failed in Write Channel"
							" %d\r\n", Status);

		return XST_FAILURE;
	}
*/
	FrameCfg.ReadFrameCount = 1;
	FrameCfg.WriteFrameCount = 1;
	FrameCfg.WriteDelayTimerCount = 10;

	Status = XAxiVdma_SetFrameCounter(Vdma, &FrameCfg);
	if (Status != XST_SUCCESS) {
		xil_printf(
			"Set frame counter failed %d\r\n", Status);

		if(Status == XST_VDMA_MISMATCH_ERROR)
			xil_printf("DMA Mismatch Error\r\n");

		return XST_FAILURE;
	}
	WriteCfg.EnableCircularBuf = 0;
	WriteCfg.EnableFrameCounter = 0;
	WriteCfg.FixedFrameStoreAddr = 0;

	WriteCfg.EnableSync = 1;
	WriteCfg.PointNum = 1;

	WriteCfg.FrameDelay = 0;

	WriteCfg.VertSizeInput = VertSizeInput;
	WriteCfg.HoriSizeInput = HoriSizeInput;
	WriteCfg.Stride = Stride;

	Status = XAxiVdma_DmaConfig(Vdma, XAXIVDMA_WRITE, &WriteCfg);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,
				"Read channel config failed %d\r\n", Status);

			return XST_FAILURE;
	}

	WriteCfg.FrameStoreStartAddr[0] = FrameStoreStartAddr0;
	WriteCfg.FrameStoreStartAddr[1] = FrameStoreStartAddr1;
	WriteCfg.FrameStoreStartAddr[2] = FrameStoreStartAddr2;

	Status = XAxiVdma_DmaSetBufferAddr(Vdma, XAXIVDMA_WRITE, WriteCfg.FrameStoreStartAddr);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,"Write channel set buffer address failed %d\r\n", Status);
			return XST_FAILURE;
	}

	//Status = vdma_write_start(&Vdma);
	//if (Status != XST_SUCCESS) {
		   //xil_printf("error starting VDMA..!");
		  // return Status;
	//}
	return XST_SUCCESS;

}


void VDMA_WriteStart(unsigned int Baseaddress, unsigned int bufaddr, unsigned int hsize, unsigned int stride, unsigned int vsize)
{
        Xil_Out32(Baseaddress + 0x30, 4);  // S2MM_DMACR: sof=tuser, reset 64+4

        while((Xil_In32(Baseaddress + 0x30)&4)==4); // wait for reset end
        Xil_Out32(Baseaddress + 0x30, 0x00); // 0x08002, 0x108b

        Xil_Out32(Baseaddress + 0x34, 0xffffffff);  // S2MM_DMASR: remove errors

        Xil_Out32(Baseaddress + 0xAC, bufaddr); // adr1

        Xil_Out32(Baseaddress + 0xA4, hsize);  // length in bytes info->pixelLength * info->width
        Xil_Out32(Baseaddress + 0xA8, stride );  // stride length in bytes 0x01002000

        Xil_Out32(Baseaddress + 0x30, Xil_In32(Baseaddress + 0x30) | 0x1);  // S2MM_DMACR: sof=tuser, RS 64+1

    while((Xil_In32(Baseaddress + 0x34)&1)==1)
    {

    }

    Xil_Out32(Baseaddress + 0xA0, vsize);  // height and start info->height

}

void VDMA_ReadStart(unsigned int Baseaddress, unsigned int bufaddr, unsigned int hsize, unsigned int stride, unsigned int vsize)
{
        Xil_Out32(Baseaddress + 0x00, 4);  // MM2S_DMACR: sof=tuser, reset 64+4

        while((Xil_In32(Baseaddress + 0x00)&4)==4); // wait for reset end
        Xil_Out32(Baseaddress + 0x00, 0x00); // 0x08002, 0x108b

        Xil_Out32(Baseaddress + 0x04, 0xffffffff);  // MM2S_DMASR: remove errors

        Xil_Out32(Baseaddress + 0x5C, bufaddr); // adr1

        Xil_Out32(Baseaddress + 0x54, hsize);  // length in bytes info->pixelLength * info->width
        Xil_Out32(Baseaddress + 0x58, stride );  // stride length in bytes 0x01002000

        Xil_Out32(Baseaddress + 0x00, Xil_In32(Baseaddress + 0x00) | 0x1);  // S2MM_DMACR: sof=tuser, RS 64+1

    while((Xil_In32(Baseaddress + 0x04)&1)==1)
    {

    }

    Xil_Out32(Baseaddress + 0x50, vsize);  // height and start info->height

}
