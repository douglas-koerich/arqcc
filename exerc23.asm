section .text
	global	main
	extern	printf
	extern	scanf
main:
	push	prompt
	call	printf
	add		esp, 4

	push	numero	; &numero
	push	formato
	call	scanf
	add		esp, 8

;	xor		edx, edx
;	mov		eax, dword[numero]
;	mov		ebx, 2
;	idiv	ebx		; EAX fica com o quociente, EDX fica com o resto da divisao
;	cmp		edx, 0
;	jne		eh_impar

	mov		eax, dword[numero]
	and		eax, 1
	jnz		eh_impar

	mov		eax, par
	jmp		imprime
eh_impar:
	mov		eax, impar

imprime:
	push	eax
	call	printf
	add		esp, 4

	mov		eax, 1
	mov		ebx, 0
	int		80h

section .data
prompt:		db	'Digite um numero: ',0
formato:	db	'%d',0
par:		db	'O numero eh par.',10,0
impar:		db	'O numero eh impar.',10,0

section .bss
numero:		resd	1	; int numero;	// variavel global
