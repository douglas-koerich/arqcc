section .text
	extern	printf
	extern	scanf
	global	main

; extern unsigned int n, i;	// definidas la no rodape do arquivo
main:
; int main(void) {
;	printf("Digite um numero: ");
	push	msg1
	call	printf
	add 	esp, 4

;	scanf("%u", &n);
	push	n		; empilhando o ENDERECO (rotulo) da "variavel" n
	push	fmt
	call	scanf
	add		esp, 8

;	for (i=2; i<n; ++i) {		// testa numeros entre 1 e n, exclusive
	mov		dword [i], 2	; precisa explicitar quantos bytes sao copiados
							; (poderia ser um byte=2, uma word=2, etc...)
inicio:
;	cmp		[i], [n]		; nao eh possivel ter dois operandos de memoria
	mov		ecx, [i]		; usa o registrador ECX como contador
	cmp		ecx, [n]
	jae		fim

;		if (n % i == 0) {	// n eh divisivel por i?
	mov		eax, [n]		; EDX:EAX tera o valor de n
	xor		edx, edx
	div		ecx				; ECX tem o valor de i
	cmp		edx, 0			; EDX fica com o resto, EAX com o quociente

;			break;			// nao faz sentido continuar, nao eh primo!
	je		fim
;		}
	inc		ecx				; ++i
	mov		[i], ecx
	jmp		inicio		
;	}
fim:
;	if (i == n) {			// chegou ao fim do laco sem o break!
	mov		eax, [i]		; cmp: preciso carregar p/ um registrador
	cmp		eax, [n]
	jne		nao_primo

;		printf("O numero eh primo.\n");
	push	msg2
	call	printf
	add		esp, 4
	jmp		saida
;	}
;	else {
nao_primo:
;		printf("O numero NAO eh primo.\n");
	push	msg3
	call	printf
	add		esp, 4
;	}
saida:
;	return 0;
	mov		ebx, 0
	mov		eax, 1
	int		0x80
; }

section .data
msg1:	db	'Digite um numero: ',0
msg2:	db	'O numero eh primo.',10,0
msg3:	db	'O numero NAO eh primo.',10,0
fmt:	db	'%u',0

section .bss
; unsigned int n, i;
n:		resd	1	; inteiro de 32 bits sem sinal
i:		resd	1
