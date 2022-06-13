blank: blank.o
	ld.lld -m aarch64elf -nostdlib blank.o -o blank
	rm *.o

blank.o: blank.s
	clang --target=aarch64elf -Wall -O0 -mcpu=cortex-a53+nosimd -g -c blank.s -o blank.o

clean:
	rm blank