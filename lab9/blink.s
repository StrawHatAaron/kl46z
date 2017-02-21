;Aaron Miller
; Peripheral registers

GPIOA_BASE             EQU  0x400FF000
GPIOB_BASE             EQU  0x400FF040
GPIOC_BASE             EQU  0x400FF080
GPIOD_BASE             EQU  0x400FF0C0
GPIOE_BASE             EQU  0x400FF100

GPIO_PDOR  EQU  0x00   ; Port Data Output Register, offset: 0x0
GPIO_PSOR  EQU  0x04   ; Port Set Output Register, offset: 0x4
GPIO_PCOR  EQU  0x08   ; Port Clear Output Register, offset: 0x8
GPIO_PTOR  EQU  0x0C   ; Port Toggle Output Register, offset: 0xC
GPIO_PDIR  EQU  0x10   ; Port Data Input Register, offset: 0x10
GPIO_PDDR  EQU  0x14   ; Port Data Direction Register, offset: 0x14

PORTA_BASE             EQU  0x40049000
PORTB_BASE             EQU  0x4004A000
PORTC_BASE             EQU  0x4004B000
PORTD_BASE             EQU  0x4004C000
PORTE_BASE             EQU  0x4004D000

PORT_PCR0    EQU  0x00   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR1    EQU  0x04   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR2    EQU  0x08   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR3    EQU  0x0C   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR4    EQU  0x10   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR5    EQU  0x14   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR6    EQU  0x18   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR7    EQU  0x1C   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR8    EQU  0x20   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR9    EQU  0x24   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR10   EQU  0x28   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR11   EQU  0x2C   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR12   EQU  0x30   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR13   EQU  0x34   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR14   EQU  0x38   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR15   EQU  0x3C   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR16   EQU  0x40   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR17   EQU  0x44   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR18   EQU  0x48   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR19   EQU  0x4C   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR20   EQU  0x50   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR21   EQU  0x54   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR22   EQU  0x58   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR23   EQU  0x5C   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR24   EQU  0x60   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR25   EQU  0x64   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR26   EQU  0x68   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR27   EQU  0x6C   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR28   EQU  0x70   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR29   EQU  0x74   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR30   EQU  0x78   ; Pin Control Register n, array offset: 0x0, array step: 0x4
PORT_PCR31   EQU  0x7C   ; Pin Control Register n, array offset: 0x0, array step: 0x4

; PCR Bit Fields
PORT_PCR_PS_MASK         EQU  0x1
PORT_PCR_PS_SHIFT        EQU  0
PORT_PCR_PE_MASK         EQU  0x2
PORT_PCR_PE_SHIFT        EQU  1
PORT_PCR_SRE_MASK        EQU  0x4
PORT_PCR_SRE_SHIFT       EQU  2
PORT_PCR_PFE_MASK        EQU  0x10
PORT_PCR_PFE_SHIFT       EQU  4
PORT_PCR_ODE_MASK        EQU  0x20
PORT_PCR_ODE_SHIFT       EQU  5
PORT_PCR_DSE_MASK        EQU  0x40
PORT_PCR_DSE_SHIFT       EQU  6
PORT_PCR_MUX_MASK        EQU  0x700
PORT_PCR_MUX_SHIFT       EQU  8
PORT_PCR_LK_MASK         EQU  0x8000
PORT_PCR_LK_SHIFT        EQU  15
PORT_PCR_IRQC_MASK       EQU  0xF0000
PORT_PCR_IRQC_SHIFT      EQU  16
PORT_PCR_ISF_MASK        EQU  0x1000000
PORT_PCR_ISF_SHIFT       EQU  24

; Pin Control Register (PCR)
; 000 = Pin disabled (analog)
; 001 = Alternative 1 (GPIO)
; 010 = Alternative 2
; 011 = Alternative 3
; 100 = Alternative 4
; 101 = Alternative 5
; 110 = Alternative 6
; 111 = Alternative 7

SIM_BASE    EQU  0x40047000
SIM_SCGC5   EQU  0x1038   ; System Clock Gating Control Register 5, offset: 0x1038

; SCGC5 Bit Fields
SIM_SCGC5_LPTMR_MASK     EQU  0x1
SIM_SCGC5_LPTMR_SHIFT    EQU  0
SIM_SCGC5_PORTA_MASK     EQU  0x200
SIM_SCGC5_PORTA_SHIFT    EQU  9
SIM_SCGC5_PORTB_MASK     EQU  0x400
SIM_SCGC5_PORTB_SHIFT    EQU  10
SIM_SCGC5_PORTC_MASK     EQU  0x800
SIM_SCGC5_PORTC_SHIFT    EQU  11
SIM_SCGC5_PORTD_MASK     EQU  0x1000
SIM_SCGC5_PORTD_SHIFT    EQU  12
SIM_SCGC5_PORTE_MASK     EQU  0x2000
SIM_SCGC5_PORTE_SHIFT    EQU  13

;
    AREA asm_func, CODE, READONLY

; Export the blink function location so that C compiler can find it and link
    EXPORT blink_run
blink_run
;
; Load GPIO Port E 
    LDR     R1, =GPIOE_BASE
; value passed from C compiler code is in R0 - compare to a "0" 
    CMP     R0, #0          ; value == 0 ?
    BEQ     seton
; Move bit mask in register R2 for bit 29 only
    LDR     R2, =(1<<29) 
    STR     R2, [R1,#GPIO_PSOR]
    B       done
seton
; Move bit mask in register R2 for bit 29 only
    LDR     R2, =(1<<29) 
    STR     R2, [R1,#GPIO_PCOR]
done
    BX      LR
    
    EXPORT blink_init
blink_init
    ; System Clock Gating Control Register (SCGC)
    ; Enable Clock of GPIO Port E
    LDR     R1, =SIM_BASE    ; Base address
    LDR     R2, =SIM_SCGC5   ; Offset
    LDR     R3, =SIM_SCGC5_PORTE_MASK
    ORRS    R0, R0, R3
    STR     R0, [R1, R2]
    
    ; Set PORTE bit 29 as General GPIO pin  
    LDR     R1, =PORTE_BASE
    LDR     R0, [R1, #PORT_PCR29]
    LDR     R2, =~PORT_PCR_MUX_MASK
    ANDS    R0, R0, R2
    LDR     R2, =(0x001<<PORT_PCR_MUX_SHIFT) 
    ORRS    R0, R0, R2
    LDR     R2, =~0x03
    ANDS    R0, R0, R2
    STR     R0, [R1, #PORT_PCR29]
    
    ; Set PORTE bit 29 Data Direction Register (PDDR)
    ; 0 = digital input, 1 = digital output
    LDR     R1, =GPIOE_BASE
    LDR     R0, [R1, #GPIO_PDDR]
    LDR     R2, =(1<<29)
    ORRS    R0, R0, R2    ; PTB 29 as output
    STR     R0, [R1, #GPIO_PDDR]

    ; Clear Set PORTE bit 29 output
    LDR     R1, =GPIOE_BASE
    LDR     R2, =(1<<29) 
    STR     R2, [R1,#GPIO_PCOR]

    BX      LR
;
    ALIGN
    END
