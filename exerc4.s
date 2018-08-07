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
		mov		[milhar], eax

		; num = num % 1000;
		mov		[num], edx		; desnecessario, v. proxima instrucao

		; centena = num / 100;
		mov		eax, edx		; EDX tem o valor do num (resto anterior)
		xor		edx, edx
		mov		ebx, 100
		div		ebx
		mov		[centena], eax

		; num %= 100;
		mov		[num], edx		; de novo, isto eh desnecessario!

		; dezena = num / 10;
		mov		eax, edx
		xor		edx, edx
		mov		ebx, 10
		div		ebx
		mov		[dezena], eax

		; unidade = num % 10;
		mov		[unidade], edx

		; printf("%d unidades de milhar, %d centenas, %d dezenas e %d unidades\n", milhar, centena, dezena, unidade);
		push	dword [unidade]		; empilha 4 bytes (dword)
		push	dword [dezena]
		push	dword [centena]
		push	dword [milhar]
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
milhar:		resd	1
centena:	resd	1
dezena:		resd	1
unidade:	resd	1

