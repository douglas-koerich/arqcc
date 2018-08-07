;// Definicao de estrutura
;struct tempo {
;	int hora;
;	int minuto;
;	int segundo;
;};

struc tempo
hora:		resd	1
minuto:		resd	1
segundo:	resd	1
endstruc

section .data
dummy:	; nao vou usar, apenas para poder calcular 'tamanho' (v. abaixo)
istruc tempo
	at hora,	dd	0
	at minuto,	dd	0
	at segundo, dd	0
iend
;#define tamanho sizeof(struct tempo)
tamanho:	equ	$-dummy	; $=endereco atual; $-dummy=diferenca entre enderecos
						; (v. "Hello world!" asmtut/index.html no grupo Yahoo!)
;struct tempo* t = NULL;
t:		dd	0		; ponteiros sao numeros de 32 bits
;int total = 0;
total:	dd	0
msg1:	db	'Digite total de segundos: ',0
fmt:	db	'%d',0
msg2:	db	'Equivale a %02d:%02d:%02d.',10,0

section .text
	extern printf
	extern scanf
	extern calloc	; use calloc porque essa funcao ja zera a memoria alocada!
	extern free		; free eh usada tambem para calloc
	global main

;int main(void) {
main:
;	t = calloc(1, tamanho);
	mov		ecx, tamanho
	mov		ebx, 1
	push	ecx
	push	ebx
	call	calloc
	add		esp, 8
	mov		[t], eax	; salva em t (ponteiro) o endereco retornado por calloc
;	
;	printf("Digite total de segundos: ");
	push	msg1
	call	printf
	add		esp, 4

;	scanf("%d", &total);
	push	total
	push	fmt
	call	scanf
	add		esp, 8

;	t->hora = total / 3600;
	xor		edx, edx
	mov		eax, [total]
	mov		ecx, 3600
	div		ecx
	mov		ebx, [t]	; poe em EBX o conteudo (endereco!) armazenado em 't'
	mov		[ebx+hora], eax	; aqui estah a diferenca entre t.hora e t->hora!

;	total %= 3600;
;	t->minuto = total / 60;
	mov		eax, edx
	xor		edx, edx
	mov		ecx, 60
	div		ecx

;	t->segundo = total % 60;
	mov		[ebx+minuto], eax
	mov		[ebx+segundo], edx

	push	ebx			; salva o conteudo de EBX (ponteiro!) antes de printf

;	printf("Equivale a %02d:%02d:%02d.\n", t->hora,
;		   t->minuto, t->segundo);
	push	dword [ebx+segundo]
	push	dword [ebx+minuto]
	push	dword [ebx+hora]
	push	msg2
	call	printf
	add		esp, 16

;	free(t);
	; push	dword [t]	; ao inves disso, aproveita que EBX esta na pilha!
	call	free
	add		esp, 4

;	return 0;
	mov		ebx, 0
	mov		eax, 1
	int		80h
;}

