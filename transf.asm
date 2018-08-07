section .text
	global main
	extern printf

%macro	PRINTV	1	; macro para imprimir 1 parametro
	push %1			; empilha o parametro
	push msg
	call printf
	add esp, 8
%endmacro

main:
	; Em todas os casos, vamos imprimir assim:
	; printf("Numero = %u\n", eax);

	; Modo de enderecamento imediato (valor na instrucao)
	mov eax, 1024
	
	; Passagem de parametros para uma funcao em C: comeca
	; empilhando do ultimo para o primeiro parametro

	; Modo de enderecamento de registrador
	; push eax

	; Modo de enderecamento direto (endereco na instrucao)
	; push msg

	; call printf
	; add esp, 8	; 4 bytes de msg + 4 bytes de eax
	PRINTV eax

	; Modo de enderecamento direto
	; push valor	; vai empilhar o ENDERECO 'valor'

	; push msg
	; call printf
	; add esp, 8
	PRINTV valor

	; Modo de enderecamento indireto
	; push dword [valor]	; [valor] em Assembly <=> *valor em C

	; push msg
	; call printf
	; add esp, 8
	PRINTV dword [valor]

	mov eax, valor	; Carrega o ENDERECO (nao valor) em EAX
					
	pushad			; Como a chamada a printf vai CERTAMENTE
					; substituir o conteudo de EAX, vamos
					; salva-lo na pilha junto com os demais 
					; registradores
	; push eax
	; push msg
	; call printf
	; add esp, 8
	PRINTV eax

	popad			; Recupera os registradores salvos

	; Modo de enderecamento indireto por registrador
	; push dword [eax]

	; push msg
	; call printf
	; add esp, 8
	PRINTV dword [eax]

	; Sair do programa
	mov eax, 1
	mov ebx, 0
	int 80h

section .data
		; db = byte (ou sequencia de bytes)
msg:	db	'Numero = %u',10,0	; 10='\n', 0='\0'
		; dd = dword (ou sequencia de double words
valor:	dd	30

section .bss

