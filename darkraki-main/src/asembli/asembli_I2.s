.section .text
.global _start

_start:  
    lb x1, 256(x0)
    lb x2, 256(x0)
    lb x3, 258(x0)
    lh x4, 260(x0)
    lw x5, 264(x0)
    lbu x6, 268(x0)
    lhu x7, 272(x0)
    