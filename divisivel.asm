; int main() {
;	int dividendo, divisor;
;	printf("Digite o dividendo: ");
;	scanf("%d", &dividendo);
;	printf("Digite o divisor: ");
;	scanf("%d", &divisor);
;
;	if (dividendo % divisor == 0) {
;		puts("O dividendo eh divisivel pelo divisor");
;	}
;	else {
;		puts("O dividendo NAO eh divisivel pelo divisor");
;	}
;	return 0;
; }

section .text
	extern printf
	extern scanf
	extern puts
	global main

main:
	push	msgin1
	call	printf
	add		esp, 4

	push	dividendo	; rotulo 'dividendo' <=> &dividendo
	push	msgfmt
	call	scanf
	add		esp, 8

	push	msgin2
	call	printf
	add		esp, 4

	push	divisor
	push	msgfmt
	call	scanf
	add		esp, 8

	mov		eax, [dividendo]	; [dividendo] <=> *dividendo
	; mov		edx, 0		; como EDX participa, deve zerar
	xor		edx, edx		; modo preferivel para zerar
	mov		ebx, [divisor]
	idiv	ebx				; (EDX:EAX)/EBX

	cmp		edx, 0			; resto ficou em EDX
	je		zero

	push	msgout2
	jmp		print

zero:
	push	msgout1

print:
	call	puts			; otimizacao: apenas uma chamada ao puts no codigo
	add		esp, 4
	mov		ebx, 0
	mov		eax, 1
	int		80h

section .data
msgin1:	db	'Digite o dividendo: ',0
msgin2:	db	'Digite o divisor: ',0
msgfmt: db	'%d',0
msgout1: db	'O dividendo eh divisivel pelo divisor',0
msgout2: db 'O dividendo NAO eh divisivel pelo divisor',0

section .bss
dividendo:	resd	1
divisor:	resd	1	
