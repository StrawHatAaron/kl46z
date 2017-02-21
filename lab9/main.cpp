#include "mbed.h"

// include our random number function
extern "C" int _random();

// Initialize the USB serial port so we can output
Serial pc(USBTX, USBRX);

// our main
int main()
{
    int i;
    pc.baud(9600); // set the serial baud rate

    for (i = 0; i < 10; ++i) {
        pc.printf("0x%08x\r\n", _random());
        
        
    }

    return 0;
}