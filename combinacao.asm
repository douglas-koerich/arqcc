section .data
prompt1: db 'Digite o numero de elementos (n): ',0
prompt2: db 'Digite o comprimento da combinacao (p): ',0
format: db '%d',0
resultado: db 'A combinacao eh %d',10,0

section .bss
n: resd 1
p: resd 1
C: resd 1
fat_n: resd 1
fat_p: resd 1
fat_n_menos_p: resd 1

section .text
	global main
	extern printf
	extern scanf

%macro LE_INTEIRO 2
	push %1	; empilha mensagem de prompt
	call printf
	add esp, 4
	push %2 ; empilha o endereco da variavel onde scanf vai guardar
	push format
	call scanf
	add esp, 8
%endmacro

main:
	LE_INTEIRO prompt1, n
	LE_INTEIRO prompt2, p
	push dword [n]
	call fatorial
	add esp, 4
	mov [fat_n], eax	; o retorno da sub-rotina estah em EAX
	push dword [p]
	call fatorial
	add esp, 4
	mov [fat_p], eax
	mov eax, [n]
	sub eax, [p]		; calcula (n-p)
	push eax			; empilha (n-p)
	call fatorial
	add esp, 4
	mov [fat_n_menos_p], eax
	
	mov eax, [fat_p]
	mov ebx, [fat_n_menos_p]
	mul ebx				; (EDX:EAX) = EAX * EBX
	mov ebx, eax		; salva em EBX o denominador da formula
	xor edx, edx		; prepara EDX para a divisao
	mov eax, [fat_n]	; prepara EAX com o dividendo
	div ebx				; EBX eh o divisor
	mov [C], eax

	push dword [C]		; dword = "empilhe 4 bytes a partir de C"
	push resultado
	call printf
	add esp, 8

	mov eax, 1
	mov ebx, 0
	int 80h

fatorial:
	push ebp		; salva o quadro da sub-rotina anterior (main)
	mov ebp, esp	; marca a guia deste quadro

	sub esp, 4		; int f; // declaracao de variaveis locais

	mov ecx, [ebp+8]; copia para ecx o parametro passado p/ fatorial
	mov ebx, 1
	mov [ebp-4], ebx; f = 1; // atribui para variavel local
laco:
	mov eax, [ebp-4]
	mul ecx
	mov [ebp-4], eax	; atualiza f
	loop laco

	mov eax, [ebp-4]	; return f;

	mov esp, ebp
	pop ebp
	ret

