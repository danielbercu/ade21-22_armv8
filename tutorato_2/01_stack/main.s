    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma

	movz w0, #0xaaaa, LSL #16 		// w0 = 0xaaaaaaaa
	movk w0, #0xaaaa
	
	movz w1, #0xbbbb, LSL #16		// w1 = 0xbbbbbbbb
	movk w1, #0xbbbb
	
	movz x2, #0xcccc, LSL #48		// x2 = 0xcccccccccccccccc
    movk x2, #0xcccc, LSL #32
	movk x2, #0xcccc, LSL #16
	movk x2, 0xcccc

	mov x3, #0						// x3 = 0
	mov x4, #0						// x4 = 0
	mov x5, #0						// x5 = 0
	
	// ricordate che sp deve essere multiplo di 16,
	// quindi lo incrementiamo sempre di un multiplo di 16
	
	// Primo modo, push e pop
	str w0, [SP, #-16]!				// push w0 
	str w1, [SP, #-16]!				// push w1
	str x2, [SP, #-16]!				// push x2

	ldr x5, [SP], #16				// pop x5
	ldr w4, [SP], #16				// pop w4
	ldr w3, [SP], #16				// pop w3
	
	mov x3, #0						// x3 = 0
    mov x4, #0						// x4 = 0
    mov x5, #0						// x5 = 0
	
	// Secondo modo, decrementiamo manualmente sp

	sub SP, SP, #16					// creiamo spazio per 16 bytes
									// nello stack
	str w0, [SP, #12]				// *(sp+12) = w0
	str w1, [SP, #8]				// *(sp+8) = w1
	str x2, [SP]					// *(sp) = x2
	
	ldr x5, [SP]					// x5 = *(sp)
	ldr w4, [SP, #8]				// w4 = *(sp+8)
	ldr w3, [SP, #12]				// w3 = *(sp+12)
	add SP, SP, #16					// togliamo lo spazio per i 16 bytes	
	

	// Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall

