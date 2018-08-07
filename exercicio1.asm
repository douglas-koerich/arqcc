section .text
	extern	printf
	extern	scanf
	global	main
main:
	; printf("Digite o valor de a: ");
	push	PROMPT1
	call	printf
	add		esp, 4	; tira da pilha o parametro (end.32 bits)

	; scanf("%d", &a);
	push	a
	push	FORMAT
	call	scanf
	add		esp, 8	; tira os 8 bytes empilhados

	; printf("Digite o valor de b: ");
	push	PROMPT2
	call	printf
	add		esp, 4	; tira da pilha o parametro (end.32 bits)

	; scanf("%d", &b);
	push	b
	push	FORMAT
	call	scanf
	add		esp, 8	; tira os 8 bytes empilhados

	; printf("Antes da troca: a=%d, b=%d.\n", a, b);
	push	dword [b]
	push	dword [a]
	push	MSG1
	call	printf
	add		esp, 12

	; aux = a, a = b, b = aux;
	mov		eax, [a]
	mov		ebx, [b]
	mov		ecx, eax	; aux = a
	mov		eax, ebx	; a = b
	mov		ebx, ecx	; b = aux
	mov		[a], eax
	mov		[b], ebx

	; printf("Depois da troca: a=%d, b=%d.\n", a, b);
	push	dword [b]
	push	dword [a]
	push	MSG2
	call	printf
	add		esp, 12

	mov		ebx, 0	; EXIT_SUCCESS = 0
	mov		eax, 1	; SYS_EXIT = 1
	int		80h

section .data
PROMPT1:	db	'Digite o valor de a: ',0	; terminador nulo
PROMPT2:	db	'Digite o valor de b: ',0
MSG1:		db	'Antes da troca: a=%d, b=%d.',10,0
MSG2:		db	'Depois da troca: a=%d, b=%d.',10,0
FORMAT:		db	'%d',0

section .bss
a:		resd	1	; reserva um inteiro 32 bits
b:		resd	1

