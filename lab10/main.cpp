#include "mbed.h"

DigitalOut red_led(LED_RED);
DigitalOut green_led(LED_GREEN);

extern "C" void _blinky();

int main()
{
    
    while (1) {
        _blinky();// call assembly program
        wait(0.2f);
    }
    
}