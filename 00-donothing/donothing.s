    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma

    // Il nostro programma non fa nulla, si limita ad invocare
    // la syscall __NR_EXIT (numero 93) per comunicare al sistema
    // operativo che il programma deve essere terminato.

    mov x0, #3      // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93     // Specifichiamo il numero della syscall in x8
    svc #0          // Invochiamo il sistema operativo. Il valore 0 e'
                    // necessario per l'istruzione svc ma non utilizzato
                    // in questo caso.

