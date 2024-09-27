	.file	"main.c"
	.option pic
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"i"
	.align	2
.LC1:
	.string	"e"
	.align	2
.LC2:
	.string	"board: %s (id=%d)\n"
	.align	2
.LC3:
	.string	"rv32i_zicsr"
	.align	2
.LC4:
	.string	"Fri, 27 Sep 2024 08:36:41 +0700"
	.align	2
.LC5:
	.string	"build: %s for %s\n"
	.align	2
.LC6:
	.string	"core%d: "
	.align	2
.LC7:
	.string	"darkriscv@%dMHz w/ "
	.align	2
.LC8:
	.string	"rv32%s "
	.align	2
.LC9:
	.string	"MAC "
	.align	2
.LC10:
	.string	"\n"
	.align	2
.LC11:
	.string	"bram0: text@%d+%d data@%d+%d stack@%d\n"
	.align	2
.LC12:
	.string	"bram0: %d bytes free\n"
	.align	2
.LC13:
	.string	"uart0: 115.2kbps (div=%d)\n"
	.globl	__udivsi3
	.align	2
.LC14:
	.string	"timr0: %dHz (div=%d)\n"
	.align	2
.LC15:
	.string	"Welcome to DarkRISCV!\n"
	.align	2
.LC16:
	.string	"> "
	.align	2
.LC17:
	.string	"led"
	.align	2
.LC18:
	.string	"led flip!\n"
	.align	2
.LC19:
	.string	"reboot"
	.align	2
.LC20:
	.string	"rebooting...\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	s0,40(sp)
	la	s0,io
	lw	a5,0(s0)
	sw	ra,44(sp)
	sw	s1,36(sp)
	lbu	a0,0(a5)
	call	board_name@plt
	lw	a5,0(s0)
	mv	a1,a0
	.LA2: auipc	a0,%pcrel_hi(.LC2)
	lbu	a2,0(a5)
	addi	a0,a0,%pcrel_lo(.LA2)
	call	printf@plt
	.LA3: auipc	a2,%pcrel_hi(.LC3)
	.LA4: auipc	a1,%pcrel_hi(.LC4)
	.LA5: auipc	a0,%pcrel_hi(.LC5)
	addi	a2,a2,%pcrel_lo(.LA3)
	addi	a1,a1,%pcrel_lo(.LA4)
	addi	a0,a0,%pcrel_lo(.LA5)
	call	printf@plt
	lw	a5,0(s0)
	.LA6: auipc	a0,%pcrel_hi(.LC6)
	addi	a0,a0,%pcrel_lo(.LA6)
	lbu	a1,2(a5)
	call	printf@plt
	lw	a5,0(s0)
	.LA7: auipc	a0,%pcrel_hi(.LC7)
	addi	a0,a0,%pcrel_lo(.LA7)
	lbu	a1,1(a5)
	slli	a1,a1,1
	call	printf@plt
	call	check4rv32i@plt
	.LA1: auipc	a1,%pcrel_hi(.LC1)
	addi	a1,a1,%pcrel_lo(.LA1)
	beq	a0,zero,.L2
	.LA0: auipc	a1,%pcrel_hi(.LC0)
	addi	a1,a1,%pcrel_lo(.LA0)
.L2:
	.LA8: auipc	a0,%pcrel_hi(.LC8)
	addi	a0,a0,%pcrel_lo(.LA8)
	call	printf@plt
	li	a2,16
	li	a1,16
	li	a0,1000
	call	mac@plt
	li	a5,1256
	beq	a0,a5,.L16
.L3:
	.LA10: auipc	a0,%pcrel_hi(.LC10)
	addi	a0,a0,%pcrel_lo(.LA10)
	call	printf@plt
	la	a3,_data
	la	s0,_edata
	la	a1,_text
	la	s1,_stack
	.LA11: auipc	a0,%pcrel_hi(.LC11)
	la	a2,_etext
	sub	a4,s0,a3
	sub	a2,a2,a1
	mv	a5,s1
	addi	a0,a0,%pcrel_lo(.LA11)
	call	printf@plt
	.LA12: auipc	a0,%pcrel_hi(.LC12)
	sub	a1,s1,s0
	addi	a0,a0,%pcrel_lo(.LA12)
	call	printf@plt
	la	s1,io
	lw	a5,0(s1)
	.LA13: auipc	a0,%pcrel_hi(.LC13)
	addi	a0,a0,%pcrel_lo(.LA13)
	lhu	a1,6(a5)
	li	a5,-559038464
	addi	a5,a5,-273
	sw	a5,0(s0)
	call	printf@plt
	lw	a5,0(s1)
	la	s0,utimers
	addi	s1,sp,4
	lbu	a4,1(a5)
	lw	a1,12(a5)
	lw	a2,12(a5)
	slli	a5,a4,5
	sub	a5,a5,a4
	slli	a0,a5,6
	sub	a0,a0,a5
	slli	a0,a0,3
	add	a0,a0,a4
	addi	a1,a1,1
	slli	a0,a0,7
	sw	a2,0(sp)
	call	__udivsi3@plt
	lw	a2,0(sp)
	mv	a1,a0
	.LA14: auipc	a0,%pcrel_hi(.LC14)
	addi	a0,a0,%pcrel_lo(.LA14)
	call	printf@plt
	la	a5,io
	lw	a5,0(a5)
	li	a4,-128
	.LA15: auipc	a0,%pcrel_hi(.LC10)
	sb	a4,3(a5)
	addi	a0,a0,%pcrel_lo(.LA15)
	sw	zero,0(s0)
	call	printf@plt
	.LA16: auipc	a0,%pcrel_hi(.LC15)
	addi	a0,a0,%pcrel_lo(.LA16)
	call	printf@plt
.L9:
	.LA17: auipc	a0,%pcrel_hi(.LC16)
	addi	a0,a0,%pcrel_lo(.LA17)
	call	printf@plt
	li	a1,0
	li	a2,32
	mv	a0,s1
	call	memset@plt
	la	a5,io
	li	a1,999424
	lw	a4,0(a5)
	addi	a1,a1,575
	j	.L6
.L4:
	lbu	a5,4(a4)
	andi	a5,a5,2
	bne	a5,zero,.L17
.L6:
	lbu	a5,3(a4)
	slli	a5,a5,24
	srai	a5,a5,24
	bge	a5,zero,.L4
	lw	a5,0(s0)
	addi	a2,a5,-1
	sw	a2,0(s0)
	bne	a5,zero,.L5
	lhu	a5,8(a4)
	addi	a5,a5,1
	slli	a5,a5,16
	srli	a5,a5,16
	sh	a5,8(a4)
	sw	a1,0(s0)
.L5:
	li	a5,-128
	sb	a5,3(a4)
	lbu	a5,4(a4)
	andi	a5,a5,2
	beq	a5,zero,.L6
.L17:
	li	a1,32
	mv	a0,s1
	call	gets@plt
	.LA18: auipc	a1,%pcrel_hi(.LC17)
	addi	a1,a1,%pcrel_lo(.LA18)
	mv	a0,s1
	call	strcmp@plt
	beq	a0,zero,.L18
	.LA20: auipc	a1,%pcrel_hi(.LC19)
	addi	a1,a1,%pcrel_lo(.LA20)
	mv	a0,s1
	call	strcmp@plt
	bne	a0,zero,.L9
	.LA21: auipc	a0,%pcrel_hi(.LC20)
	addi	a0,a0,%pcrel_lo(.LA21)
	call	printf@plt
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	li	a0,0
	addi	sp,sp,48
	jr	ra
.L18:
	.LA19: auipc	a0,%pcrel_hi(.LC18)
	addi	a0,a0,%pcrel_lo(.LA19)
	call	printf@plt
	la	a5,io
	lw	a4,0(a5)
	lhu	a5,8(a4)
	not	a5,a5
	slli	a5,a5,16
	srli	a5,a5,16
	sh	a5,8(a4)
	j	.L9
.L16:
	.LA9: auipc	a0,%pcrel_hi(.LC9)
	addi	a0,a0,%pcrel_lo(.LA9)
	call	printf@plt
	j	.L3
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
