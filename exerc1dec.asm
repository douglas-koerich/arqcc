section .text
	extern getchar
	extern toupper
	extern isalpha
	extern printf
	extern puts
	global main

main:
	push	pedido
	call	printf
	add		esp, 4

	call	getchar		; retorno da funcao eh colocado em EAX
	mov		[char], al	; como eh apenas 1 byte estah em AL (LSB do EAX)

	; push	al			; nao eh possivel empilhar um byte apenas
	push	eax			; EAX ainda tem o caracter lido por getchar()
	call	isalpha		; novamente, o retorno estah em EAX
	add		esp, 4

	cmp		eax, 0		; 0 (falso) significa que nao eh letra
	jz		outros

	xor		eax, eax	; limpa EAX (estah sujo por causa do isalpha)
	mov		al, [char]
	push	eax			; empilha o caracter
	call	toupper		; de novo, o retorno estah em EAX (caracter em AL)

	cmp		al, 'A'
	je		vogal

	cmp		al, 'E'
	je		vogal

	cmp		al, 'I'
	je		vogal

	cmp		al, 'O'
	je		vogal

	cmp		al, 'U'
	je		vogal

	cmp		al, 'Y'
	je		vogal

	push	msgcons
	jmp		saida

vogal:
	push	msgvogal
	jmp		saida

outros:
	push	msgoutro

saida:
	call	puts
	add		esp, 4

	mov		ebx, 0
	mov		eax, 1
	int		80h

section .data
pedido: 	db	'Digite um caracter: ',0
msgvogal:	db	'Vogal',0
msgcons:	db	'Consoante',0
msgoutro:	db	'Outro',0

section .bss
char:	resb	1
