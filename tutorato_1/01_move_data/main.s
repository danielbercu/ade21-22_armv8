    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma


    mov x0, #0x12            // x0 = 0x12
    mov x1, #12          // x1 = 0x1234
    //mov x2, #0x12345
    
    mov w2, #0x1234          // w2 = 0x1234
    //mov w3, #0x12345

    movz x3, #0x1234, LSL #16 // x3 = 0x12345678
    movk x3, #0x5678

    movz x4, #0x0123, LSL #48 // x4 = 0x0123456789abcdef
    movk x4, #0x4567, LSL #32
    movk x4, #0x89ab, LSL #16
    movk x4, #0xdcef

    //movz w5, #0x0123, LSL #48  // ricordiamo che w5 può contenere al massimo 32 bit
    //movk w5, #0x4567, LSL #32
    movz w5, #0x89ab, LSL #16 // w5 = 0x89abcdef
    movk w5, #0xdcef

	// da registro a registro 64 bit
    mov x0, xzr
    mov x0, x4
    
	// da registro a registro 32 bit
    mov x0, xzr
    //mov x0, w4
    mov w0, w4
    
    mov w0, wzr
   // mov w0, x4

    // indirizzo della label e load(32b) della variabile
	adr x0, var1
    ldr w1, [x0]
    
	// load (64b) variabile
    mov x1, xzr
    ldr x1, [x0]
    
	// load (8b) variabile, nota cosa c'è negli altri 8 bit del registro
    mov x1, xzr
    //ldrb x1, [x0]
    ldrb w1, [x0]
	
	//sign extend
    adr x0, var2
    mov x1, xzr
    ldrsb x1, [x0] 
    
	// store 32b
    adr x0, var1    
    movz w1, #0xdead, LSL #16
    movk w1, #0xbeef
    str w1, [x0]

	//store 64b
    adr x0, var2
    movz x1, #0xaaaa, LSL #48
    movk x1, #0xdead, LSL #32
    movk x1, #0xbeef, LSL #16
    movk x1, #0xaaaa
    str x1, [x0]

    // Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


    // Dati del programma

    .data
    .p2align 2

var1:  .word 0x12345678
var2:  .dword 0xaaaabbbbccccdd3d
