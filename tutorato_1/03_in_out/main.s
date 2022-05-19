// https://thog.github.io/syscalls-table-aarch64/latest.html
    .cpu cortex-a53 // direttiva che specifica il tipo
                    // di CPU

    .text           // Inizio della text section
    .p2align 2      // l'indirizzo deve essere multipo di 2^2


    .global _start  // definiamo un simbolo globale chiamato _start

_start:             // etichetta _start specifica l'entry-point del
                    // nostro programma

    mov x0, #1              // descrittore dello std_out
    adr x1, my_string       // puntatore della stringa da stampare
    mov x2, #12             // numero di caratteri da stampare
    mov x8, #0x40           // chiama syscall write
    svc #0

    adr x1, my_string
    
    movz x3, #0x7274, LSL #48    // carico la stringa "some_str" nel registro x3
								 // "some_str" -> 73 6F 6D 65 5F 73 74 72 
    movk x3, #0x735f, LSL #32
    movk x3, #0x656d, LSL #16
    movk x3, #0x6f73
    str x3, [x1]             // sovrascrivo la prima parte di my_str con la stringa "some_str"

    mov w3, #0x0a                // carico la string "\n\0\0\0" nel registro w3
    str w3, [x1, #8]         // sovrascrivo la seconda parte di my_str con "\n\0\0\0"
    
    mov x0, #1              // descrittore dello std_out
    adr x1, my_string       // puntatore della stringa da stampare
    mov x2, #12             // numero di caratteri da stampare
    mov x8, #0x40           // chiama syscall write
    svc #0
    
    mov x0, #1              //stampa la stringa "write your string(max 15 chars): \n"
    adr x1, write_str
    mov x2, #33
    mov x8, #0x40
    svc #0
	
    mov x0, #0                     // descrittore dello std_in
    adr x1, your_string_content    // buffer in cui ricevere l'input: your_string_content 
    mov x2, #15                    // numero caratteri da leggere
    mov x8, #0x3f                  // syscall read 
    svc #0
    
    mov x0, #1              //stampa la stringa "your string:\n"
    adr x1, your_string
    mov x2, #14 
    mov x8, #0x40
    svc #0

    mov x0, #1              //stampa il contenuto della stringa letta
    adr x1, your_string_content
    mov x2, #16
    mov x8, #0x40
    svc #0 

    mov x0, #1              //stampa il newline
    adr x1, new_line
    mov x2, #1
    mov x8, #0x40
    svc #0
    

    // Fine programma

    mov x0, #0          // Carichiamo il valore di ritorno nel registro x0
    mov x8, #93         // Specifichiamo il numero della syscall in x8
    svc #0              // syscall


    // Dati del programma

    .data
    .p2align 2

new_line: .ascii "\n"
my_string:  .string "my_string:\n"

write_str: .string "write you string(max 15 char): \n"
your_string: .string "your_string:\n"
your_string_content: .space 16
