section .text
	global	main
	extern	scanf
	extern	printf

	; int main() {
main:
		; int num, milhar, centena, dezena, unidade;
		; printf("Digite um numero: ");
		push	msg1
		call	printf
		add		esp, 4	; tamanho do rotulo empilhado eh 4 bytes

		; scanf("%d", &num);
		push	num
		push	fmtd	
		call	scanf
		add		esp, 8	; foram empilhados 2 argumentos com 4 bytes cada

		; milhar = num / 1000;
		xor		edx, edx		; mov edx, 0
		mov		eax, [num]
		mov		ebx, 1000
		div		ebx
		push	eax				; salva o 'milhar'

		; num = num % 1000;
		; centena = num / 100;
		mov		eax, edx		; EDX tem o valor do num (resto anterior)
		xor		edx, edx
		mov		ebx, 100
		div		ebx
		push	eax				; salva a 'centena'

		; num %= 100;
		; dezena = num / 10;
		mov		eax, edx
		xor		edx, edx
		mov		ebx, 10
		div		ebx

		; unidade = num % 10;

		; NOTE: EDX tem a unidade, EAX tem a dezena e a pilha tem a centena
		; e o milhar
		pop		ecx				; agora ECX tem a centena...
		pop		ebx				; ... e EBX tem o milhar

		; printf("%d unidades de milhar, %d centenas, %d dezenas e %d unidades\n", milhar, centena, dezena, unidade);
		push	edx
		push	eax
		push	ecx
		push	ebx
		push	msg2
		call	printf
		add		esp, 20

		; return 0;
		mov		ebx, 0
		mov		eax, 1
		int		0x80
	; }

section .data
msg1:	db 'Digite um numero: ',0
msg2:	db '%d unidades de milhar, %d centenas, %d dezenas e %d unidades',10,0
fmtd:	db '%d',0

section .bss
num:		resd	1

