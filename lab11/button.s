;TOGGLING LIGHTS WITH BUTTONS
;A COLLABORATIVE EFFORT BETWEEN AARON MILLER (amiller35) AND JOSE GONZALES (jgonzales11)

GPIOC_BASE EQU  0x400FF080
GPIOD_BASE EQU  0x400FF0C0
GPIOE_BASE EQU  0x400FF100

GPIO_PDIR  EQU  0x10   ; Port Data Input Register, offset: 0x10
GPIO_PTOR  EQU  0x0C   ; Port Toggle Output Register, offset: 0xC

    AREA garagefullofstuff, DATA, READWRITE
b0wasdown DCD 0 ;the one on the same side as the green one
b1wasdown DCD 0

    AREA tenpointsofhomework, CODE, READONLY
    EXPORT _manage
_manage
    ;check button 0 first
    LDR R0, =GPIOC_BASE
    LDR R0, [R0, #GPIO_PDIR]
    LDR R1, =(1<<3)
    TST R0, R1
    BEQ buttondown0
    ;button is up! if it was down previously, toggle the green light.
    LDR R0, =b0wasdown
    LDR R0, [R0]
    LDR R1, =1
    TST R0, R1
    BNE toggle0
    B   checkbutton1
toggle0
    LDR R0, =b0wasdown
    LDR R1, =0
    STR R1, [R0]
    LDR R0, =GPIOD_BASE
    LDR R1, =(1<<5)
    STR R1, [R0, #GPIO_PTOR]
    B   checkbutton1
buttondown0
    LDR R0, =b0wasdown
    LDR R1, =1
    STR R1, [R0]
    LDR R0, =0
    B   checkbutton1

;check button 1 now
checkbutton1
    LDR R0, =GPIOC_BASE
    LDR R0, [R0, #GPIO_PDIR]
    LDR R1, =(1<<12)
    TST R0, R1
    BEQ buttondown1
    ;button is up! if it was down previously, toggle the red light.
    LDR R0, =b1wasdown
    LDR R0, [R0]
    LDR R1, =1
    TST R0, R1
    BNE toggle1
    BX LR
toggle1
    LDR R0, =b1wasdown
    LDR R1, =0
    STR R1, [R0]
    LDR R0, =GPIOE_BASE
    LDR R1, =(1<<29)
    STR R1, [R0, #GPIO_PTOR]
    BX LR
buttondown1
    LDR R0, =b1wasdown
    LDR R1, =1
    STR R1, [R0]
    LDR R0, =0
    BX LR

    END