	.cpu cortex-a53

	.text
	.p2align 2

	//Insert your functions here

	.global _start

_start:

	//Do something..

	mov x0, #3
	mov x8, #93
	svc #0

	.data
	.p2align 2

	//Insert your variables here...
