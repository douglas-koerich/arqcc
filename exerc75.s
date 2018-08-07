section .text
	extern	printf
	extern	scanf
	global	main

%macro	PRINT2 2
	push	%2
	push	%1
	call	printf
	add 	esp, 8
%endmacro

%macro	PRINT3 3
	push	%3
	push	%2
	push	%1
	call	printf
	add 	esp, 12
%endmacro

%macro	SCAN 2
	push	%2
	push	%1
	call	scanf
	add		esp, 8
%endmacro

; #define TAM	10
; unsigned int n[TAM], f[TAM];
; int main(void) {
main:
	xor		edi, edi	; EDI = 0 (deslocamento inicial nulo)
	mov		ebx, n		; EBX tem o endereco do inicio do vetor n
	mov		ecx, 0		; j=0

inicio_entrada:
;	for (register int j=0; j<TAM; ++j) {
	cmp		ecx, TAM	; j<TAM
	je		fim_entrada
;		printf("Digite o valor de n[%d]: ", j);
	push	ecx			; Salva o contador (j) na pilha
	push	ebx			; Salva EBX e EDI na pilha antes do printf
						; (ECX jah esta na pilha)
	push	edi
	PRINT2	msg1, ecx
	pop		edi
	pop		ebx			; Recupera registradores da pilha (ECX ainda fica)

;		scanf("%u", &n[j]);
	push	ebx			; Salva EBX e EDI na pilha antes do scanf
	push	edi
	lea		eax, [ebx+edi]	; "Resolve" a aritmetica base+deslocamento e salva em EAX
	SCAN 	fmt, eax
	pop		edi
	pop		ebx			; Recupera registradores da pilha
	pop		ecx			; (incluindo ECX)
	add		edi, 4		; desloca para o proximo endereco de int
	inc		ecx			; ++j

	jmp		inicio_entrada
;	}
fim_entrada:
	xor		edi, edi
	mov		edx, f		; EDX tem o endereco do inicio do vetor f (destino)

	xor		esi, esi
	mov		ebx, n		; EBX tem o endereco do inicio do vetor n (origem)

	mov		ecx, 0		; j=0

inicio_percurso:
;	for (register int j=0; j<TAM; ++j) {
	cmp		ecx, TAM
	je		fim_percurso
;		f[j] = 1;
	mov		eax, 1		; EAX tera o valor do fatorial
	push	edx			; Como EDX vai ser usado em MUL, precisa salva-lo
	push	ecx			; ECX vai ser usado como parcela da multiplicacao,
						; entao o salva tambem...

	xor		edx, edx	; zera EDX para chamar MUL
	mov		ecx, [ebx+esi]	; O registrador deve ser ECX, iniciando
						; com o valor (em EBX+ESI) que sera decrementado
						; *automaticamente* pela instrucao LOOP
						
	jcxz	copia		; Como o teste de ECX eh feito por LOOP,
						; se n[j] == 0 o valor de EAX (f[j]) seria 0
calcula:
;		for (register unsigned i=n[j]; i>0; --i) {
;			f[j] *= i;
	mul		ecx			; Lembre-se que EAX tem f[j] temporariamente
;		}
	loop	calcula		; LOOP por si decrementa ECX (--i) e
						; testa se eh diferente de zero (i>0)
copia:
	pop		ecx
	pop		edx
	mov		[edx+edi], eax	; EDX+EDI eh o endereco do f[j]
	add		edi, 4		; vai para f[j+1]
	add		esi, 4		; vai para n[j+1]
	inc		ecx			; ++j
	jmp		inicio_percurso
;	}
fim_percurso:
	xor		esi, esi	; ESI = 0 (deslocamento inicial nulo)
	mov		ebx, f		; EBX tem o endereco do inicio do vetor f
	mov		ecx, 0		; j=0

inicio_saida:
;	for (register int j=0; j<TAM; ++j) {
	cmp		ecx, TAM	; j<TAM
	je		fim_saida
;		printf("O valor de f[%d] = %u.\n", j, f[j]);
	push	ecx			; Salva o contador (j) na pilha
	push	ebx			; Salva EBX e ESI na pilha antes do printf
						; (ECX jah esta na pilha)
	push	esi
	PRINT3	msg2, ecx, dword [ebx+esi]	; [EBX+ESI] = f[j]
	pop		edi
	pop		ebx			; Recupera registradores da pilha
	pop		ecx			; (incluindo ECX)
	add		esi, 4		; desloca para o proximo endereco de int
	inc		ecx			; ++j

	jmp		inicio_saida
;	}
fim_saida:

;	return EXIT_SUCCESS;
	mov		ebx, 0
	mov		eax, 1
	int		80h
;

section .data
msg1:	db 'Digite o valor de n[%d]: ',0
msg2:	db 'O valor de f[%d] = %u.',10,0
fmt:	db '%u',0
TAM:	equ	10			; #define TAM 10

section .bss
n:		resd	TAM		; reserva TAM (10) dwords = 40 bytes
f:		resd	TAM

