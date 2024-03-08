#!/bin/sh

value=$(cat /sys/bus/i2c/devices/2-0048/hwmon/hwmon0/temp1_input)
let "value_int=$value/1000"
let "value_dec=$value%1000"
echo temperature is $value_int.$value_dec°C
