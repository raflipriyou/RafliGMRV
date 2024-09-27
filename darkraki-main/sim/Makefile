ifndef ICARUS
    ICARUS = iverilog -Wall
endif

#RTLS = darksimv.v ../rtl/darksocv.v ../rtl/darkuart.v ../rtl/darkriscv.v ../rtl/darkpll.v
RTLS = darksimv.v 
#../rtl/socriscv32.v ../rtl/memory_ram.v ../rtl/memory_rom.v 
INCS = /home/raflipriyou/darkraki-main/rtl/conf.vh
XSIM = darksocv
VCDS = darksocv.vcd

.PRECIOUS: $(VCDS)	# Do not delete the trace file if simulation is aborted
.PHONY: $(VCDS)		# Always run the simulation

#SRCS = ../src/darksocv.mem
SRCS = ../rtl/memory_rom_init.hex

DEPS = $(SRCS) $(RTLS) $(INCS)

all: $(VCDS)
	@echo simulation ok.

clean:
	-rm $(VCDS) $(XSIM)

$(VCDS): $(XSIM)
	./$(XSIM)


$(XSIM): $(DEPS)
	$(ICARUS) -I ../rtl -o $(XSIM) $(RTLS)
