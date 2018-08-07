section .text	; regiao do codigo-fonte para as instrucoes

	global _start	; simbolo de entrada do seu programa para o S.O.

_start:
	mov eax, WRITE
	mov ebx, STDOUT
	mov ecx, msg
	mov edx, tam
	int 80h		; chama a syscall

	mov eax, EXIT
	mov ebx, EXIT_SUCCESS
	int 80h

section .data	; regiao para as variaveis e constantes globais
				; inicializadas (com valores iniciais)

				; Em C: char* msg = "Bem-vindo(a)...\n";
msg:	db	'Bem-vindo(a) a sua experiencia com Assembly x86!',10
tam:	equ $-msg	; $=endereco atual (tam)
WRITE:	equ 4	; 4 eh o numero da syscall write
STDOUT:	equ 1	; 1 eh o file descriptor do video (stdout)
EXIT:	equ 1	; numero da syscall exit
EXIT_SUCCESS:	equ 0

section .bss	; regiao para variaveis nao inicializadas
				; apenas reserva de memoria
