#!/bin/sh
eth="eth1"
if [[ $eth == "" ]];then
        echo "para err!"
        exit
fi

if [[ $eth != "eth0" ]] && [[ $eth != "eth1" ]];then
        echo "para err!"
        exit
fi

TSEL=3
TINV=0
RSEL=0
RRSEL=1
RINV=0

ifconfig $eth up
mdio_rw $eth 1 0x1f 0xab
VALUE=`mdio_rw $eth 1 0x10`
VALUE=$(echo "$VALUE" | awk -F'value : ' '{print $2}' | awk '{print $1}' | grep 0x)
let "VALUE=$VALUE&0x81FF"
let "VALUE=$VALUE|(($TINV<<14)&0x4000)|(($TSEL<<12)&0x3000)|(($RINV<<11)&0x0800)|(($RSEL<<9)&0x0600)"
mdio_rw $eth 1 0x10 $VALUE
VALUE=`mdio_rw $eth 1 0x11`
VALUE=$(echo "$VALUE" | awk -F'value : ' '{print $2}' | awk '{print $1}' | grep 0x)
let "VALUE=$VALUE&0xFFFE"
let "VALUE=$VALUE|($RRSEL&0x01)"
mdio_rw $eth 1 0x11 $VALUE
echo ====================================== > /dev/ttyAMA0
VALUE=`mdio_rw $eth 1 0x10`
VALUE=$(echo "$VALUE" | awk -F'value : ' '{print $2}' | awk '{print $1}' | grep 0x)
let "VALUE=$VALUE&0x81FF"
let "VALUE=$VALUE|(($TINV<<14)&0x4000)|(($TSEL<<12)&0x3000)|(($RINV<<11)&0x0800)|(($RSEL<<9)&0x0600)"
mdio_rw $eth 1 0x10 $VALUE
VALUE=`mdio_rw $eth 1 0x11`
VALUE=$(echo "$VALUE" | awk -F'value : ' '{print $2}' | awk '{print $1}' | grep 0x)
let "VALUE=$VALUE&0xFFFE"
let "VALUE=$VALUE|($RRSEL&0x01)"
mdio_rw $eth 1 0x11 $VALUE
echo ====================================== > /dev/ttyAMA0

