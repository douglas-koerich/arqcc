section .data
prmpt_i:	db	'Digite o valor inicial: ',0
prmpt_f:	db	'Digite o valor final: ',0
prmpt_p:	db	'Digite o passo: ',0
format:		db	'%u',0
msgnum:		db	'%u',10,0

section .bss
inicial:	resd	1
final:		resd	1
passo:		resd	1

section .text
	extern	printf
	extern	scanf
	global	main
; inicio
main:
	; leia inicial, final, passo
	push	prmpt_i
	call	printf
	add		esp, 4
	push	inicial
	push	format
	call	scanf
	add		esp, 8

	push	prmpt_f
	call	printf
	add		esp, 4
	push	final
	push	format
	call	scanf
	add		esp, 8

	push	prmpt_p
	call	printf
	add		esp, 4
	push	passo
	push	format
	call	scanf
	add		esp, 8

	; numero <- inicial
	mov		eax, [inicial]

	; enquanto (numero <= final) faca
teste:
	cmp		eax, [final]
	ja		fim

		; escreva numero
	push	eax		; SALVA NA PILHA O eax QUE printf mudarah!

	push	eax
	push	msgnum
	call	printf
	add		esp, 8

	pop		eax		; RECUPERA O VALOR ORIGINAL PARA eax

		; numero <- numero + passo
	add		eax, [passo]

	; fim-enquanto
	jmp		teste

; fim
fim:
	mov		ebx, 0
	mov		eax, 1
	int		0x80

