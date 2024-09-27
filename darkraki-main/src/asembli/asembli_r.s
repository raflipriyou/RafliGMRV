.section .text
.global _start

_start:  
    add x1, x2, x3
    sub x2, x3, x4
    xor x3, x4, x5
    or x4, x5, x6
    and x5, x6, x7
    sll x6, x7, x8
    srl x7, x8, x9
    sra x8, x9, x10
    slt x9, x10, x11
    sltu x10, x11, x12