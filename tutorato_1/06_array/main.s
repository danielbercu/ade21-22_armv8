    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma
/* Versione in pseudo-c
 // arr è un array globale con valori: 11, 8, 3, 22, 59, 6, 16, 0, 3, 2 

x3 = &arr
x1 = 10     // lunghezza array
w2 = 0      // accumulatore

for (x0 = 0; x0 < x1; x0++){
	w2 += x3[x0];  // w2 += ( x3 + ( x0*sizeof(int) ) )*
}
exit(0);
*/	

	adr x3, arr 		// x3 = &arr
	mov x1, #10 		// x1 = 10
	mov w2, #0			// w2 = 0, l'accumulatore è un registro a 32 bit perchè le variabili sono int 32b 
	mov x0, #0 			// x0 = 0
	
	cmp x0, x1
	b.ge endfor			// if (x0 >= x1) goto endfor
initfor:
	add x4, x3, x0, LSL#2	// x4 = arr + (x0 * 4)
	ldr w5, [x4] 			// w5 = arr[x0]
	add w2, w2, w5	  		// w2 += w5
	add x0, x0, #1	 		// x0 ++
	
	cmp x0, x1
	b.lt initfor			// if (x0 < x1) goto initfor
endfor:

    // Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


    // Dati del programma

    .data
    .p2align 2

arr: .word 11, 8, 3, 22, 59, 6, 16, 0, 3, 2
