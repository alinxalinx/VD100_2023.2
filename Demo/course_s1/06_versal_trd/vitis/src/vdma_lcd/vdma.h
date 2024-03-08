
#ifndef VDMA_H_
#define VDMA_H_

#include "xaxivdma.h"


int vdma_read_init(short DeviceID, XAxiVdma *Vdma, short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr,int FrameNum);
int vdma_write_init(short DeviceID,XAxiVdma *Vdma,short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr, int FrameNum) ;
u32 vdma_version();

int vdma_write_stop(XAxiVdma *Vdma) ;
int vdma_write_start(XAxiVdma *Vdma) ;

int vdma_read_start(XAxiVdma *Vdma) ;
int vdma_read_stop(XAxiVdma *Vdma) ;

void VDMA_WriteStart(unsigned int Baseaddress, unsigned int bufaddr, unsigned int hsize, unsigned int stride, unsigned int vsize);
void VDMA_ReadStart(unsigned int Baseaddress, unsigned int bufaddr, unsigned int hsize, unsigned int stride, unsigned int vsize);

#endif /* VDMA_H_ */
