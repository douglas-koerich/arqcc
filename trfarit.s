section .data
MAX:	equ	100		; #define MAX 100
MIN:	dd	100000	; const long MIN = 100000

section .bss
x:		resd	1	; long int x (na real, long int* x!!!)
y:		resw	1	; short int y
c:		resb	1	; char c
vet_i:	resd	10	; long int vet[10]
string: resb	MAX	; char string[MAX]

section .text
		global	main
main:
		mov		edx, 5		; EDX = 5 (enderec. imediato)
		mov		ecx, MIN	; ECX = MIN (ender. direto)
		mov		ebx, ecx	; EBX = ECX (end. registrador)
		mov		eax, [x]	; EAX = *x -> x eh ponteiro!
							; (enderecamento indireto)
		mov		[x], edx	; *x = EDX (nesse momento = 5)
		mov		edx, [ebx]	; EDX = *EBX
							; (ender. indir. registrador)
		mov		[y], dx		; *y = DX (16 LSBs de 100000)
		mov		word [x], dx

		push	ebx			; ESP decrementou de 4 bytes
		push	eax			; idem
		push	x			; idem (rotulos sao de 32 bits)
		push	dword [x]	; idem (conteudo de 32 bits)
		push	word [y]	; empilha 16 bits
		add		esp, 18		; limpa pilha 4 x 4 bytes + 2

		mov		eax, 1		; sys_exit
		mov		ebx, 0		; sucesso na saida
		int		0x80

