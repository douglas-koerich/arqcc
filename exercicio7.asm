section .data
prompt:	db	'Digite o valor de n: ',0
format:	db	'%u',0
result:	db	'O fatorial de %u (%u!) eh %u.',10,0

section .bss
n:		resd	1

section .text
	extern	printf
	extern	scanf
	global	main
; inicio
main:
	; leia n
	push	prompt
	call	printf
	add		esp, 4
	push	n
	push	format
	call	scanf
	add		esp, 8

	; produto <- 1
	xor		edx, edx	; zera o EDX que eh envolvido no MUL
	mov		eax, 1		; produto = EAX

	; para i de n ate 1 passo -1 faca
	mov		ebx, [n]
	mov		ecx, ebx	; ECX faz o papel de 'i' no laco for
laco:
		; produto <- produto * i
	mul		ecx			; EAX tem produto, ECX eh o 'i'

	; fim-para
	loop	laco

	; escreva produto
	push	eax
	push	ebx
	push	ebx
	push	result
	call	printf
	add		esp, 16

; fim
	mov		ebx, 0
	mov		eax, 1
	int		0x80

