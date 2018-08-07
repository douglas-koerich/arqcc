section .text
	global	soma
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

