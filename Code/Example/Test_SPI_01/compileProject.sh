
#! /bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Go away and find an argument, then try again later.'
    exit 1
fi

source=${1}
binary=${1%.*}

g++ $source SPI.c -ISPI_Library/ -I/root/Bela/include /root/Bela/core/Gpio.cpp /root/Bela/core/GPIOcontrol.cpp  -o $binary

echo Now try the program . . .

./$binary
