#!/bin/sh

#MIPI0
devmem 0x80080030 32 4
while ((1))
do
	REG_VALUE=`devmem 0x80080030 32`
	let "REG_VALUE=$REG_VALUE&4"
	if [ $REG_VALUE -ne 4 ];then
		break
	fi
done
devmem 0x80080030 32 0
devmem 0x80080034 32 0xFFFFFFFF
devmem 0x800800AC 32 0x30000000
devmem 0x800800A4 32 0x960
devmem 0x800800A8 32 0x00000960

REG_VALUE=`devmem 0x80080030 32`
let "REG_VALUE=$REG_VALUE|1"
devmem 0x80080030 32 $REG_VALUE

while ((1))
do
	REG_VALUE=`devmem 0x80080034 32`
	let "REG_VALUE=$REG_VALUE&1"
	if [ $REG_VALUE -ne 1 ];then
		break
	fi
done
devmem 0x800800A0 32 600

#MIPI1
devmem 0x80000030 32 4
while ((1))
do
        REG_VALUE=`devmem 0x80000030 32`
        let "REG_VALUE=$REG_VALUE&4"
        if [ $REG_VALUE -ne 4 ];then
                break
        fi
done
devmem 0x80000030 32 0
devmem 0x80000034 32 0xFFFFFFFF
devmem 0x800000AC 32 0x33000000
devmem 0x800000A4 32 0x960
devmem 0x800000A8 32 0x00000960

REG_VALUE=`devmem 0x80000030 32`
let "REG_VALUE=$REG_VALUE|1"
devmem 0x80000030 32 $REG_VALUE

while ((1))
do
        REG_VALUE=`devmem 0x80000034 32`
        let "REG_VALUE=$REG_VALUE&1"
        if [ $REG_VALUE -ne 1 ];then
                break
        fi
done
devmem 0x800000A0 32 600



echo vdma init over .
