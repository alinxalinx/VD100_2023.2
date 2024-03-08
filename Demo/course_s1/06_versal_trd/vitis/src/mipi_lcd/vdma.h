
#ifndef VDMA_H_
#define VDMA_H_

#include "xaxivdma.h"


int vdma_read_init(u32 DeviceID, XAxiVdma *Vdma, short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr,int FrameNum);
int vdma_write_init(u32 DeviceID,XAxiVdma *Vdma,short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr, int FrameNum) ;
u32 vdma_version();

int vdma_write_stop(XAxiVdma *Vdma) ;
int vdma_write_start(XAxiVdma *Vdma) ;

int vdma_read_start(XAxiVdma *Vdma) ;
int vdma_read_stop(XAxiVdma *Vdma) ;

#endif /* VDMA_H_ */
