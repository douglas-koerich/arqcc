section .text
    global  main
    extern  printf
    extern  scanf

main:
    push    str_entrada
    call    printf
    add     esp, 4

    push    idade
    push    str_tipo
    call    scanf
    add     esp, 8

    mov     eax, [idade]
    cmp     eax, 5
    jb      invalida    ; note o uso da instrucao para comparacao SEM sinal
    cmp     eax, 8
    jb      infantil_a
    cmp     eax, 11
    jb      infantil_b
    cmp     eax, 14
    jb      juvenil_a
    cmp     eax, 18
    jb      juvenil_b
    push    str_adulto
    jmp     imprime

invalida:
    push    str_erro
    jmp     imprime
infantil_a:
    push    str_infantil_a
    jmp     imprime
infantil_b:
    push    str_infantil_b
    jmp     imprime
juvenil_a:
    push    str_juvenil_a
    jmp     imprime
juvenil_b:
    push    str_juvenil_b
    jmp     imprime

imprime:
    call    printf
    add     esp, 4

    mov     ebx, 0
    mov     eax, 1
    int     80h

section .data
str_entrada:    db  'Digite a idade do(a) nadador(a): ',0
str_tipo:       db  '%u',0
str_infantil_a: db  'Infantil A',10,0
str_infantil_b: db  'Infantil B',10,0
str_juvenil_a:  db  'Juvenil A',10,0
str_juvenil_b:  db  'Juvenil B',10,0
str_adulto:     db  'Adulto',10,0
str_erro:       db  'IDADE INVALIDA!',10,0

section .bss
idade:  resd    1
