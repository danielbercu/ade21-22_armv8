    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma
	
/* programma in pseudo-c
// a e b variabili globali
 
a = 1;
b = 9;
if (a < b){
	print("a < b \n");
} else {
	print("a >= b\n");
}

if (a == 10) {
	print("a == 10\n");
}

exit(0);
*/


/* programma con i goto
// a e b variabili globali
 
a = 1;
b = 9;
if (a >= b) goto else
    print("a < b \n");
	goto endif1
else:
    print("a >= b\n");
endif1:

if (a != 10) goto endif2
    print("a == 10\n");
endif2:

exit(0);
*/



	
	adr x2, a
	adr x3, b
	ldr w0, [x2]  // w0 = a
	ldr w1, [x3] // w1 = b

	cmp w0, w1   // if (x0 >= x1) goto else
	b.ge else    
then:             
	//then branch (in realtà questa label non serve)

	mov x0, #1 			//stampa la stringa a_less_b
	adr x1, a_less_b
	mov x2, #7
    mov x8, #0x40
	svc #0
 
	b endif1
else:       		
	//else branch

    mov x0, #1          //stampa la stringa a_gte_b
    adr x1, a_gte_b
    mov x2, #8
    mov x8, #0x40
    svc #0
	
endif1:
	//fine primo if
	
	adr x1, a
	ldr w0, [x1]
	cmp w0, #10     	// if (x0 != 10) goto endif2
	b.ne endif2
	
	mov x0, #1          //stampa la stringa a_eq_10
    adr x1, a_gte_b
    mov x2, #0
    mov x8, #0x40
    svc #0

endif2:
    // Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


    // Dati del programma

    .data
    .p2align 2

a_less_b: .string "a < b\n"
a_gte_b: .string "a >= b\n"
a_eq_10: .string "a == 10\n"
a: .word 1
b: .word 9
