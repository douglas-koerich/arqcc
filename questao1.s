section .text
	global	main
	extern	printf
	extern	scanf
main:
	mov		ebx, vetor
	mov		ecx, tam
	xor		edi, edi
	xor		eax, eax
entrada:
	push	ecx
	push	ebx
	push	edi
	push	eax
	push	msg1
	call	printf
	add		esp, 4
	pop		eax
	pop		edi
	pop		ebx

	push	ebx
	push	edi
	push	eax
	mov		edx, ebx
	add		edx, edi
	push	edx
	push	fmt
	call	scanf
	add		esp, 8
	pop		eax
	pop		edi
	pop		ebx

	pop		ecx
	inc		eax
	add		edi, 4
	loop	entrada

	push	msg2
	call	printf
	add		esp, 4

	push	x
	push	fmt
	call	scanf
	add		esp, 8

	mov		ebx, vetor
	xor		esi, esi
	mov		edx, [x]
	mov		ecx, tam
	xor		eax, eax
a:
	cmp		dword [ebx+esi], edx
	jge		b
	inc		eax
b:
	add		esi, 4
	loop	a
	mov		[n], eax

	push	eax
	push	dword [x]
	push	msg3
	call	printf
	add		esp, 12

	mov		ebx, 0
	mov		eax, 1
	int		80h

section .data
tam:	equ	10
msg1:	db	'Digite o valor do elemento %d: ',0
msg2:	db	'Digite o valor procurado: ',0
msg3:	db	'O valor %d eh limitante superior de %d elementos.',10,0
fmt:	db	'%d',0

section .bss
vetor:		resd	tam
x:			resd	1
n:			resd	1

