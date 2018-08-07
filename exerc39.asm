section .text
	global	main
	extern	printf
	extern	scanf
main:
ler_X:	
	push	prompt_X
	call	printf
	add		esp, 4
	push	X		; equivale a &X
	push	formato
	call	scanf
	add		esp, 8
	mov		eax, dword [X]
	cmp		eax, 0
	jl		ler_X
ler_Y:
	push	prompt_Y
	call	printf
	add		esp, 4
	push	Y
	push	formato
	call	scanf
	add		esp, 8
	mov		eax, dword [Y]
	cmp		eax, 0
	jl		ler_Y

	; mov	ecx, dword [Y]	(mas Y jah foi carregado pra EAX!)
	mov		ecx, eax
	xor		edx, edx	; zera o conteudo de EDX
	mov		eax, 1		; inicia o acumulador do produto com 1 (elem. neutro da multiplicacao)
	mov		ebx, dword [X]	; usa um registrador para nao ler da memoria dentro do laco
laco:
	mul		ebx
	loop	laco		; decrementa ECX, se ECX > 0 volta para o rotulo

	push	eax			; empilha o resultado (ainda em EAX)
	push	dword [Y]	; empilha Y (ECX jah nao o tem mais)
	push	ebx			; empilha X (ainda em EBX)
	push	exibe_pot
	call	printf
	add		esp, 16

	; return 0;
	mov		eax, 1	; system call exit()
	mov		ebx, 0	; retorno = EXIT_SUCCESS
	int		80h

section .data
prompt_X:	db	'Digite o valor de X: ',0	; nao esquecer o '\0'
prompt_Y:	db	'Digite o valor de Y: ',0
exibe_pot:	db	'%d elevado a %d eh igual a %d.',10,0
formato:	db	'%d',0						; tambem requer o '\0'

section .bss	; int X, Y;		// variaveis globais
X:		resd	1
Y:		resd	1

