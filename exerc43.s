section .text
	extern	printf
	extern	scanf
	global	main

%macro	PRINT1 1
	push	%1
	call	printf
	add 	esp, 4
%endmacro

%macro	PRINT2 2
	push	%2
	push	%1
	call	printf
	add 	esp, 8
%endmacro

%macro	SCAN 2
	push	%2
	push	%1
	call	scanf
	add		esp, 8
%endmacro

; unsigned int n, f;
; int main(void) {
main:
;	printf("Digite o valor de n: ");
	PRINT1	msg1

;	scanf("%u", &n);
	SCAN 	fmt, n

;	f = 1;
	mov		eax, 1
	xor		edx, edx	; zera EDX para chamar MUL

	mov		ecx, [n]	; O registrador deve ser ECX, iniciando
						; com o valor que sera decrementado
						; *automaticamente* pela instrucao LOOP
						
	jcxz	imprime		; Como o teste de ECX eh feito por LOOP,
						; se n == 0 o valor de EAX (f) serah 0
teste:
;	for (register unsigned i=n; i>0; --i) {
;		f *= i;
	mul		ecx
;	}
	loop	teste		; LOOP por si decrementa ECX (--i) e
						; testa se eh diferente de zero (i>0)
imprime:
;	printf("Fatorial: %u.\n", f);
	PRINT2	msg2, eax

;	return EXIT_SUCCESS;
	mov		ebx, 0
	mov		eax, 1
	int		80h
;

section .data
msg1:	db 'Digite o valor de n: ',0
msg2:	db 'Fatorial: %u.',10,0
fmt:	db '%u',0

section .bss
n:		resd	1

