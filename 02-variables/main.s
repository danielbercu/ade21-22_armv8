    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma


    /*

    movz x0, #0x22, LSL #16  // x0 = 0x220000
    movk x0, #0x184          // x0 = 0x220184
    ldr w1, [x0]             // w1 < mem[x0]
    movk x0, #0x188          // x0 = 0x220188
    ldr w2, [x0]             // w2 = mem[x0]
    add w2,w1,w2             // w2 = w1+w2
    movk x0, #0x18C          // x0 = 0x22018c
    str w2, [x0]             // w2 > mem[x0]
*/
 
    adr x0, a                // x0 = &a
    ldr w1, [x0]             // w1 < mem[x0]
    adr x0, b                // x0 = &b
    ldr w2, [x0]             // w2 < mem[x0]
    add w2,w1,w2             // w2 = w1+w2
    adr x0, c                // x0 = &c
    str w2, [x0]             // w2 > mem[x0]

    // Fine programma

    mov x0, #3          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


    // Dati del programma

    .data
    .p2align 2

a:  .word -5
b:  .word 20
c:  .word 0

