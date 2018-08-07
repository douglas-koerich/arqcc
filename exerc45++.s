section .text
	extern	printf
	extern	scanf
	global	main

%macro	PRINT1 1	; PRINT eh o nome da macro, com 1 parametro
	push	%1		; %1 eh o valor do 1o. parametro, %2 do segundo, etc.
	call	printf
	add 	esp, 4
%endmacro			; marca o fim dos comandos representados pela macro

%macro	SCAN 2		; SCAN com 2 parametros
	push	%2
	push	%1
	call	scanf
	add		esp, 8
%endmacro

; extern unsigned int n, i;	// definidas la no rodape do arquivo
main:
; int main(void) {
;	printf("Digite um numero: ");
	PRINT1	msg1

;	scanf("%u", &n);
	SCAN	fmt, n

;	for (i=2; i<n; ++i) {		// testa numeros entre 1 e n, exclusive
	mov		ebx, [n]
	mov		ecx, 2
inicio:
	cmp		ecx, ebx
	jae		fim

;		if (n % i == 0) {	// n eh divisivel por i?
	mov		eax, ebx		; EDX:EAX tera o valor de n
	xor		edx, edx
	div		ecx				; ECX tem o valor de i
	cmp		edx, 0			; EDX fica com o resto, EAX com o quociente

;			break;			// nao faz sentido continuar, nao eh primo!
	je		fim
;		}
	inc		ecx				; ++i
	jmp		inicio		
;	}
fim:
;	if (i == n) {			// chegou ao fim do laco sem o break!
	cmp		ecx, ebx
	jne		nao_primo

;		printf("O numero eh primo.\n");
	PRINT1	msg2
	jmp		saida
;	}
;	else {
nao_primo:
;		printf("O numero NAO eh primo.\n");
	PRINT1	msg3
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
