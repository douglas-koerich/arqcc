section .data
PROMPT_N:	db		'Digite o valor de n: ',0
PROMPT_P:	db		'Digite o valor de p: ',0
FORMATO:	db		'%u',0
SAIDA_C:	db		'Existem %u combinacoes.',10,0

section .bss
; unsigned n, p, C;	// Variaveis globais nao inicializadas
n:			resd	1
p:			resd	1
C:			resd	1

section .text
	extern	printf
	extern	scanf
	global	main

; unsigned fatorial(unsigned x) {
fatorial:
	push	ebp				; salva o ebp da chamadora (combinacao)
	mov		ebp, esp		; ebp = referencia de quadro desta funcao

	; unsigned i, fat;
	xor		edx, edx
	mov		eax, 1
	mov		ecx, [ebp+8]

	; for (fat = 1, i = x; i > 0; --i) {
fat:
		; fat *= i;
	mul		ecx
	; }
	loop	fat

	; return fat;
	pop		ebp				; restaura o ebp da chamadora (combinacao)
	ret		4				; retorno eh por meio do eax
; }

; unsigned combinacao(unsigned n, unsigned p) {
combinacao:
	push	ebp				; salva o ebp da chamadora (main)
	mov		ebp, esp		; ebp = referencia de quadro desta funcao

	; unsigned C, fat_n, fat_p, fat_n_menos_p;
	sub		esp, 4			; area de memoria para variavel local fat_n
	sub		esp, 4			; idem para variavel local fat_p
	sub		esp, 4			; ibidem para fat_n_menos_p

	; fat_n = fatorial(n);
	push	dword [ebp+8]	; empilha n (ebp+8)
	call	fatorial
	; add	esp, 4			; nao precisa, porque fatorial faz 'ret 4' (v.)
	mov		[ebp-4], eax	; copia em fat_n (ebp-4) o retorno de fatorial

	; fat_p = fatorial(p);
	push	dword [ebp+12]	; empilha p (ebp+12)
	call	fatorial
	mov		[ebp-8], eax	; copia em fat_p (ebp-8) o retorno de fatorial

	; fat_n_menos_p = fatorial(n-p);
	mov		eax, [ebp+8]	; eax = n
	sub		eax, [ebp+12]	; eax -= p
	push	eax				; empilha n-p que estah em eax
	call	fatorial
	mov		[ebp-12], eax	; copia em fat_n_menos_p o retorno do fatorial

	; C = fat_n / (fat_p * fat_n_menos_p);
	xor		edx, edx
	mov		eax, [ebp-8]	; eax = fat_p
	mul		dword [ebp-12]	; eax *= fat_n_menos_p
	mov		ecx, eax		; salva o denominador em ecx
	xor		edx, edx
	mov		eax, [ebp-4]	; eax = fat_n
	div		ecx				; eax /= ecx (que contem o denominador)

	; return C;
	add		esp, 12			; retira da pilha as variaveis locais
	pop		ebp				; recupera o inicio do quadro da chamadora
	ret						; como 'ret' nao tem valor, main tem que tirar...
; }

; main() {
main:
	; printf("Digite o valor de n: ");
	push	PROMPT_N
	call	printf
	add		esp, 4

	; scanf("%u", &n);
	push	n
	push	FORMATO
	call	scanf
	add		esp, 8

	; printf("Digite o valor de p: ");
	push	PROMPT_P
	call	printf
	add		esp, 4

	; scanf("%u", &p);
	push	p
	push	FORMATO
	call	scanf
	add		esp, 8

	; C = combinacao(n, p);
	push	dword [p]		; passagem de parametro por copia
	push	dword [n]
	call	combinacao
	add		esp, 8
	mov		[C], eax

	; printf("Existem %u combinacoes.\n", C);
	push	eax				; ou push dword [C]
	push	SAIDA_C
	call	printf
	add		esp, 4

; }
	mov		ebx, 0
	mov		eax, 1
	int		80h

