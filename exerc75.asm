section .text
	global main
	extern printf
	extern scanf

%macro IMPRIME_VETOR 3
	push	%1
	call	printf
	add		esp, 4

	mov		esi, 0
	mov		ebx, %2
	mov		ecx, TAMANHO
%3:
	pusha
	push	dword [ebx+esi]
	push	impvalor
	call	printf
	add		esp, 8		; CUIDADO para nao inverter esta linha com a proxima!
	popa				; os registradores ficariam sujos com [ebx+esi] e impvalor

	add		esi, 4
	loop	%3

	push	impsalto
	call	printf
	add		esp, 4		; printf("\n");
%endmacro

main:
	; for (i=0; i<TAMANHO; ++i) {
	; 	printf("Digite o %do. elemento do vetor: ", i+1);
	;	scanf("%d", vetor_A+i);
	; }
	mov		edi, 0		; EDI eh tipicamente um registrador para indices
	mov		ebx, vetor_A
	mov		ecx, 0		; ECX farah o papel do i para controlar o numero de iteracoes

ler_elemento:
	inc		ecx			; conta em que passo do laco estah
	pusha				; salva todos os registradores (printf vai sujar!)
	push	ecx
	push	prompt
	call	printf
	add		esp, 8
	popa				; recupera os registradores da pilha

	pusha
	add		ebx, edi	; vetor + numero de bytes dos elementos anteriores
	push	ebx			; &vetor_A[I] <=> vetor_A+I, onde I = i * tamanho de cada elemento
	push	format
	call	scanf
	add		esp, 8
	popa

	add		edi, 4		; ++i significa pular 4 bytes do inteiro na memoria

	cmp		ecx, TAMANHO
	jb		ler_elemento	; quando chegar a ECX = tamanho percorreu todo o vetor

	; for (i=0; i<TAMANHO; ++i) {
	;	int vetor_B[i] = 1, x;
	;	for (x=vetor_A[i]; x>0; --x) {
	;		vetor_B[i] *= x;
	;	}
	; }
	mov		edi, vetor_B; EDI eh o registrador com endereco de destino da operacao
	mov		esi, vetor_A; ESI eh o registrador com endereco de origem da operacao
	mov		ebx, 0

laco_percurso:
	inc		ebx
	xor		edx, edx	; mov edx, 0
	mov		eax, 1		; EAX vai fazer as vezes do vetor_B[i] durante o calculo
	mov		ecx, dword [esi]	; ECX recebe o valor do elemento em vetor_A[i]
laco_fatorial:
	mul		ecx
	loop	laco_fatorial

	mov		dword [edi], eax	; salva o fatorial calculado em EAX para vetor_B[i]
	add		edi, 4		; vai para o proximo indice no vetor B
	add		esi, 4		; idem para o vetor A

	cmp		ebx, TAMANHO
	jb		laco_percurso

	; printf("Elementos no vetor A: ");
	; for (i=0; i<TAMANHO; ++i) {
	;	printf("%d ", vetor_A[i]);
	; }
	IMPRIME_VETOR	impvetorA, vetor_A, imp_vetor_A
;	push	impvetorA
;	call	printf
;	add		esp, 4
;
;	mov		esi, 0
;	mov		ebx, vetor_A
;	mov		ecx, TAMANHO
;imp_vetor_A:
;	pusha
;	push	dword [ebx+esi]
;	push	impvalor
;	call	printf
;	add		esp, 8		; CUIDADO para nao inverter esta linha com a proxima!
;	popa				; os registradores ficariam sujos com [ebx+esi] e impvalor
;
;	add		esi, 4
;	loop	imp_vetor_A
;
;	push	impsalto
;	call	printf
;	add		esp, 4		; printf("\n");

	IMPRIME_VETOR	impvetorB, vetor_B, imp_vetor_B
;	push	impvetorB
;	call	printf
;	add		esp, 4
;
;	mov		esi, 0
;	mov		ebx, vetor_B
;	mov		ecx, TAMANHO
;imp_vetor_B:
;	pusha
;	push	dword [ebx+esi]
;	push	impvalor
;	call	printf
;	add		esp, 8
;	popa
;
;	add		esi, 4
;	loop	imp_vetor_B	
;
;	push	impsalto
;	call	printf
;	add		esp, 4		; printf("\n");

	mov		eax, 1
	mov		ebx, 0
	int		80h

section .data
; #define TAMANHO	10
TAMANHO:	equ	10
prompt:		db	'Digite o %do. elemento do vetor: ',0
format:		db	'%d',0
impvetorA:	db	'Elementos no vetor A: ', 0
impvetorB:	db	'Elementos no vetor B: ', 0
impvalor:	db	'%d ',0
impsalto:	db	' ',10,0

section .bss
vetor_A:	resd	TAMANHO	; reserva 10 dwords <=> int vetor_A[10]
vetor_B:	resd	TAMANHO

