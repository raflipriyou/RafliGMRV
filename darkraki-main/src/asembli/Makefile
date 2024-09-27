SHELL := /bin/bash

ifndef HOST_CC
    HOST_CC = gcc
    HOST_CFLAGS = -Wall -Wno-incompatible-library-redeclaration -I../common -O2
endif

ifndef CROSS
    ARCH = rv32e
    
    ABI = ilp32e

#    CROSS = riscv64-linux-gnu
    CROSS = riscv64-unknown-elf
    
    CCPATH = /usr/bin
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
LDFLAGS = -Map=$(PROJ).map -m elf32lriscv -static -gc-sections # --entry=_start # -Ttext=0 -T$(PROJ).ld
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

PROJ = asembli
OBJS = asembli.o
ASMS = asembli.s
ELF = $(PROJ).elf
LINK = $(PROJ).ld
LIBS = $(APPLICATION).a $(DARKLIBC)/darklibc.a 
APPLICATION = asembli
#SRCS = assembly.c

#DEPS =  $(ASMS) $(OBJS) $(LIBS) # $(SRCS) $(PROJ).ld $(PROJ).lds $(DARKLIBC)/darklibc.a
DEPS =  $(ASMS) $(TARGETS1) $(TARGETS2) $(OBJS) $(LIBS) $(ELF) $(APPLICATION).a# $(SRCS) $(PROJ).ld $(PROJ).lds $(DARKLIBC)/darklibc.a

TARGETS1 = $(PROJ).a
TARGETS2 = $(PROJ).bin
TARGETS3 = $(PROJ).mem
TARGETS4 = $(PROJ).o
TARGETS5 = $(PROJ).hex

.PHONY: all
#all: $(ASMS) $(TARGETS1) $(DEPS) $(TARGETS2) $(TARGETS3) 
all: $(TARGETS1) $(TARGETS2) $(TARGETS3) $(TARGETS4) $(DEPS) $(LINK)

#all: $(DEPS) 
#    $(AS) $(ASFLAGS) -o $(OBJS) $(ASMS)
#    $(LD) $(LDFLAGS) $(TARGETS) $(OBJS)
#	@echo sources ok for $(TARGETS).

clean:
#	-rm -f $(OBJS) $(PROJ).{bin,lst,map,ram,rom,x86,text,data,bin,ld,o,mem,rom.mem,ram.mem,a} $(PROJ)_uart.bin 
    -rm -f $(OBJS) $(PROJ).{bin,lst,map,ram,rom,x86,text,data,bin,ld,o,mem,rom.mem,ram.mem,a,elf,hex,out} $(PROJ)_uart.bin 


#fana: $(PROJ)

%.o: %.s Makefile
	$(AS) $(ASFLAGS) -c $< -o $@

$(PROJ).out: $(OBJS) $(PROJ).ld $(LIBS)
	$(RL) $(LDLIBS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

$(PROJ).a: $(OBJS) Makefile
	$(AR) $(ARFLAGS) $@ $(OBJS)
	$(RL) $@

$(PROJ).ld: $(PROJ).lds Makefile
	$(CPP) $(CPFLAGS) $(PROJ).lds $(PROJ).ld

$(PROJ).bin: asembli.out
	$(OC) $(OCFLAGS) $< $(PROJ).bin

# $(PROJ).bin: $(ELF)
# 	$(OC) -O binary $(ELF) $@

# $(PROJ).hex: $(PROJ).bin
# 	xxd -p $(PROJ).bin | tr -d '\n' > $@
# 	@echo "Hex file good."

$(ELF): $(PROJ).out
	$(LD) $(LDFLAGS) -o $@ $<


#$(PROJ).bin: asembli.o
#    objcopy -o binary asembli.o $(PROJ).bin
#	$(OC) $(OCFLAGS) $< $(PROJ).bin


# Rule untuk menampilkan informasi dari file ELF
objdump: $(ELF)
	$(OD) $(ODFLAGS) $(ELF)

$(PROJ).mem: 
	hexdump -ve '1/4 "%08x\n"' $(PROJ).bin > $@ 
	wc -l $@
	@echo mem ok.

