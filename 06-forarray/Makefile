# sudo apt install clang lld lldb
# 

CFLAGS = -Wall -O0 -mcpu=cortex-a53+nosimd

all: clean for


%.o: %.s
	clang --target=aarch64-elf $(CFLAGS) -g -c $< -o $@
	llvm-objdump-11 -d -s $@ > $@.assembled.dump
	readelf -a $@ > $@.assembled.readelf.dump

for: main.o
	ld.lld -m aarch64elf -nostdlib main.o -o for
	llvm-objdump-11 -d -s $@ > $@.linked.dump
	readelf -a $@ > $@.linked.readelf.dump


.PHONY: clean
clean:
	rm for *.o *.dump  >/dev/null 2>/dev/null || true


