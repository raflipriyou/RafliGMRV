# Add your application here:

APPLICATION = darkshell
#APPLICATION = coremark
#APPLICATION = badapple
#APPLICATION = mandelbrot
#APPLICATION = cobaduls
#APPLICATION = asembli

# un-select SMALL for coremark!
export SMALL = 1# uncomment for smaller firmware

SHELL := /bin/bash

ifndef HOST_CC
    HOST_CC = gcc
    HOST_CFLAGS = -Wall -Wno-incompatible-library-redeclaration -I../common -O2
endif

ifndef CROSS

    export ARCH = rv32i_zicsr
    
    export ABI = ilp32e

	export CROSS = riscv64-linux-gnu

	export CCPATH = /usr/bin

endif

ifndef BUILD
    BUILD = $(shell date -R)
endif

ifndef DARKLIBC
    DARKLIBC = darklibc
endif

    CC  = $(CCPATH)/$(CROSS)-gcc
    AS  = $(CCPATH)/$(CROSS)-as
    RL = $(CCPATH)/$(CROSS)-ranlib
    LD  = $(CCPATH)/$(CROSS)-ld
    OC  = $(CCPATH)/$(CROSS)-objcopy
    OD  = $(CCPATH)/$(CROSS)-objdump
    CPP = $(CCPATH)/$(CROSS)-cpp

CCFLAGS = -Wall -fcommon -ffreestanding -O2
CCFLAGS += -march=$(ARCH) -mabi=$(ABI) -I$(DARKLIBC)/include
CCFLAGS += -D__RISCV__ -DBUILD="\"$(BUILD)\"" -DARCH="\"$(ARCH)\""
ASFLAGS = -march=$(ARCH)
LDFLAGS = -T$(PROJ).ld -Map=$(PROJ).map -m elf32lriscv -static -gc-sections --entry=_start # -Ttext=0
LDLIBS  = $(LIBS)
CPFLAGS = -P 

CCFLAGS += -mcmodel=medany -mexplicit-relocs # relocable clode

ifdef HARVARD
	CPFLAGS +=  -DHARVARD=1
	export HARVARD
endif

OCFLAGS = -O binary # --reverse-bytes=4 # workaround for darkriscv big-endian blockrams
ODFLAGS = -D

PROJ = darksocv
LIBS = $(APPLICATION)/$(APPLICATION).a $(DARKLIBC)/$(DARKLIBC).a 
OBJS = boot.o
ASMS = boot.s
SRCS = 

ifdef SMALL
    CPFLAGS += -DSMALL=1
endif

DEPS = $(SRCS) $(ASMS) $(OBJS) $(PROJ).ld $(PROJ).lds $(LIBS) $(APPLICATION)/$(APPLICATION).a

TARGETS = $(PROJ).mem 

.PHONY: all
all: $(TARGETS) $(DEPS)
#all: $(DEPS)
	-echo build is ok for $(TARGETS)

$(DARKLIBC)/$(DARKLIBC).a:
	make -C $(DARKLIBC) all

$(APPLICATION)/$(APPLICATION).a:
	make -C $(APPLICATION) all

clean:
	make -C $(DARKLIBC) clean
	make -C $(APPLICATION) clean
	-rm -f $(OBJS) $(PROJ).{S,bin,lst,map,ram,rom,x86,text,data,bin,ld,o,mem,rom.mem,ram.mem} $(PROJ)_uart.bin

#ini utk dpt file berisi kode o dari s
%.o: %.s Makefile
	$(AS) $(ASFLAGS) -c $< -o $@

#ini utk dpt file berisi kode s dari c
%.s: %.c Makefile
	$(CC) $(CCFLAGS) -S $< -o $@

$(PROJ).ld: $(PROJ).lds Makefile
	$(CPP) $(CPFLAGS) $(PROJ).lds $(PROJ).ld
	
$(PROJ).o: $(OBJS) $(PROJ).ld $(LIBS)
	$(RL) $(LDLIBS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)
	$(OD) $(ODFLAGS) $@ > $(PROJ).S

$(PROJ).rom.mem: $(PROJ).o
	$(OC) $(OCFLAGS) $< $(PROJ).text --only-section .*text* 
	hexdump -ve '1/4 "%08x\n"' $(PROJ).text > $@
	#xxd -p -c 4 -g 4 $< > $@
	rm $(PROJ).text
	wc -l $@
	@echo rom ok.

$(PROJ).ram.mem: $(PROJ).o
	$(OC) $(OCFLAGS) $< $(PROJ).data --only-section .*data*
	hexdump -ve '1/4 "%08x\n"' $(PROJ).data > $@
	#xxd -p -c 4 -g 4 $< > $@
	rm $(PROJ).data
	wc -l $@
	@echo ram ok.

# ini bagian utk ngambil ins berupa hex dan masukin ke darksocv.mem
$(PROJ).mem: $(PROJ).o
	$(OC) $(OCFLAGS) $< $(PROJ).bin
#	ini baris utk translate bin ke hex dan simpan ke .mem
	hexdump -ve '1/4 "%08x\n"' $(PROJ).bin > $@ 
	# uncomment for big-endian
	#xxd -p -c 4 -g 4 $< > $@
	dd if=$(PROJ).bin of=$(PROJ)_uart.bin skip=512 bs=1
#	rm $(PROJ).bin
	# uncomment for MIF file
	#awk 'BEGIN { print "DEPTH = 1024;\nWIDTH = 32;\nADDRESS_RADIX = HEX;\nDATA_RADIX = HEX;\nCONTENT\nBEGIN" } { printf("%08x : %s\n",NR-1,$1); } END { print "END;" }' < $(PROJ).mem > $(PROJ).mif
	wc -l $@
	@echo mem ok.
	
