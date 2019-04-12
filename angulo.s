section .text
    global main
    extern printf
    extern scanf

main:
    push    str_entrada
    call    printf
    add     esp, 4

    push    angulo
    push    str_tipo
    call    scanf
    add     esp, 8

    ; Usa os registradores de 16 bits do antigo 8086 (AX, BX, CX, ...)    
    mov     ax, word [angulo] ; copia uma "word" a partir do rotulo/endereco 'angulo'
    
    cmp     ax, 0
    jl      negativo ; usa uma instrucao de desvio que compara operandos COM sinal
    xor     dx, dx ; para um angulo positivo, os bits de mais alta ordem da divisao
                   ; sao zeros
    mov     cl, 0  ; salva "false" (0) no registrador de 8 bits de mais baixa ordem
                   ; do registrador ECX
    jmp     divisao
negativo:
    mov     dx, 0xffff ; para um angulo negativo, os bits de mais alta ordem da divisao
                       ; sao 1s (uns), pois sao a EXPANSAO do bit de sinal de AX!
    mov     cl, 1  ; salva "true" (1) no registrador de 8 bits
divisao:
    mov     bx, VOLTA_COMPLETA
    idiv    bx     ; idiv (com i) eh usada quando os operandos sao SIGNED int

    mov     word [reduzido], dx ; DX tem o resto da divisao

    cmp     ax, 0
    jge     sentido
    neg     ax ; faz a inversao do sinal (em complemento-de-2; v. pag. de instrucoes)
sentido:
    mov     byte [horario], cl ; horario = cl (false|0 ou true|1);
    mov     word [voltas], ax

    cmp     cl, 0
    je      print_anti
    push    str_horario
    jmp     print_sentido
print_anti:
    push    str_antihor
print_sentido:
    call    printf
    add     esp, 4

    push    dword [voltas] ; empilha os 32 bits da variavel 'voltas'
    push    str_voltas
    call    printf
    add     esp, 8

    push    word [reduzido] ; empilha os 16 bits da variavel 'reduzido'
    push    str_reduzido
    call    printf
    add     esp, 6  ; 2 bytes do 'reduzido' + 4 bytes do rotulo 'str_reduzido'

    mov     ax, word [reduzido] ; recupera o valor da variavel para o registrador
    cmp     ax, 90
    jge     nao_eh_primeiro
    mov     bx, 1 ; BX = 1(o. quadrante)
    jmp     print_quadrante
nao_eh_primeiro:
    cmp     ax, 180
    jge     nao_eh_segundo
    mov     bx, 2
    jmp     print_quadrante
nao_eh_segundo:
    cmp     ax, 270
    jge     eh_quarto
    mov     bx, 3
    jmp     print_quadrante
eh_quarto:
    mov     bx, 4
print_quadrante:
    push    bx
    push    str_quadrante
    call    printf
    add     esp, 6

    ; precisa concluir a programacao com o teste de quadrante dos
    ; angulos negativos (homework)

    mov     ebx, 0
    mov     eax, 1
    int     80h

section .data
VOLTA_COMPLETA: equ 360 ; #define VOLTA_COMPLETA 360
str_entrada:    db 'Digite o angulo (em graus): ',0
str_tipo:       db '%hd',0 ; scanf("%hd", &angulo);
str_horario:    db 'O sentido eh horario.',10,0
str_antihor:    db 'O sentido eh anti-horario.',10,0
str_voltas:     db 'O numero de voltas eh %u.',10,0
str_reduzido:   db 'O angulo reduzido vale %hd graus.',10,0
str_quadrante:  db 'O angulo situa-se no %huo. quadrante.',10,0

section .bss
; /* VARIAVEIS _GLOBAIS_ DO PROGRAMA */
angulo:     resw    1 ; (un)signed short angulo; // 16 bits
horario:    resb    1 ; bool horario; // 1 byte (8 bits)
voltas:     resd    1 ; (un)signed int voltas; // 32 bits
reduzido:   resw    1 ; (un)signed short reduzido; // novamente, 16 bits

