section .text
	global fatorial
	
fatorial:
	push ebp		; salva o quadro da sub-rotina anterior (main)
	mov ebp, esp	; marca a guia deste quadro

	sub esp, 4		; int f; // declaracao de variaveis locais

	mov ecx, [ebp+8]; copia para ecx o parametro passado p/ fatorial
	mov ebx, 1
	mov [ebp-4], ebx; f = 1; // atribui para variavel local
laco:
	mov eax, [ebp-4]
	mul ecx
	mov [ebp-4], eax	; atualiza f
	loop laco

	mov eax, [ebp-4]	; return f;

	mov esp, ebp
	pop ebp
	ret

