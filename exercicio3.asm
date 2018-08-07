section .data
EQUI:	db	'Triangulo equilatero.',10,0
ISOS:	db	'Triangulo isosceles.',10,0
ESCA:	db	'Triangulo escaleno.',10,0
NAO:	db	'Nao eh triangulo.',10,0
PRMPT_A:db	'Digite o comprimento do lado A: ',0
PRMPT_B:db	'Digite o comprimento do lado B: ',0
PRMPT_C:db	'Digite o comprimento do lado C: ',0
FORMAT:	db	'%u',0

section .bss
lado_A:	resd	1
lado_B:	resd	1
lado_C:	resd	1

section .text
	extern	printf
	extern	scanf
	global	main
; inicio
main:
	; leia A, B, C
	push	PRMPT_A
	call	printf
	add		esp, 4
	push	lado_A
	push	FORMAT
	call	scanf
	add		esp, 8

	push	PRMPT_B
	call	printf
	add		esp, 4
	push	lado_B
	push	FORMAT
	call	scanf
	add		esp, 8

	push	PRMPT_C
	call	printf
	add		esp, 4
	push	lado_C
	push	FORMAT
	call	scanf
	add		esp, 8

	; se (((A+B) <= C) ou ((B+C) <= A) ou ((A+C) <= B)) entao
	mov		edx, [lado_A]
	mov		ebx, [lado_B]
	mov		ecx, [lado_C]
	mov		eax, edx
	add		eax, ebx
	cmp		eax, ecx
	jbe		nao_eh

	mov		eax, ebx
	add		eax, ecx
	cmp		eax, edx
	jbe		nao_eh

	mov		eax, edx
	add		eax, ecx
	cmp		eax, ebx
	jbe		nao_eh
	
	jmp		eh_triang

		; escreva "Nao eh triangulo."
nao_eh:
	mov		eax, NAO
	jmp		print

	; senao
eh_triang:

		; se (A = B) entao
	cmp		edx, ebx
	jne		a_dif_b

			; se (A = C) entao
	cmp		edx, ecx
	jne		a_dif_c

				; escreva "Triangulo equilatero."
	mov		eax, EQUI
	jmp		print

			; senao
a_dif_c:

				; escreva "Triangulo isosceles."
	mov		eax, ISOS
	jmp		print

			; fim-se

		; senao
a_dif_b:

			; se (B = C) entao
	cmp		ebx, ecx
	jne		b_dif_c

				; escreva "Triangulo isosceles."
	jmp		a_dif_c

			; senao
b_dif_c:
				; se (A = C) entao
	cmp		edx, ecx
	jne		a_dif_c2

					; escreva "Triangulo isosceles."
	jmp		a_dif_c
				; senao
a_dif_c2:
					; escreva "Triangulo escaleno."
	mov		eax, ESCA

				; fim-se

			; fim-se

		; fim-se

	; fim-se

; fim

print:
	push	eax
	call	printf
	add		esp, 4
saida:
	mov		ebx, 0
	mov		eax, 1
	int		80h











