	.file	"tester.c"
	.option pic
	.text
	.align	2
	.globl	getFib
	.type	getFib, @function
getFib:
	ble	a0,zero,.L6
	addi	a4,a0,1
	li	a5,1
	li	a3,2
	li	a6,1
	j	.L5
.L11:
	mv	a1,a2
	mv	a2,a0
.L4:
	addi	a5,a5,1
	beq	a5,a4,.L10
.L5:
	add	a0,a1,a2
	bgt	a5,a3,.L11
	mv	a0,a1
	beq	a5,a6,.L4
	addi	a5,a5,1
	mv	a0,a2
	bne	a5,a4,.L5
.L10:
	ret
.L6:
	li	a0,-1
	ret
	.size	getFib, .-getFib
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	li	a3,1
	li	a2,0
	li	a5,1
	li	a1,2
	li	a6,15
.L15:
	addi	a4,a5,1
	bleu	a5,a1,.L13
	add	a0,a2,a3
	beq	a4,a6,.L12
	mv	a2,a3
	mv	a3,a0
.L13:
	mv	a5,a4
	j	.L15
.L12:
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
