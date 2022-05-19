# sudo apt install clang lld lldb
# 

CFLAGS = -Wall -O0 -mcpu=cortex-a53+nosimd

all: clean donothing donothing_c


donothing_c: donothing.c
	clang --target=aarch64-elf $(CFLAGS) -c donothing.c -S -o donothing_c.s 
	clang --target=aarch64-elf $(CFLAGS) -g -c donothing.c -o donothing_c.o
	clang -static donothing_c.o -o donothing_c  # let clang call ld.lld so it can manage C standard libraries by itself
	llvm-objdump-11 -d donothing_c.o > donothing_c.assembled.dump
	llvm-objdump-11 -d donothing_c > donothing_c.linked.dump


donothing.o: donothing.s
	clang --target=aarch64-elf $(CFLAGS) -g -c donothing.s -o donothing.o
	llvm-objdump-11 -d -s donothing.o > donothing.assembled.dump
	readelf -a donothing.o > donothing.assembled.readelf.dump


donothing: donothing.o
	ld.lld -m aarch64elf -nostdlib donothing.o -o donothing
	#ld -nostdlib donothing.o -o donothing
	#clang donothing.o -o donothing
	llvm-objdump-11 -d -s  donothing > donothing.linked.dump
	readelf -a donothing > donothing.linked.readelf.dump


.PHONY: clean
clean:
	rm donothing donothing_c donothing_c.s *.o *.dump  >/dev/null 2>/dev/null || true

.PHONY: run
run:
	./donothing
	echo $?

