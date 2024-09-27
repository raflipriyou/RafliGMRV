.section .text
.global _start

_start:  
    addi x1, x2, 3
    addi x3, x1, 1
    xori x2, x3, 3
    ori x3, x2, 5
    andi x4, x5, 6
    slli x5, x6, 7
    srli x6, x7, 8
    srai x7, x8, 9
    slti x8, x9, 10 
    sltiu x9, x10, 11