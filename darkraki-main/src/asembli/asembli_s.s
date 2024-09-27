.section .text
.global _start

_start:  
    lb x1, 256(x0)
    lui x1, 0xbc6      
    addi x1, x1, 0x14e
    sb x1, 256(x0)
    sh x1, 260(x0)
    sw x1, 264(x0)
    