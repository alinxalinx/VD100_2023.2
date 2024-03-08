/*
FILENAME: demosaic.c
AUTHOR: Greg Taylor     CREATION DATE: 12 Aug 2019

DESCRIPTION:

CHANGE HISTORY:
12 Aug 2019		Greg Taylor
	Initial version

MIT License

Copyright (c) 2019 Greg Taylor <gtaylor@sonic.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
#include "xv_demosaic.h"

#include "demosaic.h"

int demosaic_init(u32 BaseAddr,u32 width, u32 height) {
	XV_demosaic demosaic;
	XV_demosaic_Config demosaic_config;

	demosaic_config.DeviceId = 0;
	demosaic_config.BaseAddress = BaseAddr;
	demosaic_config.MaxDataWidth = 10;
	demosaic_config.MaxHeight = 2160;
	demosaic_config.MaxWidth = 3840;
	demosaic_config.PixPerClk = 4;
	demosaic_config.Algorithm = 0;

//	if ( (demosaic_config = XV_demosaic_LookupConfig(DeviceId)) == NULL) {
//		xil_printf("XV_demosaic_LookupConfig() failed\r\n");
//		return XST_FAILURE;
//	}
	if (XV_demosaic_CfgInitialize(&demosaic, &demosaic_config, demosaic_config.BaseAddress)
			!= XST_SUCCESS) {
		xil_printf("XV_demosaic_CfgInitialize() failed\r\n");
		return XST_FAILURE;
	}

	XV_demosaic_Set_HwReg_width(&demosaic, width);
	XV_demosaic_Set_HwReg_height(&demosaic, height);
	XV_demosaic_Set_HwReg_bayer_phase(&demosaic, 0);

	if (!XV_demosaic_IsReady(&demosaic)) {
		xil_printf("demosaic core not ready\r\n");
		return XST_FAILURE;
	}
	XV_demosaic_EnableAutoRestart(&demosaic);
	XV_demosaic_Start(&demosaic);

	xil_printf("Demosiac module initialized\r\n");

	return XST_SUCCESS;
}
