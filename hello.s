;/*
;#include <stdio.h>
;
;int main() {
;	printf("Hello, world!\n");
;	return EXIT_SUCCESS;
;}
;*/

section .text
	global	main	; pto. de entrada visivel do programa
	extern	printf	; vou usar o printf da biblioteca C
main:
	push	GREETINGS
	call	printf
	add		esp, 4

	mov		ebx, EXIT_SUCCESS
	mov		eax, SYS_EXIT
	int		80h		; chamada ao sistema Linux/UNIX

section .data
GREETINGS:		db 'Hello, world!',10	; 10 = ASCII de \n
EXIT_SUCCESS:	equ	0
SYS_EXIT:		equ	1	; numero da system call para exit()

section .bss
	; Este programa nao tem variaveis



