%include "io.inc"

section .text
    global CMAIN
    extern getchar
    extern toupper
    extern isalpha
CMAIN:
    mov ebp, esp; for correct debugging
    PRINT_STRING pedido
    NEWLINE
    GET_CHAR c

    mov	al, [c] ; como eh apenas 1 byte fica em AL (LSB do EAX)

    ; push	al		; nao eh possivel empilhar um byte apenas
    push	eax		; EAX ainda tem o caracter lido por getchar()
    call	isalpha	; novamente, o retorno estah em EAX
    add	esp, 4

    cmp	eax, 0	; 0 (falso) significa que nao eh letra
    jz	outros

    xor	eax, eax	; limpa EAX (estah sujo por causa do isalpha)
    mov	al, [c]
    push	eax		; empilha o caracter
    call	toupper	; de novo, o retorno estah em EAX (caracter em AL)

    cmp	al, 'A'
    je	vogal

    cmp	al, 'E'
    je	vogal

    cmp	al, 'I'
    je	vogal

    cmp	al, 'O'
    je	vogal

    cmp	al, 'U'
    je	vogal

    cmp	al, 'Y'
    je	vogal

    PRINT_STRING msgcons
    jmp saida

vogal:
    PRINT_STRING msgvogal
    jmp saida

outros:
    PRINT_STRING msgoutro

saida:
    NEWLINE
    mov	ebx, 0
    mov	eax, 1
    int	80h

section .data
pedido: 	db	'Digite um caracter: ',0
msgvogal:	db	'Vogal',0
msgcons:	db	'Consoante',0
msgoutro:	db	'Outro',0

section .bss
c:	resb	1
