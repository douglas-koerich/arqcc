section .text	; esta eh a parte de codigo (instrucoes)
	global main
main:
	; write(STDOUT, MESSAGE, SIZE)
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, MESSAGE
	mov edx, SIZE
	int 80h

	mov eax, SYS_EXIT
	mov ebx, SUCCESS
	int 80h

section .data	; memoria de dados inicializados
				; (ex: constantes e globais inicializadas)
SYS_WRITE:	equ 4
STDOUT:		equ 1
SYS_EXIT:	equ 1
SUCCESS:	equ 0
MESSAGE:	db	'Welcome to assembly programming',10
SIZE:		equ $-MESSAGE

section .bss	; memoria de dados nao inicializados
				; (ex: variaveis globais nao inicializadas)

