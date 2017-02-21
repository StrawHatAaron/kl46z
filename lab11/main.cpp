#include "mbed.h"

DigitalOut a(LED_GREEN);
DigitalOut b(LED_RED);
DigitalIn c(SW3);
DigitalIn d(SW1);

Serial pc(USBTX, USBRX);

extern "C" void _manage();

int main()
{
    a=1;
    b=1;
    while (true) {
        _manage();
        /*
        pc.printf("RETURN VALUE: %d\r\n" ,_manage());
        if (!_manage()){
            a = !a;
            }
        */
        wait(0.1f);
    }
}