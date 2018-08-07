section .text
	extern	printf
	extern	scanf
	global	main
main:
	; printf("Digite o numero de lados (N): ");
	push	PROMPT
	call	printf
	add		esp, 4	; foram empilhados 4 bytes (tam. PROMPT)

	; scanf("%u", &N);
	push	N
	push	FORMAT
	call	scanf
	add		esp, 8	; foram empilhados 2x4 bytes

	; D = N*((N-3)/2);
	mov		eax, [N]
	sub		eax, 3	; em EAX fica N-3
	mov		ebx, 2
	xor		edx, edx	; equivale a mov edx, 0 (mais rapido)
	div		ebx		; div opera sobre EDX:EAX, quoc em EAX
	mov		ebx, [N]
	mul		ebx		; mul sempre opera sobre EAX, prod em EAX
	mov		[D], eax

	; printf("O numero de diagonais (D) eh %u.\n", D);
	push	dword [D]
	push	MSG
	call	printf
	add		esp, 8

	; return 0;
	mov		ebx, 0
	mov		eax, 1
	int		0x80

section .data
PROMPT:	db	'Digite o numero de lados (N): ',0
FORMAT:	db	'%u',0
MSG:	db	'O numero de diagonais (D) eh %u.',10,0

section .bss
N:		resd	1
D:		resd	1

