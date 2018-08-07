section .text
	extern printf
	extern scanf
	global main

%macro LE_STRING 2
	push	%1
	call	printf
	add		esp, 4
	push	%2
	push	formato
	call	scanf
	add		esp, 8
%endmacro

main:
	cld		; faz com que ESI e EDI sejam INcrementados na operacao CMPSB, STOSB, etc.

	; inicializa o conteudo das strings com zeros
	mov		al, 0
	mov		edi, string1
	mov		ecx, TAMANHO
preenche1:
	stosb	; carrega AL para EDI e incrementa EDI
	loop	preenche1

	mov		edi, string2
	mov		ecx, TAMANHO
;preenche2:
;	stosb
;	loop	preenche2
	rep		stosb	; REPete stosb enquanto ECX <> 0

	LE_STRING prompt1, string1
	LE_STRING prompt2, string2

	mov		esi, string1
	mov		edi, string2
	mov		ecx, TAMANHO
;compara:
;;	mov		al, byte [esi]
;;	mov		bl, byte [edi]
;;	cmp		al, bl			; *esi == *edi? (na verdade, se faz *esi-*edi)
;	cmpsb					; compara os bytes em ESI e EDI e automaticamente avanca ambos
	repz	cmpsb			; REPete cmpsb enquanto ECX <> 0 *e* ZF=1 (flag zero ativado)
	cmp		ecx, 0
	jnz		diferentes
;; 	cmp		al, 0			; se fizer apenas cmp [esi], 0 vai comparar 4 bytes (32 bits)
;; 	jz		iguais
;;	inc		esi				; equivalente a 'add esi,1' q significa ir para o proximo byte
;;	inc		edi				; comentamos este codigo pq CMPSB ja incrementa ESI e EDI
;	loop	compara
iguais:
	push	resp1
	call	printf
	add		esp, 4
	jmp		saida
diferentes:
;	mov		eax, TAMANHO
	mov		eax, TAMANHO-1	; mudou porque REPZ nao decrementa ECX quando ZF=0 
	sub		eax, ecx
	push	eax				; indice = TAMANHO-ecx (ECX comeca em TAMANHO e vai diminuindo)
	push	resp2
	call	printf
	add		esp, 8
saida:
	mov		eax, 1
	mov		ebx, 0
	int		80h

section .data
prompt1:	db	'Digite a primeira string: ',0
prompt2:	db	'Digite a segunda string: ',0
formato:	db	' %s',0	; com espaco na frente do %s para limpar o buffer do teclado
resp1:		db	'As strings sao iguais.',10,0
resp2:		db	'As string diferem no indice %d.',10,0
TAMANHO:	equ	20
;string1:	times TAMANHO db 0	; reserva um byte zerado 20 vezes (string1[20] inicializado)
;string2:	times TAMANHO db 0

section .bss
string1:	resb	TAMANHO		; char string1[TAMANHO];
string2:	resb	TAMANHO		; char string2[TAMANHO];

