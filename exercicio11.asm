section .data
PROMPT:		db	'Digite o codigo do produto: ',0
FORMATO: 	db	'%u',0

N_PEREC:	db	'Alimento nao perecivel',10,0
PEREC:		db	'Alimento perecivel',10,0
VESTUARIO:	db	'Vestuario',10,0
HIGIENE:	db	'Higiene pessoal',10,0
LIMPEZA:	db	'Limpeza e utensilios domesticos',10,0
INVALIDO:	db	'Invalido',10,0

section .bss
codigo:		resd	1

section .text
	extern	printf
	extern	scanf
	global	main
; inicio
main:
	; leia codigo
	push	PROMPT
	call	printf
	add		esp, 4
	push	codigo
	push	FORMATO
	call	scanf
	add		esp, 8

	; escolha codigo
	mov		ecx, [codigo]
	jcxz	_inval

		; caso 1:
	cmp		ecx, 1
	jnz		_perec
			; escreva "Alimento nao perecivel"
	push	N_PEREC
	jmp		_print

		; caso 2, 3, 4:
_perec:
	cmp		ecx, 4
	ja		_vest
			; escreva "Alimento perecivel"
	push	PEREC
	jmp		_print

		; caso 5, 6:
_vest:
	cmp		ecx, 6
	ja		_higi
			; escreva "Vestuario"
	push	VESTUARIO
	jmp		_print

		; caso 7:
_higi:
	cmp		ecx, 7
	jnz		_limp
			; escreva "Higiene pessoal"
	push	HIGIENE
	jmp		_print

		; caso 8..15:
_limp:
	cmp		ecx, 15
	ja		_inval
			; escreva "Limpeza e utensilios domesticos"
	push	LIMPEZA
	jmp		_print

		; caso contrario:
_inval:
			; escreva "Invalido"
	push	INVALIDO

	; fim-escolha

_print:
	call	printf
	add		esp, 4

; fim
	mov		ebx, 0
	mov		eax, 1
	int		80h

