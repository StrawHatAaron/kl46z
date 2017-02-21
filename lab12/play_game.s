STATE_FLASH EQU 0x0
STATE_READ  EQU 0x1
STATE_LOSE  EQU 0x2
STATE_WIN   EQU 0x3

NUM_ROUNDS  EQU 8

REDSHIFT   EQU  29  ;on E
GREENSHIFT EQU  5   ;on D

PORT_PCR12 EQU 0x30
PORTA_BASE EQU 0x40049000
PORTB_BASE EQU 0x4004A000
PORTC_BASE EQU 0x4004B000
PORTD_BASE EQU 0x4004C000
PORTE_BASE EQU 0x4004D000
PTA_BASE EQU 0x400FF000
PTB_BASE EQU 0x400FF040
PTC_BASE EQU 0x400FF080
PTD_BASE EQU 0x400FF0C0
PTE_BASE EQU 0x400FF100
SIM_BASE EQU 0x40047000
SIM_SCGC5 EQU 0x1038 

PORT_PCR29 EQU 0x74 
PORT_PCR3 EQU 0x0C
PORT_PCR5 EQU 0x14 
PORT_PCR_MUX_MASK EQU 0x700
PORT_PCR_MUX_SHIFT EQU 8
SIM_SCGC5_LPTMR_MASK EQU 0x1
SIM_SCGC5_LPTMR_SHIFT EQU 0
SIM_SCGC5_PORTA_MASK EQU 0x200
SIM_SCGC5_PORTA_SHIFT EQU 9
SIM_SCGC5_PORTB_MASK EQU 0x400
SIM_SCGC5_PORTB_SHIFT EQU 10
SIM_SCGC5_PORTC_MASK EQU 0x800
SIM_SCGC5_PORTC_SHIFT EQU 11
SIM_SCGC5_PORTD_MASK EQU 0x1000
SIM_SCGC5_PORTD_SHIFT EQU 12
SIM_SCGC5_PORTE_MASK EQU 0x2000
SIM_SCGC5_PORTE_SHIFT EQU 13
GPIOA_BASE EQU 0x400FF000
GPIOB_BASE EQU 0x400FF040
GPIOC_BASE EQU 0x400FF080
GPIOD_BASE EQU 0x400FF0C0
GPIOE_BASE EQU 0x400FF100
GPIO_PDOR EQU 0x00 ; Port Data Output Register, offset: 0x0
GPIO_PSOR EQU 0x04 ; Port Set Output Register, offset: 0x4
GPIO_PCOR EQU 0x08 ; Port Clear Output Register, offset: 0x8
GPIO_PTOR EQU 0x0C ; Port Toggle Output Register, offset: 0xC
GPIO_PDIR EQU 0x10 ; Port Data Input Register, offset: 0x10
GPIO_PDDR EQU 0x14 ; Port Data Direction Register, offset: 0x14

   AREA allthisdata, DATA, READWRITE
m_z DCD 0x4626
m_w DCD 0x6558
random DCD 0x0000  ;the original random number
shifted DCD 0x0000 ;the partially-shifted version of random
counter DCD 1      ;what round we're on
countdown DCD 1    ;what digit we're on in this round
state   DCD STATE_FLASH

;for readinput
b0wasdown DCD 0 ;the one on the same side as the green one
b1wasdown DCD 0

    AREA allthiscode, CODE, READONLY
    EXPORT entrypoint
entrypoint
    LDR     R0, =random
    LDR     R0,[R0]
    MOVS    R0, R0
    BEQ _random
    LDR     R0, =state
    LDR     R0,[R0]
    MOVS    R0, R0
    BEQ flashpattern
    SUBS    R0, #1
    BEQ readinput
    SUBS    R0, #1
    BEQ loser
    SUBS    R0, #1
    BEQ winner
    
_random
    LDR  R1, =0xAAAAAAAA
    LDR  R0, =shifted
    LDR  R2, =random
    STR  R1, [R0]
    STR  R1, [R2]
    BX LR
    
    PUSH {R4, R5}
    ;thats how you do it right? everything will be okay right?
    LDR R4, =0x0000FFFF
    LDR R3, =m_z
    LDR R3, [R3]
    MOV R2, R3
    MOV R1, R3
                        ;R1R2R3 now hold m_z I think
    LSRS R1, #16        ;R1 is (m_z >> 16) unless im sorely mistaken    
    ANDS R2, R4         ;R2 is (m_z & 0xFFFF) hopefully
    LDR R4, =0x9069
    MULS R4, R2, R4     ;R4 is 0x9069 * (m_z & 0xFFFF)
    ADDS R4, R1         ;R4 is now  0x9069 * (m_z & 0xFFFF) + (m_z >> 16)
    MOV R5, R4          ;put it in R5 so we dont lose it
    
    LDR R4, =0x0000FFFF
    LDR R3, =m_w
    LDR R3, [R3]
    MOV R2, R3
    MOV R1, R3    
                        ;R1R2R3 now hold m_w I think
    LSRS R1, #16        ;R1 is (m_w >> 16) unless im sorely mistaken
    ANDS R2, R4         ;R2 is (m_w & 0xFFFF) hopefully
    LDR R4, =0x4650
    MULS R4, R2, R4     ;R4 is 0x4650 * (m_w & 0xFFFF)
    ADDS R4, R1         ;R4 is now  0x4650 * (m_w & 0xFFFF) + (m_w >> 16)
    LDR R1, =m_w
    STR R4, [R1]
    LDR R1, =m_z
    STR R5, [R1]
    
    LSLS R0, R5, #16
    ADDS R0, R4
    
    LDR R2, =shifted
    LDR R1, =random
    STR R0, [R1]
    STR R0, [R2]
                        ;k were done put it back like we found it
    POP {R4, R5}
    B entrypoint
;***********************************************   
flashpattern
    LDR     R2, =shifted
    LDR     R0, [R2]
    MOVS    R1, #1
    RORS    R0, R0, R1
    STR     R0, [R2]
    BCC greenOnRedOff 
;carry was clear
    LDR R0, =GPIOD_BASE
    LDR R1, =(1<<GREENSHIFT)
    STR R1, [R0, #GPIO_PCOR] 
    ;green is set to turn on now
    LDR R0, =GPIOE_BASE 
    LDR R1, =(1<<REDSHIFT)
    STR R1, [R0, #GPIO_PSOR]
    ;red is set to turn off now
    B exitflash
greenOnRedOff
;okay, if were in here, carry was set, turn off green and turn red on.
    LDR R0, =GPIOD_BASE
    LDR R1, =(1<<GREENSHIFT)
    STR R1, [R0, #GPIO_PSOR] 
    ;green is set to turn off now
    LDR R0, =GPIOE_BASE 
    LDR R1, =(1<<REDSHIFT)
    STR R1, [R0, #GPIO_PCOR]
    ;red is set to turn on now
    B exitflash
    
exitflash
    LDR     R1, =countdown
    LDR     R2, [R1]
    SUBS    R2, #1
    STR     R2, [R1]
    BEQ     doneflashing
    MOVS    R0, #STATE_FLASH
    LDR     R1, =state
    STR     R0, [R1]
    BX LR
doneflashing
    MOVS    R0, #STATE_READ
    LDR     R1, =state
    STR     R0, [R1]
    BX LR
;***********************
winner 
    LDR R0, =GPIOD_BASE
    LDR R1, =(1<<5)
    STR R1, [R0, #GPIO_PTOR]
    BX LR
;************************************
loser
    LDR R0, =GPIOE_BASE
    LDR R1, =(1<<29)
    STR R1, [R0, #GPIO_PTOR]
    BX LR
;**********************
readinput    
    ;turn off the lights.
    LDR R0, =GPIOE_BASE 
    LDR R1, =(1<<REDSHIFT)
    STR R1, [R0, #GPIO_PSOR]
    LDR R0, =GPIOD_BASE
    LDR R1, =(1<<GREENSHIFT)
    STR R1, [R0, #GPIO_PSOR] 

    ;check button 0 first
    LDR R0, =GPIOC_BASE
    LDR R0, [R0, #GPIO_PDIR]
    LDR R1, =(1<<3)
    TST R0, R1
    BEQ buttondown0
    ;button is up if we get here! if it was down previously, toggle the green light.
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
    LDR R2, =0;
    B   buttonevent
buttondown0
    ;button is down here.
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
    LDR R0, =STATE_READ
    LDR     R1, =state
    STR     R0, [R1]
    BX LR
toggle1
    LDR R0, =b1wasdown
    LDR R1, =0
    STR R1, [R0]
    LDR R2, =1
    B   buttonevent
buttondown1
    LDR R0, =b1wasdown
    LDR R1, =1
    STR R1, [R0]
    LDR R0, =STATE_READ
    LDR     R1, =state
    STR     R0, [R1]
    BX LR    
        
buttonevent ;r2 currently holds which button was hit
    LDR     R1, =random
    LDR     R1, [R1]    ;random holds the correct pattern.
    SUBS    R0, R2, #1
    BNE     b1event
b0event
    MVNS    R1, R1 ;if we caught button 0 random=!random, so that we can match 0's with 0's
b1event
    LDR     R0, =1
    LDR     R3, =countdown
    LDR     R3, [R3]
    LSLS    R0, R0, R3   ;R0 now masks the current bit being compared to the input
    TST     R1, R0
    BNE     goodbutton
badbutton
    MOVS    R0, #STATE_LOSE
    LDR     R1, =state
    STR     R0, [R1]
    BX LR
goodbutton
    LDR     R3, =countdown
    LDR     R3, [R3]
    ADDS    R3, #1          ;hopefully this still has countdown in it
    LDR     R2, =countdown
    STR     R3, [R2]        ;store countdown, its ready for next call
    
    LDR     R0, =counter
    LDR     R1, [R0]        
                            ;r3 holds countdown, r1 holds counter
    SUBS    R3, R1          ;are they equal?
    BEQ     scored
stillinputting
    MOVS    R0, #STATE_READ
    LDR     R1, =state
    STR     R0, [R1]
    BX LR
scored
    LDR     R0, =counter   
    LDR     R1, [R0]        
    ADDS    R1, #1          
    STR     R1, [R0]        ;store counter + 1 to counter
    LDR     R2, =countdown
    STR     R1, [R2]        ;and countdown
    
    MOVS    R0, #NUM_ROUNDS
    SUBS    R1, R0
    LDR     R0, =state
    LDR     R1, =STATE_WIN
    STR     R1, [R0]
    BEQ winner
    
    LDR     R0, =shifted
    LDR     R1, =random
    LDR     R1, [R1]
    STR     R1, [R0]
    
    
    MOVS    R0, #STATE_FLASH
    LDR     R1, =state
    STR     R0, [R1]
    BX LR
;***********************************************

    ALIGN
    END
    