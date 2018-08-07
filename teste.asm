section .text
	global main

main:
	mov	edi, dst
	mov	esi, src
	mov	ecx, 10
iter:
	mov	al, byte [esi]
	mov byte [edi], al
	cmp byte [edi], 0
	inc edi
	inc esi
	loop iter

	mov	eax, 1
	mov	ebx, 0
	int 80h

section .data

section .bss
dst:	resb	10
src:	resb	10
