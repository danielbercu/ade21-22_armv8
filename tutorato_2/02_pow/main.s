    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2

/* programma in pseudo-c
:
int pow(int a){
    return a*a; 
}

x19 = 0;
while (x19< 10 ){
    pow_arr[x19] = pow(arr[x19]);
    x19++;
}


/* Procedure Call Standard (non floating point)
	parametri: registri x0-x7
	ret value: registro x0
	ret addr: registro x30 (LR)
	caller saved: x0-x15
	callee saved: x19-x27
	reserved: x8, x16, x17, x18 	
	nota: 	se una funzione a() chiama una funzione b(),
			allora a deve salvare LR nello stack perchè
			la chiamata a b() sovrascrive il LR
*/


	.global pow
pow:					// primo parametro in w0
	mul w0, w0, w0		// w0 = w0 * w0
	ret


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma
	
	// Salviamo i registri callee-saved	
	stp LR, x19, [SP, #-16]! 	// push x19, push LR		 
	stp x20, x21,[SP, #-16]!	// push x21, push x20
	
	mov x19, #0				
	adr x20, arr
	adr x21, pow_arr
	
	
	cmp x19, #10
	b.ge endwhile				//if (x19 >= 10 ) goto endwhile
initwhile:
	
	add x1, x20, x19, LSL #2	// x1 = & (arr[x19])
	ldr w0, [x1]				// w0 = arr[x19]
	bl pow						// pow(w0)
	add x1, x21, x19, LSL #2	
	str w0, [x1]				// pow_arr[x19] = w0
	add x19, x19, #1			// x19++
	
	cmp x19, #10			
	b.lt initwhile				// if (x19 < 10) goto initwhile
	
endwhile:	 
	
	// Ripristiniamo i valori dei registri callee-saved
	ldp x20, x21, [SP], #16		// pop x20, pop x21
	ldp LR, x19, [SP], #16		// pop LR, pop x19
	
	// Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall

    // Dati del programma

    .data
    .p2align 2

arr: .word 3, 10, 4, 3, 4, 5, 3, 7, 1, 9
pow_arr: .space 40
