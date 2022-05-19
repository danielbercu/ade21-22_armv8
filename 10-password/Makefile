
CFLAGS = -Wall -O0 

all: clean password


%.o: %.c
	clang $(CFLAGS) -g -c $< -o $@
	llvm-objdump-11 -d -s $@ > $@.assembled.c.dump

password: main.o 
	clang main.o -o password
	llvm-objdump-11 -d -s $@ > $@.linked.dump
	readelf -a $@ > $@.linked.readelf.dump


.PHONY: clean
clean:
	rm password *.o *.dump  >/dev/null 2>/dev/null || true


