    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2

/* programma in pseudo-c
int fib(int n){
    if (n <= 1){
		return n;
	}
	return fib(n-1) + fib(n-2); 
}	

int main(){
	n = 0 			//variabile locale n

	printf("Inserire n per calcolare la serie di fibonacci fino all'n-esimo numero:\n");

	scanf("%d", &n);

	printf("I primi %d numeri della serie sono: ", n);
	for(w19=0, w19 < n, w19++){
		printf("%d ", fib(w19));
	}
	printf("\n");
	exit(0),
}
*/

	.global fib
fib:
	cmp w0, 1					// if (w0 == 1) return 1
	b.le fib_ret
	
	str LR, [SP, #-16]!			// registri callee-saved
	str x19, [SP, #-16]!
	
	mov w19, w0					// mettiamo il valore del parametro in w19
								// perchè vogliamo che sia preservato 
								// dalla chiamata ricorsiva a fib()
	sub w0, w19, #1			
	bl fib						// fib(w19-1)
	
	sub w1, w19, #2
	mov w19, w0					
	mov w0, w1					// mettiamo w19-2 in w0 e 
								// w0 (ret_value della chiamata a fib()) in w19
	bl fib						// fib(w19-2)
	
	add w0, w0, w19				// ret_value = fib(w19-1) + fib(w19-2)
	ldr x19, [SP], #16			// registri callee-saved
	ldr LR, [SP], #16	
fib_ret:
	ret


    .global main  // definiamo un simbolo globale chiamato _start

main:             // etichetta _start specifica l'entry-point del
                    // nostro programma

	str LR, [SP, #-16]!
	stp x19, x20, [SP, #-16]!
	
	adr x0, banner
	bl printf				// print("Inserire n per calcolare la serie di fibonacci fino all'n    -esimo numero:\n")
	
	sub SP, SP, 16			// creiamo spazio nello stack per la variabile n
	adr x0, scan_str			
	mov x1, SP
	bl scanf				// scanf("%d", &n)
	
	ldr w20, [SP], #16		//carichiamo il valore di n in w20
	
	adr x0, banner2
	mov w1, w20
	bl printf				// printf("I primi %d numeri della serie sono: ", n)
	
	mov x0, #0
	bl fflush				// fflush(0) altrimenti non stampa

	mov w19, #0				// w19 indice
	cmp w19, w20			// w20 max value
	b.ge end_for 			// while(w19 < w20)
initfor:
	mov w0, w19				
	bl fib					// fib(w19)
							
	mov w1, w0
	adr x0, print_str
	bl printf				// printf("%d ", fib(w19))
	
	mov x0, #0
	bl fflush				// fflush(0) per stampare
	
	add w19, w19, #1		// w19++
	
	cmp w19, w20			
	b.lt initfor
end_for:
	adr x0, endl
	bl printf				//printf("\n")
	
	ldp x19, x20, [SP], #16		//registri callee-saved
	ldr LR, [SP], #16
	 
		

	
	// Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall

    // Dati del programma

    .data
    .p2align 2

banner: .string "Inserire n per calcolare la serie di fibonacci fino all'n-esimo numero:\n"
banner2: .string "I primi %d numeri della serie sono: "
scan_str: .string "%d"
print_str: .string "%d "
endl: .string "\n"
