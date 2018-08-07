section .text
	global	main
	extern	printf
; int main() {
main:
;	printf("Hi, world!\n");
	push	mensagem				; poe na pilha o endereco da string (argumento para printf)
	call	printf					; chama a funcao printf
	add		esp, 4					; retorna o ESP (topo) para a posicao anterior

	mov		eax, EXIT
	mov		ebx, SUCESSO
	int		80h
;	return 0;
; }

section .data
mensagem:	db 'Hi, world!',10,0	; char* mensagem = "Hi, world!\n"; // com o '\0'!!!
SUCESSO:	equ 0					; #define SUCESSO 0
EXIT:		equ 1					; #define EXIT 1

section .bss
