section .text
	extern printf
	global main

; int main() {
main:
	; printf("Bem-vindo(a) a sua experiencia com Assembly x86!\n");
	push msg	; argumento para uma funcao em C eh via pilha
	call printf	; chama a funcao printf da biblioteca da linguagem C
	add esp, 4	; limpa a pilha (tira o msg posto pela instrucao push)

	; return 0;
	mov ebx, 0
	mov eax, 1
	int 80h
; }

section .data
			; 10 para o \n, 0 para o \0 (terminador nulo)
msg:	db	'Bem-vindo(a) a sua experiencia com Assembly x86!',10,0

