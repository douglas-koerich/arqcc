section .text
	global	main
	extern	printf
	extern	scanf
main:
	push	prompt
	call	printf
	add		esp, 4

	push	numero
	push	format
	call	scanf
	add		esp, 8

	mov		dx, 0				; esta eh a forma mais intuitiva de zerar o conteudo de um registrador
	mov		ax, word[numero]	; carrega 16 bits a partir de numero para o reg AX (16 bits)
	mov		bx, 1000
	idiv	bx					; divide DX:AX por 1000; quociente em AX, resto em DX
	mov		cl, al				; salva o milhar em CL

	mov		ax, dx				; copia o resto para AX
	xor		dx, dx				; esta eh a forma mais comum de zerar o conteudo de um registrador
	mov		bx, 100
	idiv	bx
	mov		ch, al				; salva a centena em CH

	mov		ax, dx
	xor		dx, dx
	mov		bx, 10
	idiv	bx					; AX tem a dezena, DX tem a unidade

	xor		bx, bx
	mov		bl, cl				; move o milhar de CL pra BL (como BH estah zerado, eh de CL pra BX)
	shr		cx, 8				; move a centena de CH pra CL (zerando os bits de CH)
	push	edx					; empilha sempre valores de 32 bits
	push	eax
	push	ecx
	push	ebx
	push	mensagem
	call	printf
	add		esp, 20

	mov		eax, 1
	mov		ebx, 0
	int		80h

section .data
prompt:		db	'Digite um numero: ',0
format:		db	'%hd',0
mensagem:	db	'%hd unidades de milhar, %hd centenas, %hd dezenas e %hd unidades.',10,0

section .bss
numero:		resw	1	; um numero de 16 bits <=> short int numero;

