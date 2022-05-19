    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    // Funzioni esterne
    // -----------------------------------------------------------
    // Le funzioni seguenti sono disponibili in un altro file, sarà compito del
    // linker recuperare l'indirizzo corretto

    .global strlen_c 
    .global strlen_c_rec


    // Funzioni definite in questo file:
    // -----------------------------------------------------------


    // Funzione strlen, versione iterativa
    // 
    // Codice equivalente in C
    //
    //            long strlen_c( unsigned char* s )
    //            {
    //                long i;
    //                for( i=0; *s!=0; ++i )
    //                    s++;
    //
    //                return i;
    //            }
    .global strlen
strlen:
    // x0: string address
    // x1: i
    mov x1, #0
    ldrb w2, [x0]   // w2 = (unsigned char)[x0]
    cmp w2,#0
    b.eq endfor
initfor:
    add x0, x0, #1  // corpo for s++
    add x1, x1, #1  // incremento ++i
    ldrb w2, [x0]   // w2 = (unsigned char)[x0]
    cmp w2,#0
    b.ne initfor
endfor:
    // ritorniamo il numero di caratteri
    // in x0
    mov x0, x1
    ret



    // Funzione strlen, versione rec
    // 
    // Codice equivalente in C
    //
    //            long strlen_c_rec( unsigned char* s )
    //            {
    //                if( *s == 0 )
    //                    return 0;
    //
    //                return 1+strlen_c_rec( s+1 );
    //            }
    .global strlen_rec
strlen_rec:
    ldrb w2, [x0]       // w2 = (unsigned char)[x0]
    cmp w2, #0
    b.eq returnzero

    // Qui dobbiamo effettuare la chiamata ricorsiva. visto che chiamiamo una
    // funzione esterna (in questo caso la funzione stessa) dobbiamo salvare
    // nello stack: LR (x30) perchè va preservato. Se non lo facessimo,
    // l'istruzione ret successiva non funzionerebbe.
    //
    str x30, [sp, #-16]!  // push x30 (lr)
    add x0, x0, #1
    bl  strlen_rec
    // ora in x0 abbiamo il risultato della chiamata ricorsiva, a cui dobbiamo
    // aggiungere 1
    add x0, x0, #1
    ldr x30, [sp], #16   // pop x30 (lr)
    ret

returnzero:
    mov x0, #0
    ret


    


    // Entry-point del programma
    // -----------------------------------------------------------


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma

    adr x0, hellostr
    //bl  strlen_c
    //bl  strlen
    bl  strlen_rec

    // in x0 abbiamo la lunghezza di hellostr
    // lo spostiamo in x2 per chiamare la syscall write
    mov x2, x0         
    // Invochiamo la syscall write
    mov x0, #1          // 1 specifica lo standard output 
    adr x1, hellostr    // in x1 l'indirizzo dei dati da scrivere
    mov x8, #64         // 64 è la syscall WRITE
    svc #0              


    // Fine programma
    mov x0, #3          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


    // Dati del programma
    .data
    .p2align 2
    .global hellostr

hellostr: .asciz "hello\n"   // .asciiz inserisce una stringa terminata da 0x00
                             

