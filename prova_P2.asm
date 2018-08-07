section .text
	extern printf
	extern scanf
	global main
main:
	push	prompt
	call	printf
	add		esp, 4

	push	s
	push	format
	call	scanf
	add		esp, 8

	xor		eax, eax
	xor		ebx, ebx
	mov		ecx, dword [s]
	xor		edx, edx
rotulo:
	inc		eax
	cmp		eax, 60
	jne		proximo
	inc		ebx
	mov		eax, 0
	cmp		ebx, 60
	jne		proximo
	inc		edx
	mov		ebx, 0
proximo:
	loop	rotulo

	push	eax
	push	ebx
	push	edx
	push	dword [s]
	push	output
	call	printf
	add		esp, 20

	mov		ebx, 0
	mov		eax, 1
	int		80h

section .data
prompt:	db 'Digite o numero de segundos: ',0
format: db '%d',0
output: db '%d segundos equivalem a %d horas, %d minutos e %d segundos.',10,0

section .bss
s:	resd	1
