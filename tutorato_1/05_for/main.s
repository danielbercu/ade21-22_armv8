    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma
	
/* programma in pseudo-c
// i, n variabili globali
 
x1 = 10;
x2 = 0;
for (x0=0; x0<x1; x0++){
	x2 += x0;
}
exit(0);

 //trasformiamo il for in un while

x1 = 10;
x2 = 0;

x0 = 0;
while(x0 < x1){
    x2 += x0;	
	x0++;
}
exit(0);

 //trasformiamo il ciclo while usando i goto

x1 = 10;
x0 = 0;
x2 = 0;
if (x0 >= x1) 
	goto endwhile;
initwhile:
	x2 += x0
    x0++;
	if (x0 < x1) goto initwhile;
endwhile:
	exit(0);
*/
	
    mov x0, #0    	// x0 = 0
	mov x1, #10		// x1 = 10
	mov x2, #0		// x2 = 0

	cmp x0, x1   // if(x0 >= x1 goto endwhile
	b.ge endwhile    
initwhile:             
	// corpo del while

	add x2, x2, x0	// x2 += x0
    add x0, x0, #1	// x0 ++
	cmp x0, x1
	b.lt initwhile  // if(x0 < x1) goto initwhile

endwhile:
		
// Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


