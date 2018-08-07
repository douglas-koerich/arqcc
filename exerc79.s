
; #define MAX_STRING	100
; char string[MAX_STRING];	// Variaveis globais iniciam com zero em C
; unsigned vogais, i;

section .text
	extern	puts
	extern	gets
;	extern	toupper
	extern	printf
	global	main
main:
; int main(void) {
;	puts("Digite uma frase:");
	push	msg1
	call	puts
	add		esp, 4

;	gets(string);
	push	string
	call	gets
	add		esp, 4

;	i = vogais = 0;
;	mov		dword [i], 0	; como nao tem registrador, precisa do tamanho
;	mov		dword [vogais], 0
	xor		ecx, ecx		; ECX farah o papel de "vogais"
	xor		esi, esi		; zera o registrador de "indice" (i)
	mov		ebx, string		; carrega o endereco-base

inicio_laco:
;	while (string[i] != '\0') {
	mov		al, [ebx+esi]		; AL eh o registrador de 8 bits em EAX
	cmp		al, 0				; compara com zero (termin. nulo)
	je		fim_laco

;		char maiusc = toupper(string[i]);
	; ### SOLUCAO USANDO CHAMADA A toupper() ###
;	xor		eax, eax			; zera o "lixo" que esta em EAX
;	mov		al, [ebx+esi]		; copia o byte da string para AL
;	push	ebx					; salva registradores antes do toupper()
;	push	esi
;	push	ecx
;	push	eax					; empilhar EAX que tem o caracter
;	call	toupper				; resultado estah em EAX, entao nao
;	add		esp, 4				; desempilha para EAX
;	pop		ecx
;	pop		esi
;	pop		ebx

	; ### SOLUCAO "CASEIRA" ###
	cmp		byte [ebx+esi], 'a'	; verifica se eh minuscula ou ASCII maior
	jb		minusc
	sub		al, 0x20			; transforma para maiuscula se for letra
minusc:
;		if (maiusc == 'A' || maiusc == 'E' || maiusc == 'I' ||
;			maiusc == 'O' || maiusc == 'U') {

	; ### SOLUCAO COMO EM LINGUAGEM C ###
;	mov		ah, 'A'
;	cmp		ah, al
;	je		conta
;	mov		ah, 'E'
;	cmp		ah, al
;	je		conta
;	mov		ah, 'I'
;	cmp		ah, al
;	je		conta
;	mov		ah, 'O'
;	cmp		ah, al
;	je		conta
;	mov		ah, 'U'
;	cmp		ah, al
;	jne		proximo

	; ### SOLUCAO TIPICAMENTE ASSEMBLY ###
	mov		edi, teste	; EDI = comeca na posicao de inicio da string
compara:
	scasb	; busca o caracter AL na posicao atual de EDI e incrementa
	je		conta
	cmp		byte [edi], 0	; testa fim da string de teste
	jne		compara
	jmp		proximo

conta:
;			++vogais;
	inc		ecx
;		}
proximo:
;		++i;
	inc		esi
	jmp		inicio_laco
;	}
fim_laco:
;	printf("A string %s tem %u vogais.\n", string, vogais);
	push	ecx
	push	ebx
	push	msg2
	call	printf
	add		esp, 12

;	return 0;
	mov		ebx, 0
	mov		eax, 1
	int		0x80
; }

section .data
MAX_STRING:	equ	100
msg1:		db	'Digite uma frase:',0
msg2:		db	'A string %s tem %u vogais.',10,0
teste:		db	'AEIOU',0	; usada para comparacao com o caracter em AL

section .bss
string:		resb	MAX_STRING
vogais:		resd	1
i:			resd	1
maiusc:		resb	1
