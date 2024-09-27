.section .text
.global _start

_start:
    lui x1, 0x54321      # Load upper immediate 0xabcde into x1
    auipc x2, 0x12345    # Load upper immediate 0x12345 into x2 and add the current PC
    auipc x5, 0x11223    # Load upper immediate 0x12345 into x2 and add the current PC
    sw x1, 256(x0)       # Store the value of x1 into memory at address 256
    lw x7, 256(x0)
    sw x2, 260(x0)       # Store the value of x2 into memory at address 260
    lw x3, 260(x0)
    sw x2, 264(x0)
