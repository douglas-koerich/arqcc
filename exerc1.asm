section .data
prompt_a:	db 'Digite a: ',0	; pq usa printf a string deve ter o term. nulo
prompt_b:	db 'Digite b: ',0
msg_antes:	db 'Antes da troca: a=%d, b=%d.',10,0	; assembly nao conhece \n
msg_depois:	db 'Depois da troca: a=%d, b=%d.',10,0
formato:	db '%d',0

section .bss			; em assembly todas as variaveis sao globais
a:			resd	1	; int a;	// int = dword (32 bits)
b:			resd	1	; int b;
aux:		resd	1	; int c;

section .text
	global	main		; rotulo publicado para modulos externos (crt library)
	extern	printf		; funcoes da libc que vamos usar neste modulo assembly
	extern	scanf
main:
	push	prompt_a	; todo parametro de chamada eh posto na pilha
	call	printf		; chama funcao
	add		esp, 4		; ao inves de pop, simplesmente voltamos a pilha

	push	a			; qdo ha mais de um parametro, comeca pelo ultimo...
	push	formato		; ... ate o primeiro (padrao de chamada em C!)
	call	scanf
	add		esp, 8

	push	prompt_b
	call	printf
	add		esp, 4

	push	b
	push	formato
	call	scanf
	add		esp, 8

;	push	dword[b]	; isso eh diferente de 'push b' - queremos empilhar
;	push	dword[a]	; os /valores/ de a e b, nao seus enderecos
	mov		eax, dword[a]	; ao inves de variaveis (c/ acesso a memoria), ...
	mov		ebx, dword[b]	; ... vamos usar registradores (acesso + rapido!)
	push	ebx
	push	eax				; precisa /salvar/ registradores (printf suja!)
	push	msg_antes
	call	printf
	add		esp, 4			; despreza o endereco msg_antes, mas...
	pop		eax				; ... recupera os registradores salvos na pilha
	pop		ebx
;
;	1a. opcao: usando acesso a memoria/variaveis (REPARE: comentado!)
;	mov		eax, dword[a]
;	mov		ebx, dword[b]
;	mov		dword[a], ebx
;	mov		dword[b], eax

;	2a. opcao: usando um terceiro registrador na solucao classica para troca de valores (REPARE: tambem comentado!)
;	mov		edx, eax	; classico algoritmo de troca, usando variavel
;	mov		eax, ebx	; (no caso, registrador) auxiliar
;	mov		ebx, edx

;	3a. opcao ("macete"): usando a operacao OU-EXCLUSIVO para trocar sem auxiliar
	xor		eax, ebx	; solucao tipica de um programa assembly, usando as
	xor		ebx, eax	; instrucoes mais rudimentares (e rapidas!)
	xor		eax, ebx

;	Se a 1a. opcao fosse a escolhida, ela continuaria aqui (apos a troca)
;	push	dword[b]
;	push	dword[a]

	push	ebx			; aqui nao estah salvando registradores, sao os
	push	eax			; parametros de printf mesmo (REPARE na ordem!)
	push	msg_depois
	call	printf
	add		esp, 12

	mov		eax, 1
	mov		ebx, 0
	int		80h

;/* Codigo comparativo em C: */
;int a, b, aux;
;int main() {
;	printf("Digite a: ");
;	scanf("%d", &a);
;
;	printf("Digite b: ");
;	scanf("%d", &b);
;
;	printf("Antes da troca: a=%d, b=%d.\n", a, b);
;
;	aux = a;
;	a = b;
;	b = aux;
;
;	printf("Depois da troca: a=%d, b=%d.\n", a, b);
;
;	return 0;
;}
