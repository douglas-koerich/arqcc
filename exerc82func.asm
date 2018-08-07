section .text
	global	compara

; int compara(char* string1, char* string2) {
compara:
	push	ebp		; primeirissima coisa a ser feita ao entrar na subrotina
	mov		ebp, esp

	; int indice = 0;
	mov		ecx, 0
	push	ecx		; variaveis locais residem na pilha a partir (abaixo) do EBP

	mov		esi, [ebp+8]; 'string1' eh um parametro armazenado 8 bytes a mais que EBP
	mov		edi, [ebp+12]; (tem que pular o valor antigo de EBP e o valor de PC empilhado)
proximo:
	mov		dl, byte [esi]
	mov		dh, byte [edi]
	cmp		dh, dl
	je		testa_terminador_nulo

	; // Sao diferentes
	; return indice
	mov		eax, [ebp-4]	; INICIO da primeira variavel local na pilha = 4 bytes abaixo
	jmp		retorno

testa_terminador_nulo:
	cmp		dl, 0
	jz		strings_iguais
	inc		esi
	inc		edi
	mov		ecx, [ebp-4]
	inc		ecx
	mov		[ebp-4], ecx
	jmp		proximo

strings_iguais:
	mov		eax, -1		;	por padrao, o retorno de uma funcao vem pelo registrador EAX

retorno:
						;	ultimissima coisa a fazer antes de sair da rotina
	add		esp, 4		;	destroi a variavel local 'indice'
	pop		ebp			;	traz para EBP o seu valor antigo

	ret

section .data

section .bss

