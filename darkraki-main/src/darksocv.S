
darksocv.o:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	800005b7          	lui	a1,0x80000
   4:	0025c603          	lbu	a2,2(a1) # 80000002 <_global+0x7fffe8f2>

00000008 <_thread_lock>:
   8:	00061063          	bnez	a2,8 <_thread_lock>
   c:	800005b7          	lui	a1,0x80000
  10:	00058503          	lb	a0,0(a1) # 80000000 <_global+0x7fffe8f0>
  14:	04050663          	beqz	a0,60 <_normal_boot>
  18:	07500513          	li	a0,117
  1c:	0c4000ef          	jal	ra,e0 <_uart_putchar>
  20:	00001697          	auipc	a3,0x1
  24:	f286a683          	lw	a3,-216(a3) # f48 <_GLOBAL_OFFSET_TABLE_+0x18>
  28:	00500713          	li	a4,5
  2c:	007d07b7          	lui	a5,0x7d0

00000030 <_uart_boot_loop1>:
  30:	00078513          	mv	a0,a5
  34:	0d8000ef          	jal	ra,10c <_uart_getchar>
  38:	00054863          	bltz	a0,48 <_uart_boot_exit>
  3c:	00a68023          	sb	a0,0(a3)
  40:	00168693          	addi	a3,a3,1
  44:	fedff06f          	j	30 <_uart_boot_loop1>

00000048 <_uart_boot_exit>:
  48:	02e00513          	li	a0,46
  4c:	094000ef          	jal	ra,e0 <_uart_putchar>
  50:	fff70713          	addi	a4,a4,-1
  54:	fce04ee3          	bgtz	a4,30 <_uart_boot_loop1>
  58:	06200513          	li	a0,98
  5c:	084000ef          	jal	ra,e0 <_uart_putchar>

00000060 <_normal_boot>:
  60:	00a00513          	li	a0,10
  64:	07c000ef          	jal	ra,e0 <_uart_putchar>
  68:	00000697          	auipc	a3,0x0
  6c:	0cc68693          	addi	a3,a3,204 # 134 <_rle_banner>
  70:	00000797          	auipc	a5,0x0
  74:	12b78793          	addi	a5,a5,299 # 19b <_rle_dict>
  78:	0006c703          	lbu	a4,0(a3)

0000007c <_rle_banner_loop1>:
  7c:	00675513          	srli	a0,a4,0x6
  80:	00f50533          	add	a0,a0,a5
  84:	00054503          	lbu	a0,0(a0)
  88:	03f77713          	andi	a4,a4,63
  8c:	00168693          	addi	a3,a3,1

00000090 <_rle_banner_loop2>:
  90:	050000ef          	jal	ra,e0 <_uart_putchar>
  94:	fff70713          	addi	a4,a4,-1
  98:	fee04ce3          	bgtz	a4,90 <_rle_banner_loop2>
  9c:	0006c703          	lbu	a4,0(a3)
  a0:	fc071ee3          	bnez	a4,7c <_rle_banner_loop1>
  a4:	00000697          	auipc	a3,0x0
  a8:	0fb68693          	addi	a3,a3,251 # 19f <_str_banner>

000000ac <_str_banner_loop3>:
  ac:	0006c503          	lbu	a0,0(a3)
  b0:	030000ef          	jal	ra,e0 <_uart_putchar>
  b4:	00168693          	addi	a3,a3,1
  b8:	fe051ae3          	bnez	a0,ac <_str_banner_loop3>
  bc:	00001117          	auipc	sp,0x1
  c0:	e9812103          	lw	sp,-360(sp) # f54 <_GLOBAL_OFFSET_TABLE_+0x24>
  c4:	00001197          	auipc	gp,0x1
  c8:	e781a183          	lw	gp,-392(gp) # f3c <_GLOBAL_OFFSET_TABLE_+0xc>
  cc:	00a54533          	xor	a0,a0,a0
  d0:	00b5c5b3          	xor	a1,a1,a1
  d4:	00c64633          	xor	a2,a2,a2
  d8:	128000ef          	jal	ra,200 <main>
  dc:	f25ff06f          	j	0 <_start>

000000e0 <_uart_putchar>:
  e0:	800005b7          	lui	a1,0x80000

000000e4 <_uart_putchar_busy>:
  e4:	00458603          	lb	a2,4(a1) # 80000004 <_global+0x7fffe8f4>
  e8:	fff64613          	not	a2,a2
  ec:	00167613          	andi	a2,a2,1
  f0:	fe060ae3          	beqz	a2,e4 <_uart_putchar_busy>
  f4:	00a582a3          	sb	a0,5(a1)
  f8:	00a00593          	li	a1,10
  fc:	00b51663          	bne	a0,a1,108 <_uart_putchar_exit>
 100:	00d00513          	li	a0,13
 104:	fddff06f          	j	e0 <_uart_putchar>

00000108 <_uart_putchar_exit>:
 108:	00008067          	ret

0000010c <_uart_getchar>:
 10c:	800005b7          	lui	a1,0x80000

00000110 <_uart_getchar_busy>:
 110:	00050e63          	beqz	a0,12c <_uart_getchar_tout>
 114:	fff50513          	addi	a0,a0,-1
 118:	00458603          	lb	a2,4(a1) # 80000004 <_global+0x7fffe8f4>
 11c:	00267613          	andi	a2,a2,2
 120:	fe0608e3          	beqz	a2,110 <_uart_getchar_busy>
 124:	0055c503          	lbu	a0,5(a1)
 128:	00008067          	ret

0000012c <_uart_getchar_tout>:
 12c:	fff00513          	li	a0,-1
 130:	00008067          	ret

00000134 <_rle_banner>:
 134:	12c19797          	auipc	a5,0x12c19
 138:	c19c                	sw	a5,0(a1)
 13a:	074d                	addi	a4,a4,19
 13c:	c19a                	sw	t1,192(sp)
 13e:	0650                	addi	a2,sp,772
 140:	c198                	sw	a4,0(a1)
 142:	0452                	slli	s0,s0,0x14
 144:	c198                	sw	a4,0(a1)
 146:	0452                	slli	s0,s0,0x14
 148:	c198                	sw	a4,0(a1)
 14a:	0452                	slli	s0,s0,0x14
 14c:	c198                	sw	a4,0(a1)
 14e:	0650                	addi	a2,sp,772
 150:	0296                	slli	t0,t0,0x5
 152:	4dc1                	li	s11,16
 154:	c1049607          	.4byte	0xc1049607
 158:	1042                	c.slli	zero,0x30
 15a:	0696                	slli	a3,a3,0x5
 15c:	42c1                	li	t0,16
 15e:	980c                	.2byte	0x980c
 160:	4206                	lw	tp,64(sp)
 162:	44c1                	li	s1,16
 164:	9a06                	add	s4,s4,ra
 166:	4406                	lw	s0,64(sp)
 168:	46c1                	li	a3,16
 16a:	9606                	add	a2,a2,ra
 16c:	4606                	lw	a2,64(sp)
 16e:	48c1                	li	a7,16
 170:	9206                	add	tp,tp,ra
 172:	4806                	lw	a6,64(sp)
 174:	4ac1                	li	s5,16
 176:	8e06                	mv	t3,ra
 178:	4a06                	lw	s4,64(sp)
 17a:	4cc1                	li	s9,16
 17c:	8a06                	mv	s4,ra
 17e:	4c06                	lw	s8,64(sp)
 180:	4ec1                	li	t4,16
 182:	8606                	mv	a2,ra
 184:	4e06                	lw	t3,64(sp)
 186:	50c1                	li	ra,-16
 188:	8206                	mv	tp,ra
 18a:	5006                	.2byte	0x5006
 18c:	52c1                	li	t0,-16
 18e:	520a                	lw	tp,160(sp)
 190:	54c1                	li	s1,-16
 192:	5406                	lw	s0,96(sp)
 194:	56c1                	li	a3,-16
 196:	5602                	lw	a2,32(sp)
 198:	07c2                	slli	a5,a5,0x10
	...

0000019b <_rle_dict>:
 19b:	7220                	flw	fs0,96(a2)
 19d:	0a76                	slli	s4,s4,0x1d

0000019f <_str_banner>:
 19f:	4e49                	li	t3,18
 1a1:	55525453          	.4byte	0x55525453
 1a5:	4f495443          	.4byte	0x4f495443
 1a9:	204e                	fld	ft0,208(sp)
 1ab:	53544553          	.4byte	0x53544553
 1af:	5720                	lw	s0,104(a4)
 1b1:	4e41                	li	t3,16
 1b3:	2054                	fld	fa3,128(s0)
 1b5:	4f54                	lw	a3,28(a4)
 1b7:	4220                	lw	s0,64(a2)
 1b9:	2045                	jal	259 <main+0x59>
 1bb:	5246                	lw	tp,112(sp)
 1bd:	4545                	li	a0,17
 1bf:	0a0a                	slli	s4,s4,0x2
	...

00000200 <main>:
 200:	fd010113          	addi	sp,sp,-48
 204:	02812423          	sw	s0,40(sp)
 208:	00001417          	auipc	s0,0x1
 20c:	d3842403          	lw	s0,-712(s0) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 210:	00042783          	lw	a5,0(s0)
 214:	02112623          	sw	ra,44(sp)
 218:	02912223          	sw	s1,36(sp)
 21c:	0007c503          	lbu	a0,0(a5) # 12c19134 <_global+0x12c17a24>
 220:	7f8000ef          	jal	ra,a18 <board_name>
 224:	00042783          	lw	a5,0(s0)
 228:	00050593          	mv	a1,a0
 22c:	00001517          	auipc	a0,0x1
 230:	0007c603          	lbu	a2,0(a5)
 234:	96850513          	addi	a0,a0,-1688 # b94 <_etext+0x8>
 238:	518000ef          	jal	ra,750 <printf>
 23c:	00001617          	auipc	a2,0x1
 240:	00001597          	auipc	a1,0x1
 244:	00001517          	auipc	a0,0x1
 248:	96c60613          	addi	a2,a2,-1684 # ba8 <_etext+0x1c>
 24c:	97458593          	addi	a1,a1,-1676 # bb4 <_etext+0x28>
 250:	99050513          	addi	a0,a0,-1648 # bd4 <_etext+0x48>
 254:	4fc000ef          	jal	ra,750 <printf>
 258:	00042783          	lw	a5,0(s0)
 25c:	00001517          	auipc	a0,0x1
 260:	98c50513          	addi	a0,a0,-1652 # be8 <_etext+0x5c>
 264:	0027c583          	lbu	a1,2(a5)
 268:	4e8000ef          	jal	ra,750 <printf>
 26c:	00042783          	lw	a5,0(s0)
 270:	00001517          	auipc	a0,0x1
 274:	98450513          	addi	a0,a0,-1660 # bf4 <_etext+0x68>
 278:	0017c583          	lbu	a1,1(a5)
 27c:	00159593          	slli	a1,a1,0x1
 280:	4d0000ef          	jal	ra,750 <printf>
 284:	0b1000ef          	jal	ra,b34 <check4rv32i>
 288:	00001597          	auipc	a1,0x1
 28c:	90858593          	addi	a1,a1,-1784 # b90 <_etext+0x4>
 290:	00050663          	beqz	a0,29c <main+0x9c>
 294:	00001597          	auipc	a1,0x1
 298:	8f858593          	addi	a1,a1,-1800 # b8c <_etext>
 29c:	00001517          	auipc	a0,0x1
 2a0:	96c50513          	addi	a0,a0,-1684 # c08 <_etext+0x7c>
 2a4:	4ac000ef          	jal	ra,750 <printf>
 2a8:	01000613          	li	a2,16
 2ac:	01000593          	li	a1,16
 2b0:	3e800513          	li	a0,1000
 2b4:	079000ef          	jal	ra,b2c <mac>
 2b8:	4e800793          	li	a5,1256
 2bc:	22f50263          	beq	a0,a5,4e0 <main+0x2e0>
 2c0:	00001517          	auipc	a0,0x1
 2c4:	9c850513          	addi	a0,a0,-1592 # c88 <_etext+0xfc>
 2c8:	488000ef          	jal	ra,750 <printf>
 2cc:	00001697          	auipc	a3,0x1
 2d0:	c806a683          	lw	a3,-896(a3) # f4c <_GLOBAL_OFFSET_TABLE_+0x1c>
 2d4:	00001417          	auipc	s0,0x1
 2d8:	c7c42403          	lw	s0,-900(s0) # f50 <_GLOBAL_OFFSET_TABLE_+0x20>
 2dc:	00001597          	auipc	a1,0x1
 2e0:	c685a583          	lw	a1,-920(a1) # f44 <_GLOBAL_OFFSET_TABLE_+0x14>
 2e4:	00001497          	auipc	s1,0x1
 2e8:	c704a483          	lw	s1,-912(s1) # f54 <_GLOBAL_OFFSET_TABLE_+0x24>
 2ec:	00001517          	auipc	a0,0x1
 2f0:	00001617          	auipc	a2,0x1
 2f4:	c4862603          	lw	a2,-952(a2) # f38 <_GLOBAL_OFFSET_TABLE_+0x8>
 2f8:	40d40733          	sub	a4,s0,a3
 2fc:	40b60633          	sub	a2,a2,a1
 300:	00048793          	mv	a5,s1
 304:	92c50513          	addi	a0,a0,-1748 # c18 <_etext+0x8c>
 308:	448000ef          	jal	ra,750 <printf>
 30c:	00001517          	auipc	a0,0x1
 310:	408485b3          	sub	a1,s1,s0
 314:	93450513          	addi	a0,a0,-1740 # c40 <_etext+0xb4>
 318:	438000ef          	jal	ra,750 <printf>
 31c:	00001497          	auipc	s1,0x1
 320:	c244a483          	lw	s1,-988(s1) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 324:	0004a783          	lw	a5,0(s1)
 328:	00001517          	auipc	a0,0x1
 32c:	93050513          	addi	a0,a0,-1744 # c58 <_etext+0xcc>
 330:	0067d583          	lhu	a1,6(a5)
 334:	deadc7b7          	lui	a5,0xdeadc
 338:	eef78793          	addi	a5,a5,-273 # deadbeef <_global+0xdeada7df>
 33c:	00f42023          	sw	a5,0(s0)
 340:	410000ef          	jal	ra,750 <printf>
 344:	0004a783          	lw	a5,0(s1)
 348:	00001417          	auipc	s0,0x1
 34c:	bec42403          	lw	s0,-1044(s0) # f34 <_GLOBAL_OFFSET_TABLE_+0x4>
 350:	00410493          	addi	s1,sp,4
 354:	0017c703          	lbu	a4,1(a5)
 358:	00c7a583          	lw	a1,12(a5)
 35c:	00c7a603          	lw	a2,12(a5)
 360:	00571793          	slli	a5,a4,0x5
 364:	40e787b3          	sub	a5,a5,a4
 368:	00679513          	slli	a0,a5,0x6
 36c:	40f50533          	sub	a0,a0,a5
 370:	00351513          	slli	a0,a0,0x3
 374:	00e50533          	add	a0,a0,a4
 378:	00158593          	addi	a1,a1,1
 37c:	00751513          	slli	a0,a0,0x7
 380:	00c12023          	sw	a2,0(sp)
 384:	5d4000ef          	jal	ra,958 <__udivsi3>
 388:	00012603          	lw	a2,0(sp)
 38c:	00050593          	mv	a1,a0
 390:	00001517          	auipc	a0,0x1
 394:	8e450513          	addi	a0,a0,-1820 # c74 <_etext+0xe8>
 398:	3b8000ef          	jal	ra,750 <printf>
 39c:	00001797          	auipc	a5,0x1
 3a0:	ba47a783          	lw	a5,-1116(a5) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 3a4:	0007a783          	lw	a5,0(a5)
 3a8:	f8000713          	li	a4,-128
 3ac:	00001517          	auipc	a0,0x1
 3b0:	00e781a3          	sb	a4,3(a5)
 3b4:	8dc50513          	addi	a0,a0,-1828 # c88 <_etext+0xfc>
 3b8:	00042023          	sw	zero,0(s0)
 3bc:	394000ef          	jal	ra,750 <printf>
 3c0:	00001517          	auipc	a0,0x1
 3c4:	8cc50513          	addi	a0,a0,-1844 # c8c <_etext+0x100>
 3c8:	388000ef          	jal	ra,750 <printf>
 3cc:	00001517          	auipc	a0,0x1
 3d0:	8d850513          	addi	a0,a0,-1832 # ca4 <_etext+0x118>
 3d4:	37c000ef          	jal	ra,750 <printf>
 3d8:	00000593          	li	a1,0
 3dc:	02000613          	li	a2,32
 3e0:	00048513          	mv	a0,s1
 3e4:	554000ef          	jal	ra,938 <memset>
 3e8:	00001797          	auipc	a5,0x1
 3ec:	b587a783          	lw	a5,-1192(a5) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 3f0:	000f45b7          	lui	a1,0xf4
 3f4:	0007a703          	lw	a4,0(a5)
 3f8:	23f58593          	addi	a1,a1,575 # f423f <_global+0xf2b2f>
 3fc:	0100006f          	j	40c <main+0x20c>
 400:	00474783          	lbu	a5,4(a4)
 404:	0027f793          	andi	a5,a5,2
 408:	04079863          	bnez	a5,458 <main+0x258>
 40c:	00374783          	lbu	a5,3(a4)
 410:	01879793          	slli	a5,a5,0x18
 414:	4187d793          	srai	a5,a5,0x18
 418:	fe07d4e3          	bgez	a5,400 <main+0x200>
 41c:	00042783          	lw	a5,0(s0)
 420:	fff78613          	addi	a2,a5,-1
 424:	00c42023          	sw	a2,0(s0)
 428:	00079e63          	bnez	a5,444 <main+0x244>
 42c:	00875783          	lhu	a5,8(a4)
 430:	00178793          	addi	a5,a5,1
 434:	01079793          	slli	a5,a5,0x10
 438:	0107d793          	srli	a5,a5,0x10
 43c:	00f71423          	sh	a5,8(a4)
 440:	00b42023          	sw	a1,0(s0)
 444:	f8000793          	li	a5,-128
 448:	00f701a3          	sb	a5,3(a4)
 44c:	00474783          	lbu	a5,4(a4)
 450:	0027f793          	andi	a5,a5,2
 454:	fa078ce3          	beqz	a5,40c <main+0x20c>
 458:	02000593          	li	a1,32
 45c:	00048513          	mv	a0,s1
 460:	090000ef          	jal	ra,4f0 <gets>
 464:	00001597          	auipc	a1,0x1
 468:	84458593          	addi	a1,a1,-1980 # ca8 <_etext+0x11c>
 46c:	00048513          	mv	a0,s1
 470:	480000ef          	jal	ra,8f0 <strcmp>
 474:	02050e63          	beqz	a0,4b0 <main+0x2b0>
 478:	00001597          	auipc	a1,0x1
 47c:	84058593          	addi	a1,a1,-1984 # cb8 <_etext+0x12c>
 480:	00048513          	mv	a0,s1
 484:	46c000ef          	jal	ra,8f0 <strcmp>
 488:	f40512e3          	bnez	a0,3cc <main+0x1cc>
 48c:	00001517          	auipc	a0,0x1
 490:	83450513          	addi	a0,a0,-1996 # cc0 <_etext+0x134>
 494:	2bc000ef          	jal	ra,750 <printf>
 498:	02c12083          	lw	ra,44(sp)
 49c:	02812403          	lw	s0,40(sp)
 4a0:	02412483          	lw	s1,36(sp)
 4a4:	00000513          	li	a0,0
 4a8:	03010113          	addi	sp,sp,48
 4ac:	00008067          	ret
 4b0:	00000517          	auipc	a0,0x0
 4b4:	7fc50513          	addi	a0,a0,2044 # cac <_etext+0x120>
 4b8:	298000ef          	jal	ra,750 <printf>
 4bc:	00001797          	auipc	a5,0x1
 4c0:	a847a783          	lw	a5,-1404(a5) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 4c4:	0007a703          	lw	a4,0(a5)
 4c8:	00875783          	lhu	a5,8(a4)
 4cc:	fff7c793          	not	a5,a5
 4d0:	01079793          	slli	a5,a5,0x10
 4d4:	0107d793          	srli	a5,a5,0x10
 4d8:	00f71423          	sh	a5,8(a4)
 4dc:	ef1ff06f          	j	3cc <main+0x1cc>
 4e0:	00000517          	auipc	a0,0x0
 4e4:	73050513          	addi	a0,a0,1840 # c10 <_etext+0x84>
 4e8:	268000ef          	jal	ra,750 <printf>
 4ec:	dd5ff06f          	j	2c0 <main+0xc0>

000004f0 <gets>:
 4f0:	00001317          	auipc	t1,0x1
 4f4:	a5032303          	lw	t1,-1456(t1) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 4f8:	fff58593          	addi	a1,a1,-1
 4fc:	00032703          	lw	a4,0(t1)
 500:	00050613          	mv	a2,a0
 504:	04058a63          	beqz	a1,558 <gets+0x68>
 508:	00a00813          	li	a6,10
 50c:	00d00893          	li	a7,13
 510:	00800e13          	li	t3,8
 514:	00474783          	lbu	a5,4(a4)
 518:	0027f793          	andi	a5,a5,2
 51c:	fe078ce3          	beqz	a5,514 <gets+0x24>
 520:	00574783          	lbu	a5,5(a4)
 524:	0ff7f693          	zext.b	a3,a5
 528:	03078863          	beq	a5,a6,558 <gets+0x68>
 52c:	03168663          	beq	a3,a7,558 <gets+0x68>
 530:	00474783          	lbu	a5,4(a4)
 534:	0017f793          	andi	a5,a5,1
 538:	fe079ce3          	bnez	a5,530 <gets+0x40>
 53c:	00d702a3          	sb	a3,5(a4)
 540:	05c68c63          	beq	a3,t3,598 <gets+0xa8>
 544:	00d60023          	sb	a3,0(a2)
 548:	fff58593          	addi	a1,a1,-1
 54c:	00032703          	lw	a4,0(t1)
 550:	00160613          	addi	a2,a2,1
 554:	fc0590e3          	bnez	a1,514 <gets+0x24>
 558:	00474783          	lbu	a5,4(a4)
 55c:	0017f793          	andi	a5,a5,1
 560:	fe079ce3          	bnez	a5,558 <gets+0x68>
 564:	00d00793          	li	a5,13
 568:	00f702a3          	sb	a5,5(a4)
 56c:	00474783          	lbu	a5,4(a4)
 570:	0017f793          	andi	a5,a5,1
 574:	fe079ce3          	bnez	a5,56c <gets+0x7c>
 578:	40c507b3          	sub	a5,a0,a2
 57c:	00a00693          	li	a3,10
 580:	00f037b3          	snez	a5,a5
 584:	00d702a3          	sb	a3,5(a4)
 588:	40f007b3          	neg	a5,a5
 58c:	00060023          	sb	zero,0(a2)
 590:	00f57533          	and	a0,a0,a5
 594:	00008067          	ret
 598:	00c50c63          	beq	a0,a2,5b0 <gets+0xc0>
 59c:	fe060fa3          	sb	zero,-1(a2)
 5a0:	00032703          	lw	a4,0(t1)
 5a4:	fff60613          	addi	a2,a2,-1
 5a8:	f60596e3          	bnez	a1,514 <gets+0x24>
 5ac:	fadff06f          	j	558 <gets+0x68>
 5b0:	fff58593          	addi	a1,a1,-1
 5b4:	f60590e3          	bnez	a1,514 <gets+0x24>
 5b8:	fa1ff06f          	j	558 <gets+0x68>

000005bc <putnum>:
 5bc:	00000797          	auipc	a5,0x0
 5c0:	71c78793          	addi	a5,a5,1820 # cd8 <_etext+0x14c>
 5c4:	0087a603          	lw	a2,8(a5)
 5c8:	0007a883          	lw	a7,0(a5)
 5cc:	0047a803          	lw	a6,4(a5)
 5d0:	00c7a703          	lw	a4,12(a5)
 5d4:	0107c783          	lbu	a5,16(a5)
 5d8:	fb410113          	addi	sp,sp,-76
 5dc:	04812223          	sw	s0,68(sp)
 5e0:	04912023          	sw	s1,64(sp)
 5e4:	00c12a23          	sw	a2,20(sp)
 5e8:	00f10e23          	sb	a5,28(sp)
 5ec:	04112423          	sw	ra,72(sp)
 5f0:	00001797          	auipc	a5,0x1
 5f4:	9507a783          	lw	a5,-1712(a5) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 5f8:	01112623          	sw	a7,12(sp)
 5fc:	01012823          	sw	a6,16(sp)
 600:	00e12c23          	sw	a4,24(sp)
 604:	00a00613          	li	a2,10
 608:	0007a483          	lw	s1,0(a5)
 60c:	00058413          	mv	s0,a1
 610:	00050793          	mv	a5,a0
 614:	10c58e63          	beq	a1,a2,730 <putnum+0x174>
 618:	00012023          	sw	zero,0(sp)
 61c:	00040593          	mv	a1,s0
 620:	00078513          	mv	a0,a5
 624:	00f12223          	sw	a5,4(sp)
 628:	390000ef          	jal	ra,9b8 <__umodsi3>
 62c:	00c10713          	addi	a4,sp,12
 630:	03450793          	addi	a5,a0,52
 634:	00e78533          	add	a0,a5,a4
 638:	00412783          	lw	a5,4(sp)
 63c:	fcc54603          	lbu	a2,-52(a0)
 640:	00040593          	mv	a1,s0
 644:	00078513          	mv	a0,a5
 648:	00012783          	lw	a5,0(sp)
 64c:	03478693          	addi	a3,a5,52
 650:	00e687b3          	add	a5,a3,a4
 654:	fec78023          	sb	a2,-32(a5)
 658:	300000ef          	jal	ra,958 <__udivsi3>
 65c:	00012703          	lw	a4,0(sp)
 660:	00040593          	mv	a1,s0
 664:	00050793          	mv	a5,a0
 668:	00170613          	addi	a2,a4,1
 66c:	03460693          	addi	a3,a2,52
 670:	00c10713          	addi	a4,sp,12
 674:	00e68833          	add	a6,a3,a4
 678:	01012223          	sw	a6,4(sp)
 67c:	00a00693          	li	a3,10
 680:	0ad40263          	beq	s0,a3,724 <putnum+0x168>
 684:	00a12423          	sw	a0,8(sp)
 688:	330000ef          	jal	ra,9b8 <__umodsi3>
 68c:	03450693          	addi	a3,a0,52
 690:	00c10793          	addi	a5,sp,12
 694:	00f68533          	add	a0,a3,a5
 698:	fcc54603          	lbu	a2,-52(a0)
 69c:	00812783          	lw	a5,8(sp)
 6a0:	00412803          	lw	a6,4(sp)
 6a4:	00040593          	mv	a1,s0
 6a8:	00078513          	mv	a0,a5
 6ac:	fec80023          	sb	a2,-32(a6)
 6b0:	2a8000ef          	jal	ra,958 <__udivsi3>
 6b4:	00012703          	lw	a4,0(sp)
 6b8:	00270793          	addi	a5,a4,2
 6bc:	00f12023          	sw	a5,0(sp)
 6c0:	00050793          	mv	a5,a0
 6c4:	f4079ce3          	bnez	a5,61c <putnum+0x60>
 6c8:	00012783          	lw	a5,0(sp)
 6cc:	02010613          	addi	a2,sp,32
 6d0:	00a00593          	li	a1,10
 6d4:	00f60433          	add	s0,a2,a5
 6d8:	00d00513          	li	a0,13
 6dc:	fff44683          	lbu	a3,-1(s0)
 6e0:	02b68863          	beq	a3,a1,710 <putnum+0x154>
 6e4:	0044c783          	lbu	a5,4(s1)
 6e8:	0017f793          	andi	a5,a5,1
 6ec:	fe079ce3          	bnez	a5,6e4 <putnum+0x128>
 6f0:	00d482a3          	sb	a3,5(s1)
 6f4:	fff40413          	addi	s0,s0,-1
 6f8:	fe8612e3          	bne	a2,s0,6dc <putnum+0x120>
 6fc:	04812083          	lw	ra,72(sp)
 700:	04412403          	lw	s0,68(sp)
 704:	04012483          	lw	s1,64(sp)
 708:	04c10113          	addi	sp,sp,76
 70c:	00008067          	ret
 710:	0044c783          	lbu	a5,4(s1)
 714:	0017f793          	andi	a5,a5,1
 718:	fe079ce3          	bnez	a5,710 <putnum+0x154>
 71c:	00a482a3          	sb	a0,5(s1)
 720:	fc5ff06f          	j	6e4 <putnum+0x128>
 724:	00c12023          	sw	a2,0(sp)
 728:	ee079ae3          	bnez	a5,61c <putnum+0x60>
 72c:	f9dff06f          	j	6c8 <putnum+0x10c>
 730:	ee0554e3          	bgez	a0,618 <putnum+0x5c>
 734:	0044c603          	lbu	a2,4(s1)
 738:	00167613          	andi	a2,a2,1
 73c:	fe061ce3          	bnez	a2,734 <putnum+0x178>
 740:	02d00613          	li	a2,45
 744:	00c482a3          	sb	a2,5(s1)
 748:	40f007b3          	neg	a5,a5
 74c:	ecdff06f          	j	618 <putnum+0x5c>

00000750 <printf>:
 750:	fdc10113          	addi	sp,sp,-36
 754:	02f12023          	sw	a5,32(sp)
 758:	00112623          	sw	ra,12(sp)
 75c:	00812423          	sw	s0,8(sp)
 760:	00912223          	sw	s1,4(sp)
 764:	00b12823          	sw	a1,16(sp)
 768:	00c12a23          	sw	a2,20(sp)
 76c:	00d12c23          	sw	a3,24(sp)
 770:	00e12e23          	sw	a4,28(sp)
 774:	00054683          	lbu	a3,0(a0)
 778:	01010793          	addi	a5,sp,16
 77c:	00f12023          	sw	a5,0(sp)
 780:	04068e63          	beqz	a3,7dc <printf+0x8c>
 784:	00000497          	auipc	s1,0x0
 788:	7bc4a483          	lw	s1,1980(s1) # f40 <_GLOBAL_OFFSET_TABLE_+0x10>
 78c:	02500793          	li	a5,37
 790:	00150413          	addi	s0,a0,1
 794:	06f69c63          	bne	a3,a5,80c <printf+0xbc>
 798:	00154683          	lbu	a3,1(a0)
 79c:	07300793          	li	a5,115
 7a0:	0cf68263          	beq	a3,a5,864 <printf+0x114>
 7a4:	07800793          	li	a5,120
 7a8:	12f68663          	beq	a3,a5,8d4 <printf+0x184>
 7ac:	06400793          	li	a5,100
 7b0:	08f68c63          	beq	a3,a5,848 <printf+0xf8>
 7b4:	00a00793          	li	a5,10
 7b8:	0004a703          	lw	a4,0(s1)
 7bc:	02f68c63          	beq	a3,a5,7f4 <printf+0xa4>
 7c0:	00474783          	lbu	a5,4(a4)
 7c4:	0017f793          	andi	a5,a5,1
 7c8:	fe079ce3          	bnez	a5,7c0 <printf+0x70>
 7cc:	00d702a3          	sb	a3,5(a4)
 7d0:	00144683          	lbu	a3,1(s0)
 7d4:	00140513          	addi	a0,s0,1
 7d8:	fa069ae3          	bnez	a3,78c <printf+0x3c>
 7dc:	00c12083          	lw	ra,12(sp)
 7e0:	00812403          	lw	s0,8(sp)
 7e4:	00412483          	lw	s1,4(sp)
 7e8:	00000513          	li	a0,0
 7ec:	02410113          	addi	sp,sp,36
 7f0:	00008067          	ret
 7f4:	00474783          	lbu	a5,4(a4)
 7f8:	0017f793          	andi	a5,a5,1
 7fc:	fe079ce3          	bnez	a5,7f4 <printf+0xa4>
 800:	00d00793          	li	a5,13
 804:	00f702a3          	sb	a5,5(a4)
 808:	fb9ff06f          	j	7c0 <printf+0x70>
 80c:	00a00793          	li	a5,10
 810:	0004a703          	lw	a4,0(s1)
 814:	00f68e63          	beq	a3,a5,830 <printf+0xe0>
 818:	00474783          	lbu	a5,4(a4)
 81c:	0017f793          	andi	a5,a5,1
 820:	fe079ce3          	bnez	a5,818 <printf+0xc8>
 824:	00d702a3          	sb	a3,5(a4)
 828:	00050413          	mv	s0,a0
 82c:	fa5ff06f          	j	7d0 <printf+0x80>
 830:	00474783          	lbu	a5,4(a4)
 834:	0017f793          	andi	a5,a5,1
 838:	fe079ce3          	bnez	a5,830 <printf+0xe0>
 83c:	00d00793          	li	a5,13
 840:	00f702a3          	sb	a5,5(a4)
 844:	fd5ff06f          	j	818 <printf+0xc8>
 848:	00012783          	lw	a5,0(sp)
 84c:	00a00593          	li	a1,10
 850:	0007a503          	lw	a0,0(a5)
 854:	00478793          	addi	a5,a5,4
 858:	00f12023          	sw	a5,0(sp)
 85c:	d61ff0ef          	jal	ra,5bc <putnum>
 860:	f71ff06f          	j	7d0 <printf+0x80>
 864:	00012703          	lw	a4,0(sp)
 868:	00000797          	auipc	a5,0x0
 86c:	46878793          	addi	a5,a5,1128 # cd0 <_etext+0x144>
 870:	00072683          	lw	a3,0(a4)
 874:	00470713          	addi	a4,a4,4
 878:	00e12023          	sw	a4,0(sp)
 87c:	00069463          	bnez	a3,884 <printf+0x134>
 880:	00078693          	mv	a3,a5
 884:	0006c603          	lbu	a2,0(a3)
 888:	f40604e3          	beqz	a2,7d0 <printf+0x80>
 88c:	00a00593          	li	a1,10
 890:	0004a703          	lw	a4,0(s1)
 894:	00d00513          	li	a0,13
 898:	00168693          	addi	a3,a3,1
 89c:	02b60263          	beq	a2,a1,8c0 <printf+0x170>
 8a0:	00474783          	lbu	a5,4(a4)
 8a4:	0017f793          	andi	a5,a5,1
 8a8:	fe079ce3          	bnez	a5,8a0 <printf+0x150>
 8ac:	00c702a3          	sb	a2,5(a4)
 8b0:	0006c603          	lbu	a2,0(a3)
 8b4:	f0060ee3          	beqz	a2,7d0 <printf+0x80>
 8b8:	00168693          	addi	a3,a3,1
 8bc:	feb612e3          	bne	a2,a1,8a0 <printf+0x150>
 8c0:	00474783          	lbu	a5,4(a4)
 8c4:	0017f793          	andi	a5,a5,1
 8c8:	fe079ce3          	bnez	a5,8c0 <printf+0x170>
 8cc:	00a702a3          	sb	a0,5(a4)
 8d0:	fd1ff06f          	j	8a0 <printf+0x150>
 8d4:	00012783          	lw	a5,0(sp)
 8d8:	01000593          	li	a1,16
 8dc:	0007a503          	lw	a0,0(a5)
 8e0:	00478793          	addi	a5,a5,4
 8e4:	00f12023          	sw	a5,0(sp)
 8e8:	cd5ff0ef          	jal	ra,5bc <putnum>
 8ec:	ee5ff06f          	j	7d0 <printf+0x80>

000008f0 <strcmp>:
 8f0:	00054783          	lbu	a5,0(a0)
 8f4:	00079c63          	bnez	a5,90c <strcmp+0x1c>
 8f8:	0380006f          	j	930 <strcmp+0x40>
 8fc:	02e79063          	bne	a5,a4,91c <strcmp+0x2c>
 900:	00054783          	lbu	a5,0(a0)
 904:	02078063          	beqz	a5,924 <strcmp+0x34>
 908:	00068593          	mv	a1,a3
 90c:	0005c703          	lbu	a4,0(a1)
 910:	00150513          	addi	a0,a0,1
 914:	00158693          	addi	a3,a1,1
 918:	fe0712e3          	bnez	a4,8fc <strcmp+0xc>
 91c:	40e78533          	sub	a0,a5,a4
 920:	00008067          	ret
 924:	0015c703          	lbu	a4,1(a1)
 928:	40e78533          	sub	a0,a5,a4
 92c:	00008067          	ret
 930:	0005c703          	lbu	a4,0(a1)
 934:	fe9ff06f          	j	91c <strcmp+0x2c>

00000938 <memset>:
 938:	0ff5f593          	zext.b	a1,a1
 93c:	00c50733          	add	a4,a0,a2
 940:	00050793          	mv	a5,a0
 944:	00060863          	beqz	a2,954 <memset+0x1c>
 948:	00178793          	addi	a5,a5,1
 94c:	feb78fa3          	sb	a1,-1(a5)
 950:	fef71ce3          	bne	a4,a5,948 <memset+0x10>
 954:	00008067          	ret

00000958 <__udivsi3>:
 958:	04058863          	beqz	a1,9a8 <__udivsi3+0x50>
 95c:	00050713          	mv	a4,a0
 960:	00100793          	li	a5,1
 964:	04a5f663          	bgeu	a1,a0,9b0 <__udivsi3+0x58>
 968:	0005d663          	bgez	a1,974 <__udivsi3+0x1c>
 96c:	0180006f          	j	984 <__udivsi3+0x2c>
 970:	0005c863          	bltz	a1,980 <__udivsi3+0x28>
 974:	00159593          	slli	a1,a1,0x1
 978:	00179793          	slli	a5,a5,0x1
 97c:	fea5eae3          	bltu	a1,a0,970 <__udivsi3+0x18>
 980:	02078463          	beqz	a5,9a8 <__udivsi3+0x50>
 984:	00000513          	li	a0,0
 988:	00b76663          	bltu	a4,a1,994 <__udivsi3+0x3c>
 98c:	40b70733          	sub	a4,a4,a1
 990:	00f50533          	add	a0,a0,a5
 994:	0017d793          	srli	a5,a5,0x1
 998:	0015d593          	srli	a1,a1,0x1
 99c:	00070863          	beqz	a4,9ac <__udivsi3+0x54>
 9a0:	fe0794e3          	bnez	a5,988 <__udivsi3+0x30>
 9a4:	00008067          	ret
 9a8:	00000513          	li	a0,0
 9ac:	00008067          	ret
 9b0:	fc051ae3          	bnez	a0,984 <__udivsi3+0x2c>
 9b4:	00008067          	ret

000009b8 <__umodsi3>:
 9b8:	04058663          	beqz	a1,a04 <__umodsi3+0x4c>
 9bc:	00050713          	mv	a4,a0
 9c0:	00100793          	li	a5,1
 9c4:	04a5f663          	bgeu	a1,a0,a10 <__umodsi3+0x58>
 9c8:	0005d663          	bgez	a1,9d4 <__umodsi3+0x1c>
 9cc:	0180006f          	j	9e4 <__umodsi3+0x2c>
 9d0:	0005c863          	bltz	a1,9e0 <__umodsi3+0x28>
 9d4:	00159593          	slli	a1,a1,0x1
 9d8:	00179793          	slli	a5,a5,0x1
 9dc:	fea5eae3          	bltu	a1,a0,9d0 <__umodsi3+0x18>
 9e0:	02078663          	beqz	a5,a0c <__umodsi3+0x54>
 9e4:	00b76463          	bltu	a4,a1,9ec <__umodsi3+0x34>
 9e8:	40b70733          	sub	a4,a4,a1
 9ec:	0017d793          	srli	a5,a5,0x1
 9f0:	0015d593          	srli	a1,a1,0x1
 9f4:	00070863          	beqz	a4,a04 <__umodsi3+0x4c>
 9f8:	fe0796e3          	bnez	a5,9e4 <__umodsi3+0x2c>
 9fc:	00070513          	mv	a0,a4
 a00:	00008067          	ret
 a04:	00000513          	li	a0,0
 a08:	00008067          	ret
 a0c:	00008067          	ret
 a10:	fc051ae3          	bnez	a0,9e4 <__umodsi3+0x2c>
 a14:	00008067          	ret

00000a18 <board_name>:
 a18:	01200793          	li	a5,18
 a1c:	10a7e263          	bltu	a5,a0,b20 <board_name+0x108>
 a20:	00000797          	auipc	a5,0x0
 a24:	4a078793          	addi	a5,a5,1184 # ec0 <_etext+0x334>
 a28:	00251513          	slli	a0,a0,0x2
 a2c:	00f50533          	add	a0,a0,a5
 a30:	00052703          	lw	a4,0(a0)
 a34:	00f707b3          	add	a5,a4,a5
 a38:	00078067          	jr	a5
 a3c:	00000517          	auipc	a0,0x0
 a40:	2c850513          	addi	a0,a0,712 # d04 <_etext+0x178>
 a44:	00008067          	ret
 a48:	00000517          	auipc	a0,0x0
 a4c:	2a450513          	addi	a0,a0,676 # cec <_etext+0x160>
 a50:	00008067          	ret
 a54:	00000517          	auipc	a0,0x0
 a58:	45850513          	addi	a0,a0,1112 # eac <_etext+0x320>
 a5c:	00008067          	ret
 a60:	00000517          	auipc	a0,0x0
 a64:	42850513          	addi	a0,a0,1064 # e88 <_etext+0x2fc>
 a68:	00008067          	ret
 a6c:	00000517          	auipc	a0,0x0
 a70:	40450513          	addi	a0,a0,1028 # e70 <_etext+0x2e4>
 a74:	00008067          	ret
 a78:	00000517          	auipc	a0,0x0
 a7c:	3d850513          	addi	a0,a0,984 # e50 <_etext+0x2c4>
 a80:	00008067          	ret
 a84:	00000517          	auipc	a0,0x0
 a88:	3ac50513          	addi	a0,a0,940 # e30 <_etext+0x2a4>
 a8c:	00008067          	ret
 a90:	00000517          	auipc	a0,0x0
 a94:	38050513          	addi	a0,a0,896 # e10 <_etext+0x284>
 a98:	00008067          	ret
 a9c:	00000517          	auipc	a0,0x0
 aa0:	35c50513          	addi	a0,a0,860 # df8 <_etext+0x26c>
 aa4:	00008067          	ret
 aa8:	00000517          	auipc	a0,0x0
 aac:	33850513          	addi	a0,a0,824 # de0 <_etext+0x254>
 ab0:	00008067          	ret
 ab4:	00000517          	auipc	a0,0x0
 ab8:	31050513          	addi	a0,a0,784 # dc4 <_etext+0x238>
 abc:	00008067          	ret
 ac0:	00000517          	auipc	a0,0x0
 ac4:	2f050513          	addi	a0,a0,752 # db0 <_etext+0x224>
 ac8:	00008067          	ret
 acc:	00000517          	auipc	a0,0x0
 ad0:	2c850513          	addi	a0,a0,712 # d94 <_etext+0x208>
 ad4:	00008067          	ret
 ad8:	00000517          	auipc	a0,0x0
 adc:	2a450513          	addi	a0,a0,676 # d7c <_etext+0x1f0>
 ae0:	00008067          	ret
 ae4:	00000517          	auipc	a0,0x0
 ae8:	28450513          	addi	a0,a0,644 # d68 <_etext+0x1dc>
 aec:	00008067          	ret
 af0:	00000517          	auipc	a0,0x0
 af4:	26050513          	addi	a0,a0,608 # d50 <_etext+0x1c4>
 af8:	00008067          	ret
 afc:	00000517          	auipc	a0,0x0
 b00:	24050513          	addi	a0,a0,576 # d3c <_etext+0x1b0>
 b04:	00008067          	ret
 b08:	00000517          	auipc	a0,0x0
 b0c:	22050513          	addi	a0,a0,544 # d28 <_etext+0x19c>
 b10:	00008067          	ret
 b14:	00000517          	auipc	a0,0x0
 b18:	20050513          	addi	a0,a0,512 # d14 <_etext+0x188>
 b1c:	00008067          	ret
 b20:	00000517          	auipc	a0,0x0
 b24:	38450513          	addi	a0,a0,900 # ea4 <_etext+0x318>
 b28:	00008067          	ret

00000b2c <mac>:
 b2c:	00c5850b          	.4byte	0xc5850b
 b30:	00008067          	ret

00000b34 <check4rv32i>:
 b34:	00000793          	li	a5,0
 b38:	00100f93          	li	t6,1
 b3c:	40ff8533          	sub	a0,t6,a5
 b40:	00008067          	ret

00000b44 <get_mtvec>:
 b44:	00000513          	li	a0,0
 b48:	30502573          	csrr	a0,mtvec
 b4c:	00008067          	ret

00000b50 <get_mepc>:
 b50:	00000513          	li	a0,0
 b54:	34102573          	csrr	a0,mepc
 b58:	00008067          	ret

00000b5c <get_mie>:
 b5c:	00000513          	li	a0,0
 b60:	30402573          	csrr	a0,mie
 b64:	00008067          	ret

00000b68 <get_mip>:
 b68:	00000513          	li	a0,0
 b6c:	34402573          	csrr	a0,mip
 b70:	00008067          	ret

00000b74 <set_mtvec>:
 b74:	30551073          	csrw	mtvec,a0
 b78:	00008067          	ret

00000b7c <set_mepc>:
 b7c:	34151073          	csrw	mepc,a0
 b80:	00008067          	ret

00000b84 <set_mie>:
 b84:	30451073          	csrw	mie,a0
 b88:	00008067          	ret

Disassembly of section .data:

00000b8c <_data>:
 b8c:	0069                	c.nop	26
 b8e:	0000                	unimp
 b90:	0065                	c.nop	25
 b92:	0000                	unimp
 b94:	6f62                	flw	ft10,24(sp)
 b96:	7261                	lui	tp,0xffff8
 b98:	3a64                	fld	fs1,240(a2)
 b9a:	2520                	fld	fs0,72(a0)
 b9c:	69282073          	csrs	0x692,a6
 ba0:	3d64                	fld	fs1,248(a0)
 ba2:	6425                	lui	s0,0x9
 ba4:	0a29                	addi	s4,s4,10
 ba6:	0000                	unimp
 ba8:	7672                	flw	fa2,60(sp)
 baa:	5f693233          	.4byte	0x5f693233
 bae:	697a                	flw	fs2,156(sp)
 bb0:	00727363          	bgeu	tp,t2,bb6 <_data+0x2a>
 bb4:	7246                	flw	ft4,112(sp)
 bb6:	2c69                	jal	e50 <_data+0x2c4>
 bb8:	3220                	fld	fs0,96(a2)
 bba:	65532037          	lui	zero,0x65532
 bbe:	2070                	fld	fa2,192(s0)
 bc0:	3032                	fld	ft0,296(sp)
 bc2:	3432                	fld	fs0,296(sp)
 bc4:	3020                	fld	fs0,96(s0)
 bc6:	3a38                	fld	fa4,112(a2)
 bc8:	343a3633          	.4byte	0x343a3633
 bcc:	2031                	jal	bd8 <_data+0x4c>
 bce:	3037302b          	.4byte	0x3037302b
 bd2:	0030                	addi	a2,sp,8
 bd4:	7562                	flw	fa0,56(sp)
 bd6:	6c69                	lui	s8,0x1a
 bd8:	3a64                	fld	fs1,240(a2)
 bda:	2520                	fld	fs0,72(a0)
 bdc:	6f662073          	csrs	0x6f6,a2
 be0:	2072                	fld	ft0,280(sp)
 be2:	7325                	lui	t1,0xfffe9
 be4:	000a                	c.slli	zero,0x2
 be6:	0000                	unimp
 be8:	65726f63          	bltu	tp,s7,1246 <_stack+0x246>
 bec:	6425                	lui	s0,0x9
 bee:	203a                	fld	ft0,392(sp)
 bf0:	0000                	unimp
 bf2:	0000                	unimp
 bf4:	6164                	flw	fs1,68(a0)
 bf6:	6b72                	flw	fs6,28(sp)
 bf8:	6972                	flw	fs2,28(sp)
 bfa:	40766373          	csrrsi	t1,0x407,12
 bfe:	6425                	lui	s0,0x9
 c00:	484d                	li	a6,19
 c02:	207a                	fld	ft0,408(sp)
 c04:	00202f77          	.4byte	0x202f77
 c08:	7672                	flw	fa2,60(sp)
 c0a:	73253233          	.4byte	0x73253233
 c0e:	0020                	addi	s0,sp,8
 c10:	414d                	li	sp,19
 c12:	00002043          	fmadd.s	ft0,ft0,ft0,ft0,rdn
 c16:	0000                	unimp
 c18:	7262                	flw	ft4,56(sp)
 c1a:	6d61                	lui	s10,0x18
 c1c:	3a30                	fld	fa2,112(a2)
 c1e:	7420                	flw	fs0,104(s0)
 c20:	7865                	lui	a6,0xffff9
 c22:	4074                	lw	a3,68(s0)
 c24:	6425                	lui	s0,0x9
 c26:	2064252b          	.4byte	0x2064252b
 c2a:	6164                	flw	fs1,68(a0)
 c2c:	6174                	flw	fa3,68(a0)
 c2e:	2540                	fld	fs0,136(a0)
 c30:	2b64                	fld	fs1,208(a4)
 c32:	6425                	lui	s0,0x9
 c34:	7320                	flw	fs0,96(a4)
 c36:	6174                	flw	fa3,68(a0)
 c38:	25406b63          	bltu	zero,s4,e8e <_data+0x302>
 c3c:	0a64                	addi	s1,sp,284
 c3e:	0000                	unimp
 c40:	7262                	flw	ft4,56(sp)
 c42:	6d61                	lui	s10,0x18
 c44:	3a30                	fld	fa2,112(a2)
 c46:	2520                	fld	fs0,72(a0)
 c48:	2064                	fld	fs1,192(s0)
 c4a:	7962                	flw	fs2,56(sp)
 c4c:	6574                	flw	fa3,76(a0)
 c4e:	72662073          	csrs	0x726,a2
 c52:	6565                	lui	a0,0x19
 c54:	000a                	c.slli	zero,0x2
 c56:	0000                	unimp
 c58:	6175                	addi	sp,sp,368
 c5a:	7472                	flw	fs0,60(sp)
 c5c:	3a30                	fld	fa2,112(a2)
 c5e:	3120                	fld	fs0,96(a0)
 c60:	3531                	jal	a6c <board_name+0x54>
 c62:	322e                	fld	ft4,232(sp)
 c64:	7370626b          	.4byte	0x7370626b
 c68:	2820                	fld	fs0,80(s0)
 c6a:	6964                	flw	fs1,84(a0)
 c6c:	3d76                	fld	fs10,376(sp)
 c6e:	6425                	lui	s0,0x9
 c70:	0a29                	addi	s4,s4,10
 c72:	0000                	unimp
 c74:	6974                	flw	fa3,84(a0)
 c76:	726d                	lui	tp,0xffffb
 c78:	3a30                	fld	fa2,112(a2)
 c7a:	2520                	fld	fs0,72(a0)
 c7c:	4864                	lw	s1,84(s0)
 c7e:	207a                	fld	ft0,408(sp)
 c80:	6428                	flw	fa0,72(s0)
 c82:	7669                	lui	a2,0xffffa
 c84:	253d                	jal	12b2 <_stack+0x2b2>
 c86:	2964                	fld	fs1,208(a0)
 c88:	000a                	c.slli	zero,0x2
 c8a:	0000                	unimp
 c8c:	636c6557          	.4byte	0x636c6557
 c90:	20656d6f          	jal	s10,56e96 <_global+0x55786>
 c94:	6f74                	flw	fa3,92(a4)
 c96:	4420                	lw	s0,72(s0)
 c98:	7261                	lui	tp,0xffff8
 c9a:	5349526b          	.4byte	0x5349526b
 c9e:	0a215643          	fmadd.d	fa2,ft2,ft2,ft1,unknown
 ca2:	0000                	unimp
 ca4:	203e                	fld	ft0,456(sp)
 ca6:	0000                	unimp
 ca8:	656c                	flw	fa1,76(a0)
 caa:	0064                	addi	s1,sp,12
 cac:	656c                	flw	fa1,76(a0)
 cae:	2064                	fld	fs1,192(s0)
 cb0:	6c66                	flw	fs8,88(sp)
 cb2:	7069                	c.lui	zero,0xffffa
 cb4:	0a21                	addi	s4,s4,8
 cb6:	0000                	unimp
 cb8:	6572                	flw	fa0,28(sp)
 cba:	6f62                	flw	ft10,24(sp)
 cbc:	0000746f          	jal	s0,7cbc <_global+0x65ac>
 cc0:	6572                	flw	fa0,28(sp)
 cc2:	6f62                	flw	ft10,24(sp)
 cc4:	6e69746f          	jal	s0,983aa <_global+0x96c9a>
 cc8:	2e2e2e67          	.4byte	0x2e2e2e67
 ccc:	000a                	c.slli	zero,0x2
 cce:	0000                	unimp
 cd0:	4e28                	lw	a0,88(a2)
 cd2:	4c55                	li	s8,21
 cd4:	294c                	fld	fa1,144(a0)
 cd6:	0000                	unimp
 cd8:	3130                	fld	fa2,96(a0)
 cda:	3332                	fld	ft6,296(sp)
 cdc:	3534                	fld	fa3,104(a0)
 cde:	3736                	fld	fa4,360(sp)
 ce0:	3938                	fld	fa4,112(a0)
 ce2:	6261                	lui	tp,0x18
 ce4:	66656463          	bltu	a0,t1,134c <_stack+0x34c>
 ce8:	0000                	unimp
 cea:	0000                	unimp
 cec:	7661                	lui	a2,0xffff8
 cee:	656e                	flw	fa0,216(sp)
 cf0:	2074                	fld	fa3,192(s0)
 cf2:	696d                	lui	s2,0x1b
 cf4:	626f7263          	bgeu	t5,t1,1318 <_stack+0x318>
 cf8:	6472616f          	jal	sp,27b3e <_global+0x2642e>
 cfc:	6c20                	flw	fs0,88(s0)
 cfe:	3978                	fld	fa4,240(a0)
 d00:	0000                	unimp
 d02:	0000                	unimp
 d04:	756d6973          	csrrsi	s2,0x756,26
 d08:	616c                	flw	fa1,68(a0)
 d0a:	6974                	flw	fa3,84(a0)
 d0c:	6f206e6f          	jal	t3,73fe <_global+0x5cee>
 d10:	6c6e                	flw	fs8,216(sp)
 d12:	0079                	c.nop	30
 d14:	6978                	flw	fa4,84(a0)
 d16:	696c                	flw	fa1,84(a0)
 d18:	786e                	flw	fa6,248(sp)
 d1a:	6120                	flw	fs0,64(a0)
 d1c:	31303763          	.4byte	0x31303763
 d20:	6120                	flw	fs0,64(a0)
 d22:	3032                	fld	ft0,296(sp)
 d24:	0030                	addi	a2,sp,8
 d26:	0000                	unimp
 d28:	6d71                	lui	s10,0x1c
 d2a:	6574                	flw	fa3,76(a0)
 d2c:	73206863          	bltu	zero,s2,145c <_stack+0x45c>
 d30:	7264                	flw	fs1,100(a2)
 d32:	6d61                	lui	s10,0x18
 d34:	6c20                	flw	fs0,88(s0)
 d36:	3178                	fld	fa4,224(a0)
 d38:	0036                	c.slli	zero,0xd
 d3a:	0000                	unimp
 d3c:	6d71                	lui	s10,0x1c
 d3e:	6574                	flw	fa3,76(a0)
 d40:	73206863          	bltu	zero,s2,1470 <_stack+0x470>
 d44:	6170                	flw	fa2,68(a0)
 d46:	7472                	flw	fs0,60(sp)
 d48:	6e61                	lui	t3,0x18
 d4a:	31732037          	lui	zero,0x31732
 d4e:	0035                	c.nop	13
 d50:	616c                	flw	fa1,68(a0)
 d52:	7474                	flw	fa3,108(s0)
 d54:	6369                	lui	t1,0x1a
 d56:	2065                	jal	dfe <_data+0x272>
 d58:	7262                	flw	ft4,56(sp)
 d5a:	7665                	lui	a2,0xffff9
 d5c:	6169                	addi	sp,sp,208
 d5e:	2032                	fld	ft0,264(sp)
 d60:	786c                	flw	fa1,116(s0)
 d62:	3270                	fld	fa2,224(a2)
 d64:	0000                	unimp
 d66:	0000                	unimp
 d68:	6970                	flw	fa2,84(a0)
 d6a:	726f7773          	csrrci	a4,0x726,30
 d6e:	7364                	flw	fs1,100(a4)
 d70:	7220                	flw	fs0,96(a2)
 d72:	35383473          	csrrc	s0,0x353,a6
 d76:	6c20                	flw	fs0,88(s0)
 d78:	3978                	fld	fa4,240(a0)
 d7a:	0000                	unimp
 d7c:	6964                	flw	fs1,84(a0)
 d7e:	656c6967          	.4byte	0x656c6967
 d82:	746e                	flw	fs0,248(sp)
 d84:	7320                	flw	fs0,96(a4)
 d86:	6170                	flw	fa2,68(a0)
 d88:	7472                	flw	fs0,60(sp)
 d8a:	6e61                	lui	t3,0x18
 d8c:	32732033          	.4byte	0x32732033
 d90:	3030                	fld	fa2,96(s0)
 d92:	0000                	unimp
 d94:	6c61                	lui	s8,0x18
 d96:	6569                	lui	a0,0x1a
 d98:	7078                	flw	fa4,100(s0)
 d9a:	6572                	flw	fa0,28(sp)
 d9c:	68207373          	csrrci	t1,0x682,0
 da0:	6370                	flw	fa2,68(a4)
 da2:	6730342f          	.4byte	0x6730342f
 da6:	6562                	flw	fa0,24(sp)
 da8:	6b20                	flw	fs0,80(a4)
 daa:	3234                	fld	fa3,96(a2)
 dac:	0030                	addi	a2,sp,8
 dae:	0000                	unimp
 db0:	6d71                	lui	s10,0x1c
 db2:	6574                	flw	fa3,76(a0)
 db4:	61206863          	bltu	zero,s2,13c4 <_stack+0x3c4>
 db8:	7472                	flw	fs0,60(sp)
 dba:	7869                	lui	a6,0xffffa
 dbc:	33612037          	lui	zero,0x33612
 dc0:	0035                	c.nop	13
 dc2:	0000                	unimp
 dc4:	6c61                	lui	s8,0x18
 dc6:	6569                	lui	a0,0x1a
 dc8:	7078                	flw	fa4,100(s0)
 dca:	6572                	flw	fa0,28(sp)
 dcc:	68207373          	csrrci	t1,0x682,0
 dd0:	6370                	flw	fa2,68(a4)
 dd2:	6730342f          	.4byte	0x6730342f
 dd6:	6562                	flw	fa0,24(sp)
 dd8:	6b20                	flw	fs0,80(a4)
 dda:	3075                	jal	686 <putnum+0xca>
 ddc:	3034                	fld	fa3,96(s0)
 dde:	0000                	unimp
 de0:	6170                	flw	fa2,68(a0)
 de2:	6970                	flw	fa2,84(a0)
 de4:	696c                	flw	fa1,84(a0)
 de6:	7564206f          	j	4353c <_global+0x41e2c>
 dea:	6f6c206f          	j	c34e0 <_global+0xc1dd0>
 dee:	73636967          	.4byte	0x73636967
 df2:	6174                	flw	fa3,68(a0)
 df4:	7472                	flw	fs0,60(sp)
 df6:	0000                	unimp
 df8:	6d71                	lui	s10,0x1c
 dfa:	6574                	flw	fa3,76(a0)
 dfc:	6b206863          	bltu	zero,s2,14ac <_stack+0x4ac>
 e00:	6e69                	lui	t3,0x1a
 e02:	6574                	flw	fa3,76(a0)
 e04:	2d78                	fld	fa4,216(a0)
 e06:	336b2037          	lui	zero,0x336b2
 e0a:	3532                	fld	fa0,296(sp)
 e0c:	0000                	unimp
 e0e:	0000                	unimp
 e10:	72616373          	csrrsi	t1,0x726,2
 e14:	6261                	lui	tp,0x18
 e16:	6d20                	flw	fs0,88(a0)
 e18:	6e69                	lui	t3,0x1a
 e1a:	7369                	lui	t1,0xffffa
 e1c:	6170                	flw	fa2,68(a0)
 e1e:	7472                	flw	fs0,60(sp)
 e20:	6e61                	lui	t3,0x18
 e22:	2d36                	fld	fs10,328(sp)
 e24:	6c70                	flw	fa2,92(s0)
 e26:	7375                	lui	t1,0xffffd
 e28:	6c20                	flw	fs0,88(s0)
 e2a:	3978                	fld	fa4,240(a0)
 e2c:	0000                	unimp
 e2e:	0000                	unimp
 e30:	616c                	flw	fa1,68(a0)
 e32:	7474                	flw	fa3,108(s0)
 e34:	6369                	lui	t1,0x1a
 e36:	2065                	jal	ede <_data+0x352>
 e38:	6365                	lui	t1,0x19
 e3a:	3570                	fld	fa2,232(a0)
 e3c:	342d                	jal	866 <printf+0x116>
 e3e:	4635                	li	a2,13
 e40:	6320                	flw	fs0,64(a4)
 e42:	726f6c6f          	jal	s8,f7568 <_global+0xf5e58>
 e46:	696c                	flw	fa1,84(a0)
 e48:	69746867          	.4byte	0x69746867
 e4c:	0039                	c.nop	14
 e4e:	0000                	unimp
 e50:	616c                	flw	fa1,68(a0)
 e52:	7474                	flw	fa3,108(s0)
 e54:	6369                	lui	t1,0x1a
 e56:	2065                	jal	efe <_data+0x372>
 e58:	6365                	lui	t1,0x19
 e5a:	3570                	fld	fa2,232(a0)
 e5c:	322d                	jal	786 <printf+0x36>
 e5e:	4635                	li	a2,13
 e60:	6320                	flw	fs0,64(a4)
 e62:	726f6c6f          	jal	s8,f7588 <_global+0xf5e78>
 e66:	696c                	flw	fa1,84(a0)
 e68:	69746867          	.4byte	0x69746867
 e6c:	0035                	c.nop	13
 e6e:	0000                	unimp
 e70:	616c                	flw	fa1,68(a0)
 e72:	7474                	flw	fa3,108(s0)
 e74:	6369                	lui	t1,0x1a
 e76:	2065                	jal	f1e <utimers+0xe>
 e78:	6365                	lui	t1,0x19
 e7a:	3570                	fld	fa2,232(a0)
 e7c:	382d                	jal	6b6 <putnum+0xfa>
 e7e:	4635                	li	a2,13
 e80:	7520                	flw	fs0,104(a0)
 e82:	786c                	flw	fa1,116(s0)
 e84:	00007333          	and	t1,zero,zero
 e88:	6d71                	lui	s10,0x1c
 e8a:	6574                	flw	fa3,76(a0)
 e8c:	63206863          	bltu	zero,s2,14bc <_stack+0x4bc>
 e90:	6379                	lui	t1,0x1e
 e92:	6f6c                	flw	fa1,92(a4)
 e94:	656e                	flw	fa0,216(sp)
 e96:	3120                	fld	fs0,96(a0)
 e98:	6c30                	flw	fa2,88(s0)
 e9a:	2070                	fld	fa2,192(s0)
 e9c:	36313063          	.4byte	0x36313063
 ea0:	0000                	unimp
 ea2:	0000                	unimp
 ea4:	6e75                	lui	t3,0x1d
 ea6:	776f6e6b          	.4byte	0x776f6e6b
 eaa:	006e                	c.slli	zero,0x1b
 eac:	6970                	flw	fa2,84(a0)
 eae:	726f7773          	csrrci	a4,0x726,30
 eb2:	7364                	flw	fs1,100(a4)
 eb4:	6320                	flw	fs0,64(a4)
 eb6:	3368                	fld	fa0,224(a4)
 eb8:	7834                	flw	fa3,112(s0)
 eba:	6c20                	flw	fs0,88(s0)
 ebc:	3178                	fld	fa4,224(a0)
 ebe:	0036                	c.slli	zero,0xd
 ec0:	fb7c                	fsw	fa5,116(a4)
 ec2:	ffff                	.2byte	0xffff
 ec4:	fb88                	fsw	fa0,48(a5)
 ec6:	ffff                	.2byte	0xffff
 ec8:	fc54                	fsw	fa3,60(s0)
 eca:	ffff                	.2byte	0xffff
 ecc:	fc48                	fsw	fa0,60(s0)
 ece:	ffff                	.2byte	0xffff
 ed0:	fc3c                	fsw	fa5,120(s0)
 ed2:	ffff                	.2byte	0xffff
 ed4:	fc30                	fsw	fa2,120(s0)
 ed6:	ffff                	.2byte	0xffff
 ed8:	fc24                	fsw	fs1,120(s0)
 eda:	ffff                	.2byte	0xffff
 edc:	fc18                	fsw	fa4,56(s0)
 ede:	ffff                	.2byte	0xffff
 ee0:	fc0c                	fsw	fa1,56(s0)
 ee2:	ffff                	.2byte	0xffff
 ee4:	fc00                	fsw	fs0,56(s0)
 ee6:	ffff                	.2byte	0xffff
 ee8:	fbf4                	fsw	fa3,116(a5)
 eea:	ffff                	.2byte	0xffff
 eec:	fbe8                	fsw	fa0,116(a5)
 eee:	ffff                	.2byte	0xffff
 ef0:	fbdc                	fsw	fa5,52(a5)
 ef2:	ffff                	.2byte	0xffff
 ef4:	fbd0                	fsw	fa2,52(a5)
 ef6:	ffff                	.2byte	0xffff
 ef8:	fbc4                	fsw	fs1,52(a5)
 efa:	ffff                	.2byte	0xffff
 efc:	fbb8                	fsw	fa4,112(a5)
 efe:	ffff                	.2byte	0xffff
 f00:	fbac                	fsw	fa1,112(a5)
 f02:	ffff                	.2byte	0xffff
 f04:	fba0                	fsw	fs0,112(a5)
 f06:	ffff                	.2byte	0xffff
 f08:	fb94                	fsw	fa3,48(a5)
 f0a:	ffff                	.2byte	0xffff

00000f0c <io>:
 f0c:	0000                	unimp
 f0e:	8000                	.2byte	0x8000

00000f10 <utimers>:
 f10:	0000                	unimp
 f12:	0000                	unimp
 f14:	1941                	addi	s2,s2,-16 # 1aff0 <_global+0x198e0>
 f16:	0000                	unimp
 f18:	7200                	flw	fs0,32(a2)
 f1a:	7369                	lui	t1,0xffffa
 f1c:	01007663          	bgeu	zero,a6,f28 <utimers+0x18>
 f20:	0000000f          	fence	unknown,unknown
 f24:	7205                	lui	tp,0xfffe1
 f26:	3376                	fld	ft6,376(sp)
 f28:	6932                	flw	fs2,12(sp)
 f2a:	7032                	flw	ft0,44(sp)
 f2c:	0030                	addi	a2,sp,8
	...

00000f30 <_GLOBAL_OFFSET_TABLE_>:
 f30:	0000                	unimp
 f32:	0000                	unimp
 f34:	0f10                	addi	a2,sp,912
 f36:	0000                	unimp
 f38:	0b8c                	addi	a1,sp,464
 f3a:	0000                	unimp
 f3c:	1710                	addi	a2,sp,928
 f3e:	0000                	unimp
 f40:	0f0c                	addi	a1,sp,912
 f42:	0000                	unimp
 f44:	0200                	addi	s0,sp,256
 f46:	0000                	unimp
 f48:	0200                	addi	s0,sp,256
 f4a:	0000                	unimp
 f4c:	0b8c                	addi	a1,sp,464
 f4e:	0000                	unimp
 f50:	00000ff7          	.4byte	0xff7
 f54:	1000                	addi	s0,sp,32
 f56:	0000                	unimp
 f58:	ffff                	.2byte	0xffff
 f5a:	ffff                	.2byte	0xffff
 f5c:	0000                	unimp
 f5e:	0000                	unimp
 f60:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
 f64:	2820                	fld	fs0,80(s0)
 f66:	6255                	lui	tp,0x15
 f68:	6e75                	lui	t3,0x1d
 f6a:	7574                	flw	fa3,108(a0)
 f6c:	3120                	fld	fs0,96(a0)
 f6e:	2e31                	jal	128a <_stack+0x28a>
 f70:	2e34                	fld	fa3,88(a2)
 f72:	2d30                	fld	fa2,88(a0)
 f74:	7531                	lui	a0,0xfffec
 f76:	7562                	flw	fa0,56(sp)
 f78:	746e                	flw	fs0,248(sp)
 f7a:	3175                	jal	c26 <_data+0x9a>
 f7c:	327e                	fld	ft4,504(sp)
 f7e:	2e32                	fld	ft8,264(sp)
 f80:	3430                	fld	fa2,104(s0)
 f82:	2029                	jal	f8c <_GLOBAL_OFFSET_TABLE_+0x5c>
 f84:	3131                	jal	b90 <_data+0x4>
 f86:	342e                	fld	fs0,232(sp)
 f88:	302e                	fld	ft0,232(sp)
 f8a:	4100                	lw	s0,0(a0)
 f8c:	0019                	c.nop	6
 f8e:	0000                	unimp
 f90:	6972                	flw	fs2,28(sp)
 f92:	00766373          	csrrsi	t1,0x7,12
 f96:	0f01                	addi	t5,t5,0
 f98:	0000                	unimp
 f9a:	0500                	addi	s0,sp,640
 f9c:	7672                	flw	fa2,60(sp)
 f9e:	32693233          	.4byte	0x32693233
 fa2:	3070                	fld	fa2,224(s0)
 fa4:	4100                	lw	s0,0(a0)
 fa6:	0019                	c.nop	6
 fa8:	0000                	unimp
 faa:	6972                	flw	fs2,28(sp)
 fac:	00766373          	csrrsi	t1,0x7,12
 fb0:	0f01                	addi	t5,t5,0
 fb2:	0000                	unimp
 fb4:	0500                	addi	s0,sp,640
 fb6:	7672                	flw	fa2,60(sp)
 fb8:	32693233          	.4byte	0x32693233
 fbc:	3070                	fld	fa2,224(s0)
 fbe:	4100                	lw	s0,0(a0)
 fc0:	0019                	c.nop	6
 fc2:	0000                	unimp
 fc4:	6972                	flw	fs2,28(sp)
 fc6:	00766373          	csrrsi	t1,0x7,12
 fca:	0f01                	addi	t5,t5,0
 fcc:	0000                	unimp
 fce:	0500                	addi	s0,sp,640
 fd0:	7672                	flw	fa2,60(sp)
 fd2:	32693233          	.4byte	0x32693233
 fd6:	3070                	fld	fa2,224(s0)
 fd8:	4100                	lw	s0,0(a0)
 fda:	001d                	c.nop	7
 fdc:	0000                	unimp
 fde:	6972                	flw	fs2,28(sp)
 fe0:	00766373          	csrrsi	t1,0x7,12
 fe4:	1301                	addi	t1,t1,-32 # ffff9fe0 <_global+0xffff88d0>
 fe6:	0000                	unimp
 fe8:	0500                	addi	s0,sp,640
 fea:	7672                	flw	fa2,60(sp)
 fec:	32693233          	.4byte	0x32693233
 ff0:	3070                	fld	fa2,224(s0)
 ff2:	0800                	addi	s0,sp,16
 ff4:	0a01                	addi	s4,s4,0
 ff6:	0b              	Address 0x0000000000000ff6 is out of bounds.

