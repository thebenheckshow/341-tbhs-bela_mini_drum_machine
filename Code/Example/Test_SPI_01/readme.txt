g++ render.cpp SPI.c -ISPI_Library/ -I/root/Bela/include /root/Bela/core/Gpio.cpp /root/Bela/core/GPIOcontrol.cpp  -o spitest

this other dtb should make SPI transfers a bit faster by using DMA.
________________________________________
From: Giulio Moro
Sent: 26 April 2018 23:29
To: Felix Gardner; Astrid Bin
Cc: Corbeill, Karen
Subject: Re: A New Enquiry From shop.bela.io

> "/usr/include/linux/spidev/spi.h" is not present

Sorry that was "/usr/include/linux/spi/spidev.h"

> In the library SPI.h what does the following mean/do:

in /usr/include/linux/spidev/spi.h the SPI modes are different combinations of clock polarity and phase:

#define SPI_CPHA                0x01
#define SPI_CPOL                0x02

#define SPI_MODE_0              (0|0)
#define SPI_MODE_1              (0|SPI_CPHA)
#define SPI_MODE_2              (SPI_CPOL|0)
#define SPI_MODE_3              (SPI_CPOL|SPI_CPHA)

It does not really say what this means, I guess the answer is inside the driver implementation. I can have a look on the scope if I understand what they are.

> Here is an example of something we used SPI for to do pretty much the
> same thing in our mini pinball machine:

Is that Arduino code? It seems that one of the comments is wrong:

    digitalWrite(switchLatch, 1);  //Pulse LOW to latch the switch data
    digitalWrite(switchLatch, 0);

this seems to actually be pulsing HIGH.

If you need to do something like that, you can use regular Linux Gpio API. We have a convenient wrapper for that: get Bela/core/GPIOcontrol.cpp, Bela/core/Gpio.cpp, Bela/include/GPIOcontrol.h, Bela/include/Gpio.h then you can do

#include <Gpio.h>
#include <Utilities.h>

Gpio switchLatch;
switchLatch.open(65, OUTPUT);
....

{
  switchLatch.write(1);
  switchLatch.write(0);
}

the first parameter passed to Gpio::open() is the GPIO number you want to use. 65 is P2.17, you can also use 27 (P2.19) for ledLatch.

>    inputs = SPI.transfer16(value);

this looks like an SPI transfer with a word length of 16bit.

I am not familiar with the chips you are using, however, if I understand this correctly, try the attached program with the BeagleBoneSPI library: that should be equivalent to what you were doing in poll()
Compile and run (from within BeagleBone-SPI-Library/ ) with:

g++ Example/Spitest.cpp SPI_Library/SPI.c -ISPI_Library/ -I/root/Bela/include /root/Bela/core/Gpio.cpp /root/Bela/core/GPIOcontrol.cpp  -o spitest && ./spitest

It seems to work for me, attached source code and picture of the scope. From the bottom up:
ChipSelect, Clock, MOSI, switchLatch, ledLatch

Let me know if I can help with something else.
Best,
Giulio
