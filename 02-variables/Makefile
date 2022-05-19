# sudo apt install clang lld lldb
# 

CFLAGS = -Wall -O0 -mcpu=cortex-a53+nosimd

all: clean variables


%.o: %.s
	clang --target=aarch64-elf $(CFLAGS) -g -c $< -o $@
	llvm-objdump-11 -d -s $@ > $@.assembled.dump
	readelf -a $@ > $@.assembled.readelf.dump

variables: main.o
	ld.lld -m aarch64elf -nostdlib main.o -o variables
	llvm-objdump-11 -d -s $@ > $@.linked.dump
	readelf -a $@ > $@.linked.readelf.dump


.PHONY: clean
clean:
	rm variables *.o *.dump  >/dev/null 2>/dev/null || true


