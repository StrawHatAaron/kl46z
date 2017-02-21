//this project was worked on by Jose Gonzales and Aaron Miller at the same time

#include "mbed.h"
#define STATE_FLASH 0x0
#define STATE_READ  0x1
#define STATE_LOSE  0x2
#define STATE_WIN   0x3

//init
extern "C" void init_red();
extern "C" void init_green();
extern "C" void init_button1();
extern "C" void init_button2();
extern "C" void _random();

extern "C" int entrypoint();

Serial pc(USBTX, USBRX);

int main()
{
    init_red();
    init_green();
    init_button1();
    init_button2();
    //set the stage
    
    while (1){
        wait(0.10f);
        entrypoint();
    }        
}
