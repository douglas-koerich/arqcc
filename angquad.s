section .text
	extern	printf
	extern	scanf
	global	main
main:
; short int angulo, reduzido;		// variaveis globais
; char voltas;
; int main(void) {
	; printf("Digite o angulo (inteiro) em graus: ");
	push	msg1
	call	printf
	add		esp, 4

	; scanf("%hd", &angulo);
	push	angulo
	push	fmtw
	call	scanf
	add		esp, 8

	; voltas = angulo / 360;
	mov		ax, [angulo]; como angulo tem soh 16 bits, usa AX
	cwd					; estende o sinal de AX para DX
	mov		bx, 360
	idiv	bx			; idiv: divisao com sinal (para angulos negativos)
	mov		[voltas], al; como voltas tem soh 8 bits, usa AL

	; reduzido = angulo % 360;
	mov		[reduzido], dx
	push	dx			; salva o reduzido que estah em DX antes de chamar
						; printf (que vai sujar o registrador!!!)

	; printf("Numero de voltas: %hhd (%s).\n", voltas,
	; 		 voltas < 0? "horario": "anti-horario");
	cmp		al, 0		; AL tem o valor de 'voltas' (v. acima)
	jl		hor			; salta p/ endereco da instrucao que faz
						; push da string "horario"
	push	anti
	jmp		vol
hor:
	push	horario
vol:
	cwde				; estende o bit de sinal sobre EAX porque...
	push	eax			; ... printf requer que parametros sejam de 32 bits
	push	msg2
	call	printf
	add		esp, 12

	pop		ax			; devolve o reduzido para AX ao inves de DX porque...
	cwde				; ... soh AX pode ter bit de sinal estendido para EAX

	; printf("Angulo reduzido: %hdo.\n", reduzido);
	push	eax			; salva EAX na pilha para comparacao
	push	eax
	push	msg3
	call	printf
	add		esp, 8

	; if (reduzido <= 0) {
	pop		eax
	cmp		eax, 0
	jg		maior
	;	if (reduzido > -90) {
	cmp		eax, -90
	jle		neg1
	;		printf("Quarto quadrante.\n");
	push	q4
	call	printf
	add		esp, 4
	;	}
	jmp		fim
neg1:
	;	else if (reduzido > -180) {
	cmp		eax, -180
	jle		neg2
	;		printf("Terceiro quadrante.\n");
	push	q3
	call	printf
	add		esp, 4
	;	}
	jmp		fim
neg2:
	;	else if (reduzido > -270) {
	cmp		eax, -270
	jle		neg3
	;		printf("Segundo quadrante.\n");
	push	q2
	call	printf
	add		esp, 4
	;	}
	jmp		fim
neg3:
	;	else {
	;		printf("Primeiro quadrante.\n");
	push	q1
	call	printf
	add		esp, 4
	;	}
	jmp		fim
	; }
maior:
	; else {
	;	if (reduzido <= 90) {
	cmp		eax, 90
	jg		pos1
	;		printf("Primeiro quadrante.\n");
	push	q1
	call	printf
	add		esp, 4
	;	}
	jmp		fim
pos1:
	;	else if (reduzido <= 180) {
	cmp		eax, 180
	jg		pos2
	;		printf("Segundo quadrante.\n");
	push	q2
	call	printf
	add		esp, 4
	;	}
	jmp		fim
pos2:
	;	else if (reduzido <= 270) {
	cmp		eax, 270
	jg		pos3
	;		printf("Terceiro quadrante.\n");
	push	q3
	call	printf
	add		esp, 4
	;	}
	jmp		fim
pos3:
	;	else {
	;		printf("Quarto quadrante.\n");
	push	q4
	call	printf
	add		esp, 4
	;	}
	; }
fim:
	; return 0;
	mov		ebx, 0
	mov		eax, 1
	int		0x80
; }
section .data
msg1:		db	'Digite o angulo (inteiro) em graus: ',0
fmtw:		db	'%hd',0
msg2:		db	'Numero de voltas: %hhd (%s).',10,0
horario:	db	'horario',0
anti:		db	'anti-horario',0
msg3:		db	'Angulo reduzido: %hdo.',10,0
q1:			db	'Primeiro quadrante.',10,0
q2:			db	'Segundo quadrante.',10,0
q3:			db	'Terceiro quadrante.',10,0
q4:			db	'Quarto quadrante.',10,0

section .bss
angulo:		resw	1	; inteiro de 16 bits (short int)
voltas:		resb	1	; inteiro de 8 bits (char)
reduzido:	resw	1

