%macro	LE_NUMERO	2
	push	%1
	call	printf
	add		esp, 4
	push	%2
	push	fmt
	call	scanf
	add		esp, 8
%endmacro

section .text
	extern	printf
	extern	scanf
	global	main
main:
	LE_NUMERO	msg1, num1
	LE_NUMERO	msg2, num2

	push	dword [num2]	; empilha o VALOR das variaveis 'numX'
	push	dword [num1]	; passagem de parametro por COPIA (na pilha)
	call	soma
	add		esp, 8

	push	eax		; EAX tem o retorno de toda funcao escrita em Assembly
	push	msg3
	call	printf
	add		esp, 8

	mov		ebx, 0
	mov		eax, 1
	int		80h

; Funcao de soma
; int soma(int a, int b) {
;	int s = 0;
;	...
soma:
	; Sempre inicia uma sub-rotina ("funcao") por este par de instrucoes
	push	ebp		; salva na pilha o EBP (quadro) da funcao 'main'
	mov		ebp, esp

	sub		esp, 4	; "cria" uma variavel int na pilha (int s): SUBTRAI ESP
	mov		dword [ebp-4], 0	; s = 0
	mov		edx, [ebp+12]	; salva em EDX o valor de 'b' (final do laco)
	mov		ecx, [ebp+8]	; salva em ECX o valor de 'a' (inicio do laco)
laco:
	cmp		ecx, edx
	jg		fim
	add		[ebp-4], ecx	; soma o ECX corrente na variavel 's'
	inc		ecx
	jmp		laco
fim:
	mov		eax, [ebp-4]
	add		esp, 4	; destroi a variavel 's'
	pop		ebp		; restaura EBP para a base do quadro da func. chamadora
	ret

section .data
msg1:	db	'Digite o 1o. numero: ',0
msg2:	db	'Digite o 2o. numero: ',0
fmt:	db	'%d',0
msg3:	db	'A soma entre os numeros (inclusive) eh %d.',10,0

section .bss
num1:	resd	1
num2:	resd	2

