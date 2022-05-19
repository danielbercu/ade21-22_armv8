# sudo apt install clang lld lldb
# 

CFLAGS = -Wall -O0 -mcpu=cortex-a53+nosimd

all: clean functioncall


%.o: %.s
	clang --target=aarch64-elf $(CFLAGS) -g -c $< -o $@
	llvm-objdump-11 -d -s $@ > $@.assembled.dump
	readelf -a $@ > $@.assembled.readelf.dump

%.o: %.c
	clang --target=aarch64-elf $(CFLAGS) -g -c $< -o $@
	llvm-objdump-11 -d -s $@ > $@.assembled.c.dump

functioncall: main.o strlen.o
	ld.lld -m aarch64elf -nostdlib main.o strlen.o -o functioncall
	llvm-objdump-11 -d -s $@ > $@.linked.dump
	readelf -a $@ > $@.linked.readelf.dump


.PHONY: clean
clean:
	rm functioncall *.o *.dump  >/dev/null 2>/dev/null || true


