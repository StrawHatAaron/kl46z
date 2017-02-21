GPIOD_BASE EQU  0x400FF0C0
GPIOE_BASE EQU  0x400FF100

GPIO_PSOR  EQU  0x04   ; Port Set Output Register, offset: 0x4
GPIO_PCOR  EQU  0x08   ; Port Clear Output Register, offset: 0x8

    AREA nums, DATA, READWRITE
num DCD 0xAAAAAAAA

    AREA redgreenBlink, CODE, READONLY
    EXPORT  _blinky
_blinky
    PUSH {R4-R7}
    LDR     R3, =num
    LDR     R4, [R3]
    LDR     R5, =1
    RORS    R4, R4, R5
    STR     R4, [R3]
    BCS     carryflagset          ;branch if carry flag set 
    LDR     R1, =GPIOD_BASE
    LDR     R2, =(1<<5)
    STR     R2, [R1, #GPIO_PSOR]
    LDR     R1, =GPIOE_BASE
    LDR     R2, =(1<<29)
    STR     R2, [R1, #GPIO_PCOR]
    POP {R4-R7}
    BX LR
carryflagset
    LDR     R1, =GPIOD_BASE
    LDR     R2, =(1<<5)
    STR     R2, [R1, #GPIO_PCOR]
    LDR     R1, =GPIOE_BASE
    LDR     R2, =(1<<29)
    STR     R2, [R1, #GPIO_PSOR]
    POP {R4-R7}
    BX LR
    END