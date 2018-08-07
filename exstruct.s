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

;// Declaracao de uma variavel do tipo estrutura
;struct tempo t = { 0, 0, 0 };
t:
istruc tempo
	at hora,	dd	0
	at minuto,	dd	0
	at segundo, dd	0
iend

;int total = 0;
total:	dd	0
msg1:	db	'Digite total de segundos: ',0
fmt:	db	'%d',0
msg2:	db	'Equivale a %02d:%02d:%02d.',10,0

section .text
	extern printf
	extern scanf
	global main

;int main(void) {
main:
;	printf("Digite total de segundos: ");
	push	msg1
	call	printf
	add		esp, 4

;	scanf("%d", &total);
	push	total
	push	fmt
	call	scanf
	add		esp, 8

;	t.hora = total / 3600;
	xor		edx, edx
	mov		eax, [total]
	mov		ecx, 3600
	div		ecx
	mov		[t+hora], eax

;	total %= 3600;
;	t.minuto = total / 60;
	mov		eax, edx
	xor		edx, edx
	mov		ecx, 60
	div		ecx

;	t.segundo = total % 60;
	mov		[t+minuto], eax
	mov		[t+segundo], edx

;	printf("Equivale a %02d:%02d:%02d.\n", t.hora,
;		   t.minuto, t.segundo);
	push	dword [t+segundo]
	push	dword [t+minuto]
	push	dword [t+hora]
	push	msg2
	call	printf
	add		esp, 16

;	return 0;
	mov		ebx, 0
	mov		eax, 1
	int		80h
;}

