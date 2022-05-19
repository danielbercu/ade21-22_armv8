    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2

/* programma in pseudo-c

void rec(int i){
	if (i == 0)
		return;
	rec(i-1);
	printf("%d\n", i);
	return;
}

int main(){
	rec(3);
	return 0;
}

*/

	.global rec
rec:
	cmp w0, #0		//se w0 è 0, ritorniamo 0
	b.ne endif
	ret
endif:	
	stp LR, x19, [SP, #-16]!	// salviamo i registri callee-saved
		
	mov w19, w0				
	sub w0, w19, #1
	bl rec						// rec(i-1)
	
	mov w1, w19
	adr x0, print_str			
	bl printf					//printf("%d\n", i)

	ldp LR, x19, [SP], #16		// ripristiniamo i registri callee-saved
	ret


    .global main  // definiamo un simbolo globale chiamato _start

main:             // etichetta funzione main, usiamo la funzione main perchè poi dobbiamo linkare printf e se uso _start mi dà problemi


	str LR, [SP, #-16]!			//registri callee-saved
	
	mov w0, #3
	bl rec						//rec(3)
	
	mov w0, #0					// ret_value = 0
	ldr LR, [SP], #16			// registri callee-saved
	ret	

    // Dati del programma

    .data
    .p2align 2

print_str: .string "%d\n"
