    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma


    movz x0, #0x1111, LSL #48 // x4 = 0x1111111111111111
    movk x0, #0x1111, LSL #32
    movk x0, #0x1111, LSL #16
    movk x0, #0x1111

    movz x1, #0x2222, LSL #48 // x4 = 0x2222222222222222
    movk x1, #0x2222, LSL #32
    movk x1, #0x2222, LSL #16
    movk x1, #0x2222

    add x2, x0, x1      // x2 = x0 + x1
    add x2, x0, #1      // x2 = x0 + 1
    
    movz x0, #0x7fff, LSL #48 // x0 = 0x7ffffffffffffffe
    movk x0, #0xffff, LSL #32
    movk x0, #0xffff, LSL #16
    movk x0, #0xfffe
    
    add x2, x0, #1      // overflow?
    add x2, x2, #1  
    sub x2, x2, #1 

    movz w0, #0x7fff, LSL #16 // w0 = 0x7ffffff
    movk w0, #0xffff

    add w2, w0, #1      // overflow?

    // Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall
