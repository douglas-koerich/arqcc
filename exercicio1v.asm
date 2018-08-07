section .data
; #define TAM	10
TAM:		equ	10

PROMPT_X:	db	'Digite vet_X[%d]: ',0
PROMPT_Y:	db	'Digite vet_Y[%d]: ',0
FORMAT:		db	'%d',0
OUTPUT_S:	db	'vet_S[%d]=%d',10,0

section .bss
; int vet_X[TAM], vet_Y[TAM], vet_S[TAM];
vet_X:	resd	TAM
vet_Y:	resd	TAM
vet_S:	resd	TAM
; int ecx;

section .text
	extern	printf
	extern	scanf
	global	main
main:
; main() {
	mov		ecx, TAM
	mov		ebx, vet_X
	; for (ecx=TAM; ecx!=0; --ecx) {
input_x:
	;	printf("Digite vet_X[%d]: ", TAM-ecx);
	push	ecx			; salva o contador (printf suja ecx)

	mov		eax, TAM
	sub		eax, ecx
	push	eax
	push	PROMPT_X
	call	printf
	add		esp, 8

	;	scanf("%d", &vet_X[TAM-ecx]);
	push	ebx
	push	FORMAT
	call	scanf
	add		esp, 8
	add		ebx, 4		; ebx aponta para proximo inteiro
	; }
	pop		ecx			; recupera o contador (para usar loop)
	loop	input_x

	mov		ecx, TAM
	mov		ebx, vet_Y
	; for (ecx=TAM; ecx!=0; --ecx) {
input_y:
	;	printf("Digite vet_Y[%d]: ", TAM-ecx);
	push	ecx			; salva o contador (printf suja ecx)

	mov		eax, TAM
	sub		eax, ecx
	push	eax
	push	PROMPT_Y
	call	printf
	add		esp, 8

	;	scanf("%d", &vet_Y[TAM-ecx]);
	push	ebx
	push	FORMAT
	call	scanf
	add		esp, 8
	add		ebx, 4		; ebx aponta para proximo inteiro
	; }
	pop		ecx			; recupera o contador (para usar loop)
	loop	input_y

	; // Letra (c) do exercicio
	; SOLUCAO C
	;mov	ecx, TAM
	;mov	ebx, 0
	; for (ecx=TAM; ecx!=0; --ecx) {
;soma:
	;	vet_S[TAM-ecx] = vet_X[TAM-ecx] + vet_Y[TAM-ecx];
	;mov	eax, dword [vet_X+ebx]
	;add	eax, dword [vet_Y+ebx]
	;mov	dword [vet_S+ebx], eax
	;add	ebx, 4
	;loop	soma
	; }

	; SOLUCAO ASSEMBLY
	; Copia todo o conteudo do vetor X para o vetor S
	mov		esi, vet_X
	mov		edi, vet_S
	mov		ecx, TAM
;copia:
;	movsd
;	loop	copia
	rep		movsd

	; Soma a cada valor do vetor S o valor do vetor Y
	mov		esi, vet_Y
	mov		edi, vet_S
	mov		ebx, edi
	mov		ecx, TAM
soma:
	lodsd			; carrega em eax o conteudo de esi
	add		eax, [ebx]
	add		ebx, 4
	stosd
	loop	soma

	mov		ecx, TAM
	mov		ebx, vet_S
	; for (ecx=TAM; ecx!=0; --ecx) {
print_s:
	;	printf("vet_S = %d\n", vet_S[TAM-ecx]);
	push	ecx			; salva o contador (printf suja ecx)

	push	dword [ebx]
	mov		eax, TAM
	sub		eax, ecx
	push	eax
	push	OUTPUT_S
	call	printf
	add		esp, 12
	add		ebx, 4
	; }
	pop		ecx			; recupera o contador (para usar loop)
	loop	print_s
; }
	mov		ebx, 0
	mov		eax, 1
	int		80h

