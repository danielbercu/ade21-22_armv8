    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma


    // Il programma calcola il numero di zeri contenuti
    // nell'array A e ritorna il risultato nella variabile r.
    // La variabile n contiene il numero di elementi di A.


    // Versione costrutto for, accesso all'array con indici
    // Codice C equivalente:
    // 
    //        x0 = (&A[0])
    //        x1 = n
    //        x2 = indice corrente 
    //        x3 = risultato
    //        
    //
    //        x3=0;
    //        for (x2=0; x2<x1 ; ++x2 )
    //        {
    //            if( A[x2] == 0 )
    //                x3+=1;
    //        } 
    /**/
    adr x0, A
    adr x1, n
    ldr x1, [x1]

    mov x3, #0

    mov x2, #0              // Inizializzazione for
    cmp x2,x1
    b.ge exitfor

initfor:    
    add x4, x0, x2, LSL #2  //x4 = $(A[x2])
    ldr w5, [x4]            //w5 = A[x2]
    cmp w5, #0
    b.ne forinc             // if(w5 != 0) goto for-inc
    add x3,x3,#1            // x3=x3+1
forinc:
    add x2,x2,#1            // x2=x2+1
    cmp x2,x1           
    b.lt initfor            // if( x2<x1 ) goto init-for
exitfor:
    adr x4, r               // x4 = &r
    str x3, [x4]            // r = x3
    /**/

    // Versione costrutto for, accesso all'array con puntatori
    // Codice C equivalente:
    // 
    //        x0 = (&A[0])
    //        x1 = n
    //        x2 = x0 + n*sizeof(int)  // puntatore alla fine dell'array
    //        x3 = risultato
    //        
    //        for( x3=0; x0<x2; x0+=sizeof(int) )
    //        {
    //            if( mem[x0] == 0 )
    //                x3+=1;
    //        } 
    // 
    //  Il ciclo for in questa versione
    //  effettua un'operazione in meno: non è
    //  necessario calcolare l'indirizzo dell'elemento
    //  i-esimo dell'array con 
    //  add x4, x0, x2, LSL #2  //x4 = $(A[x2])
    //
    /*
    adr x0, A
    adr x1, n
    ldr x1, [x1]

    add x2, x0, x1, LSL #2

    mov x3, #0              // Inizializzazione for
    cmp x0,x2
    b.ge exitfor

initfor:    
    ldr w5, [x0]            //w5 = A[x0]
    cmp w5, #0
    b.ne forinc             // if(w5 != 0) goto for-inc
    add x3,x3,#1            // x3=x3+1
forinc:
    add x0,x0,#4            // x0=x0+sizeof(int)
    cmp x0,x2           
    b.lt initfor            // if( x0<x2 ) goto init-for
exitfor:
    adr x4, r               // x4 = &r
    str x3, [x4]            // r = x3
    /**/




    // Fine programma
    mov x0, #3          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


    // Dati del programma
    .data
    .p2align 2

A:  .word 0,2,3,0,0,6,7,0,9,10,0,0,0     // int A[13]
n:  .dword 13                            // numero di elementi di A
r:  .dword 0                             // variabile utilizzata per memorizzare il risultato
                             

