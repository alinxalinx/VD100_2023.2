#include "vtc.h"




int Vtc_init(XVtc *InstancePtr,u32 vtcId,VideoMode vMode)
{
	XVtc_Timing vtcTiming;
	XVtc_SourceSelect SourceSelect;
	XVtc_Config *vtcConfig;
	int Status ;

	/* Initialize the VTC driver so that it's ready to use look up
	 * configuration in the config table, then initialize it.
	 */
	vtcConfig = XVtc_LookupConfig(vtcId);
	/* Checking Config variable */
	if (NULL == vtcConfig) {
		return (XST_FAILURE);
	}
	Status = XVtc_CfgInitialize(InstancePtr, vtcConfig, vtcConfig->BaseAddress);
	/* Checking status */
	if (Status != (XST_SUCCESS)) {
		return (XST_FAILURE);
	}




	/*
	 * Configure the vtc core with the display mode timing parameters
	 */
	vtcTiming.HActiveVideo = vMode.width;	/**< Horizontal Active Video Size */
	vtcTiming.HFrontPorch = vMode.hps - vMode.width;	/**< Horizontal Front Porch Size */
	vtcTiming.HSyncWidth = vMode.hpe - vMode.hps;		/**< Horizontal Sync Width */
	vtcTiming.HBackPorch = vMode.hmax - vMode.hpe + 1;		/**< Horizontal Back Porch Size */
	vtcTiming.HSyncPolarity = vMode.hpol;	/**< Horizontal Sync Polarity */
	vtcTiming.VActiveVideo = vMode.height;	/**< Vertical Active Video Size */
	vtcTiming.V0FrontPorch = vMode.vps - vMode.height;	/**< Vertical Front Porch Size */
	vtcTiming.V0SyncWidth = vMode.vpe - vMode.vps;	/**< Vertical Sync Width */
	vtcTiming.V0BackPorch = vMode.vmax - vMode.vpe + 1;	/**< Horizontal Back Porch Size */
	vtcTiming.V1FrontPorch = vMode.vps - vMode.height;	/**< Vertical Front Porch Size */
	vtcTiming.V1SyncWidth = vMode.vpe - vMode.vps;	/**< Vertical Sync Width */
	vtcTiming.V1BackPorch = vMode.vmax - vMode.vpe + 1;	/**< Horizontal Back Porch Size */
	vtcTiming.VSyncPolarity = vMode.vpol;	/**< Vertical Sync Polarity */
	vtcTiming.Interlaced = 0;		/**< Interlaced / Progressive video */


	/* Setup the VTC Source Select config structure. */
	/* 1=Generator registers are source */
	/* 0=Detector registers are source */
	memset((void *)&SourceSelect, 0, sizeof(SourceSelect));
	SourceSelect.VBlankPolSrc = 1;
	SourceSelect.VSyncPolSrc = 1;
	SourceSelect.HBlankPolSrc = 1;
	SourceSelect.HSyncPolSrc = 1;
	SourceSelect.ActiveVideoPolSrc = 1;
	SourceSelect.ActiveChromaPolSrc= 1;
	SourceSelect.VChromaSrc = 1;
	SourceSelect.VActiveSrc = 1;
	SourceSelect.VBackPorchSrc = 1;
	SourceSelect.VSyncSrc = 1;
	SourceSelect.VFrontPorchSrc = 1;
	SourceSelect.VTotalSrc = 1;
	SourceSelect.HActiveSrc = 1;
	SourceSelect.HBackPorchSrc = 1;
	SourceSelect.HSyncSrc = 1;
	SourceSelect.HFrontPorchSrc = 1;
	SourceSelect.HTotalSrc = 1;

	XVtc_SelfTest(InstancePtr);

	XVtc_RegUpdateEnable(InstancePtr);
	XVtc_SetGeneratorTiming(InstancePtr, &vtcTiming);
	XVtc_SetSource(InstancePtr, &SourceSelect);
	/*
	 * Enable VTC core, releasing backpressure on VDMA
	 */
	XVtc_EnableGenerator(InstancePtr);

	return 0 ;

}
