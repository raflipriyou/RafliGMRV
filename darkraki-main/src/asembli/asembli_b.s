.section .text
.global _start

_start:
    #li x5, 0x12
    beq x1, x2, 4
    beq x1, x2, 8
    #bne x2, x3, 4
    #blt x1, x2, 4
    #bge x1, x2, 8
    #bltu x3, x4, 4
    #bgeu x3, x4, 4
