CFLAGS = -Wall -O0 -mcpu=cortex-a53+nosimd

all: clean main


%.o: %.s
	clang --target=aarch64-elf $(CFLAGS) -g -c $< -o $@
	llvm-objdump-11 -d -s $@ > $@.assembled.dump
	readelf -a $@ > $@.assembled.readelf.dump

main: main.o
	#ld.lld -m aarch64elf -dynamic-linker /lib/ld-linux-aarch64.so.1 main.o -o main
	#Ci serve questo comando lungo per linkare perchè dobbiamo linkare anche la libc (printf, scanf, fflush). è possibile vedere come viene usato da clang dando il comando "clang -v -o main main.s"
	#Se il linking con ld.lld fallisce (magari voi avete le librerie da un'altra parte), viene comunque generato il file eseguibile direttamente con clang
	ld.lld -m aarch64elf -dynamic-linker /lib/ld-linux-aarch64.so.1 -o $@ /usr/bin/../lib/gcc/aarch64-linux-gnu/10/../../../aarch64-linux-gnu/crt1.o /usr/bin/../lib/gcc/aarch64-linux-gnu/10/../../../aarch64-linux-gnu/crti.o /usr/bin/../lib/gcc/aarch64-linux-gnu/10/crtbegin.o -L/usr/bin/../lib/gcc/aarch64-linux-gnu/10 -L/usr/bin/../lib/gcc/aarch64-linux-gnu/10/../../../aarch64-linux-gnu -L/lib/aarch64-linux-gnu -L/usr/lib/aarch64-linux-gnu -L/usr/bin/../lib/gcc/aarch64-linux-gnu/10/../../.. -L/usr/lib/llvm-11/bin/../lib -L/lib -L/usr/lib $< -lgcc --as-needed -lgcc_s --no-as-needed -lc -lgcc --as-needed -lgcc_s --no-as-needed /usr/bin/../lib/gcc/aarch64-linux-gnu/10/crtend.o /usr/bin/../lib/gcc/aarch64-linux-gnu/10/../../../aarch64-linux-gnu/crtn.o || (echo '***Linking fallito, compilo direttamente con clang***'; clang -o $@ $<)
	llvm-objdump-11 -d -s $@ > $@.linked.dump
	readelf -a $@ > $@.linked.readelf.dump


.PHONY: clean
clean:
	rm main *.o *.dump  >/dev/null 2>/dev/null || true

