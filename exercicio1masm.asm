.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc	; definicoes de C (do VC++)

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib	; objeto das funcoes de C

.data
PROMPT1	db	'Digite o valor de a: ',0
PROMPT2	db	'Digite o valor de b: ',0
MSG1	db	'Antes da troca: a=%d, b=%d.',10,0
MSG2	db	'Depois da troca: a=%d, b=%d.',10,0
FORMAT	db	'%d',0

.data?
a	dd	?	; reserva um DWORD (32 bits) com "lixo" (?)
b	dd	?

.code
main:
	; printf("Digite o valor de a: ");
	invoke	crt_printf, addr PROMPT1

	; scanf("%d", &a);
	invoke	crt_scanf, addr FORMAT, addr a

	; printf("Digite o valor de b: ");
	invoke	crt_printf, addr PROMPT2

	; scanf("%d", &b);
	invoke	crt_scanf, addr FORMAT, addr b

	; printf("Antes da troca: a=%d, b=%d.\n", a, b);
	invoke	crt_printf, addr MSG1, a, b

	; aux = a, a = b, b = aux;
	mov		eax, [a]
	mov		ebx, [b]
	mov		ecx, eax	; aux = a
	mov		eax, ebx	; a = b
	mov		ebx, ecx	; b = aux
	mov		[a], eax
	mov		[b], ebx

	; printf("Depois da troca: a=%d, b=%d.\n", a, b);
	invoke	crt_printf, addr MSG2, a, b

	invoke	ExitProcess, 0
end main
