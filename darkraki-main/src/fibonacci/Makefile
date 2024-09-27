SHELL := /bin/bash

ifndef HOST_CC
    HOST_CC = gcc
    HOST_CFLAGS = -Wall -Wno-incompatible-library-redeclaration -I../common -O2
endif

ifndef CROSS

    ARCH = rv32i
    #ARCH = rv32i
    
    ABI = ilp32e
    #ABI = ilp32
    
    #TODO: better way to switch little/big-endian:
    #ENDIAN = _le # gcc for little-endian
    #ENDIAN = _be # gcc for big-endian

    CROSS = riscv64-linux-gnu
    #CROSS = riscv-elf
    #CROSS = riscv32-unknown-elf
    #CROSS = riscv32-embedded-elf
    
    CCPATH = /usr/bin
    #CCPATH = /usr/local/share/toolchain-$(CROSS)/bin
    #HARVARD = 1
endif

ifndef BUILD
    BUILD = $(shell date -R)
endif

ifndef DARKLIBC
    DARKLIBC = ../darklibc
endif

    CC = $(CCPATH)/$(CROSS)-gcc
    AS = $(CCPATH)/$(CROSS)-as
    LD = $(CCPATH)/$(CROSS)-ld
    AR = $(CCPATH)/$(CROSS)-ar
    RL = $(CCPATH)/$(CROSS)-ranlib
    OC = $(CCPATH)/$(CROSS)-objcopy
    OD = $(CCPATH)/$(CROSS)-objdump
   CPP = $(CCPATH)/$(CROSS)-cpp

CCFLAGS = -Wall -fcommon -ffreestanding -O2
CCFLAGS += -march=$(ARCH) -mabi=$(ABI) -I$(DARKLIBC)/include
CCFLAGS += -D__RISCV__ -DBUILD="\"$(BUILD)\"" -DARCH="\"$(ARCH)\""
#CCFLAGS += -DSMALL # enable this to make FW smaller!
ASFLAGS = -march=$(ARCH)
ARFLAGS = -rcs
LDFLAGS = -Map=$(PROJ).map -m elf32lriscv -static -gc-sections  --entry=_start -Ttext=0 -T$(PROJ).ld
LDLIBS  = $(DARKLIBC)/darklibc.a
CPFLAGS = -P 

CCFLAGS += -mcmodel=medany -mexplicit-relocs # relocable clode

ifdef HARVARD
	CPFLAGS +=  -DHARVARD=1
endif

ifdef SMALL
    CCFLAGS += -DSMALL
endif

OCFLAGS = -O binary # --reverse-bytes=4 # workaround for darkriscv big-endian blockrams
ODFLAGS = -D

PROJ = tester
OBJS = $(PROJ).o
ASMS = $(PROJ).s
SRCS = $(PROJ).c
LINK = $(PROJ).ld
ELEP = $(PROJ).elf
LIBS = $(PROJ).a $(DARKLIBC)/darklibc.a 

DEPS = $(SRCS) $(ASMS) $(OBJS) $(LIBS) $(PROJ).lds # $(PROJ).ld  $(DARKLIBC)/darklibc.a

TARGETS1 = $(PROJ).a
TARGETS2 = $(PROJ).bin
TARGETS3 = $(PROJ).mem
TARGETS4 = $(PROJ).o
TARGETS5 = $(PROJ).out

.PHONY: all

all: $(ASMS) $(TARGETS1) $(TARGETS2) $(TARGETS3) $(TARGETS4) $(TARGETS5) $(OBJS) $(LIBS) $(ELEP) $(PROJ).a 
#	@echo sources ok for $(TARGETS).

res:
	-rm -f $(ASMS) $(OBJS) $(PROJ).{S,bin,lst,map,ram,rom,x86,text,data,bin,ld,o,mem,rom.mem,ram.mem,a,out,elf} $(PROJ)_uart.bin

clean: 

%.o: %.s Makefile
	$(AS) $(ASFLAGS) -c $< -o $@

%.s: %.c Makefile
	$(CC) $(CCFLAGS) -S $< -o $@

$(PROJ).a: $(OBJS) 
	$(AR) $(ARFLAGS) $@ $(OBJS)
	$(RL) $@
	
$(PROJ).out: $(OBJS) $(PROJ).ld $(LIBS)
	$(RL) $(LDLIBS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

$(PROJ).ld: $(PROJ).lds Makefile
	$(CPP) $(CPFLAGS) $(PROJ).lds $(PROJ).ld

$(PROJ).bin: $(PROJ).o
	$(OC) $(OCFLAGS) $< $(PROJ).bin

$(ELEP): $(PROJ).o
	$(LD) $(LDFLAGS) -o $@ $<

# Rule untuk menampilkan informasi dari file ELF
objdumps: $(ELEP)
	$(OD) $(ODFLAGS) $(ELEP)

$(PROJ).mem: $(OBJS)
	hexdump -ve '1/4 "%08x\n"' $(PROJ).bin > $@ 
	wc -l $@
	@echo mem ok.
