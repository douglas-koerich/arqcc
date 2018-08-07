section .text
	global	main
	extern	printf
	extern	scanf
main:
	push	prompt
	call	printf
	add		esp, 4

	push	idade
	push	formato
	call	scanf
	add		esp, 8

	mov		eax, dword[idade]
	cmp		eax, 5
	jae		testa_infantil
	mov		edx, invalido
	jmp		imprime

testa_infantil:
	cmp		eax, 8
	jae		testa_mirim
	mov		edx, infantil
	jmp		imprime

testa_mirim:
	cmp		eax, 11
	jae		testa_juvenil
	mov		edx, mirim
	jmp		imprime

testa_juvenil:
	cmp		eax, 16
	jae		testa_adulto
	mov		edx, juvenil
	jmp		imprime

testa_adulto:
	cmp		eax, 30
	ja		eh_senior
	mov		edx, adulto
	jmp		imprime

eh_senior:
	mov		edx, senior

imprime:
	push	edx
	call	printf
	add		esp, 4

	mov		eax, 1
	mov		ebx, 0
	int		80h


section .data
prompt:		db		'Digite a idade do nadador: ',0
formato:	db		'%d',0
invalido:	db		'INVALIDO',10,0
infantil:	db		'Infantil',10,0
mirim:		db		'Mirim',10,0
juvenil:	db		'Juvenil',10,0
adulto:		db		'Adulto',10,0
senior:		db		'Senior',10,0

section .bss
idade:	resd	1
