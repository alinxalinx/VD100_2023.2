#!/bin/sh

PS_LED=475
PS_KEY=474

#set up LED gpio
if [[ ! -e /sys/class/gpio/gpio"$PS_LED" ]];then
	echo $PS_LED >> /sys/class/gpio/export 
fi
echo out >> /sys/class/gpio/gpio"$PS_LED"/direction

#set up KEY gpio
if [[ ! -e /sys/class/gpio/gpio"$PS_KEY" ]];then
	echo $PS_KEY >> /sys/class/gpio/export
fi
echo in >> /sys/class/gpio/gpio"$PS_KEY"/direction

#push PS_KEY to contorl PS_LED
PS_LED_STS=0
PL_LED_STS=0

echo -e "\e[1;32mLEDs and KEYs set OK, now you can click the KEYs to light up or turn off the LEDs\e[0m"

while ((1))
do
	#read key value
	PS_KEY_STS=`cat /sys/class/gpio/gpio"$PS_KEY"/value`
	if [ $PS_KEY_STS -eq 0 ];then
		PS_LED_STS=$((!PS_LED_STS))
		#set led out value
		echo $PS_LED_STS >> /sys/class/gpio/gpio"$PS_LED"/value
		while (($((!PS_KEY_STS))))
		do
			#wait key release
			PS_KEY_STS=`cat /sys/class/gpio/gpio"$PS_KEY"/value`
		done
	fi

        PL_KEY_STS=`devmem 0x80030000`
	let "PL_KEY_STS=$PL_KEY_STS&1"
        if [ $PL_KEY_STS -eq 0 ];then
                PL_LED_STS=$((!PL_LED_STS))
                #set led out value
                devmem 0x80040000 32 $PL_LED_STS
                while (($((!PL_KEY_STS))))
                do
                        #wait key release
                        PL_KEY_STS=`devmem 0x80030000`
			let "PL_KEY_STS=$PL_KEY_STS&1"
                done
        fi
done




