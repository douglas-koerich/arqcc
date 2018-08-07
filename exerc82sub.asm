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

; int main() {
main:
	; printf("Digite a primeira string: "); scanf(" %s", string1);
	LE_STRING prompt1, string1
	; printf("Digite a segunda string: "); scanf(" %s", string2);
	LE_STRING prompt2, string2

	; int retorno = compara(string1, string2);
	; pusha
	push	string2		; do ultimo parametro para o primeiro na chamada em C
	push	string1
	call	compara
	add		esp, 8		; a rotina chamadora deve limpar os parametros passados da pilha
	; popa				; SE USAR ESSA INSTRUCAO VAI ***PERDER*** O RETORNO QUE ESTA EM EAX

	; if (retorno == -1) {
	cmp		eax, -1		; o retorno da subrotina estah em EAX
	jne		diferentes

	;	printf("As strings sao iguais.\n");
	push	resp1
	call	printf
	add		esp, 4
	jmp		saida
	; }
	; else {
	;	printf("As strings diferem no indice %d.\n", retorno);
diferentes:
	push	eax		; o retorno (indice diferente) estah em EAX
	push	resp2
	call	printf
	add		esp, 8
	; }
saida:
	; return 0;
	mov		eax, 1
	mov		ebx, 0
	int		80h
; }	// fim da funcao main()


; int compara(char* string1, char* string2) {
compara:
	push	ebp		; primeirissima coisa a ser feita ao entrar na subrotina
	mov		ebp, esp

	; int indice = 0;
	mov		ecx, 0
	push	ecx		; variaveis locais residem na pilha a partir (abaixo) do EBP

	mov		esi, [ebp+8]; 'string1' eh um parametro armazenado 8 bytes a mais que EBP
	mov		edi, [ebp+12]; (tem que pular o valor antigo de EBP e o valor de PC empilhado)
proximo:
	mov		dl, byte [esi]
	mov		dh, byte [edi]
	cmp		dh, dl
	je		testa_terminador_nulo

	; // Sao diferentes
	; return indice
	mov		eax, [ebp-4]	; INICIO da primeira variavel local na pilha = 4 bytes abaixo
	jmp		retorno

testa_terminador_nulo:
	cmp		dl, 0
	jz		strings_iguais
	inc		esi
	inc		edi
	mov		ecx, [ebp-4]
	inc		ecx
	mov		[ebp-4], ecx
	jmp		proximo

strings_iguais:
	mov		eax, -1		;	por padrao, o retorno de uma funcao vem pelo registrador EAX

retorno:
						;	ultimissima coisa a fazer antes de sair da rotina
	add		esp, 4		;	destroi a variavel local 'indice'
	pop		ebp			;	traz para EBP o seu valor antigo

	ret

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

