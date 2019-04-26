section .bss
n:      resd    1
p:      resd    1
C:      resd    1
fat_n:  resd    1
fat_p:  resd    1
fat_np: resd    1

section .data
str_entrada_n:  db  'Digite n: ',0
str_entrada_p:  db  'Digite p: ',0
str_tipo:       db  '%u',0
str_saida:      db  'C = %u',10,0

section .text
    global  main
    extern  printf
    extern  scanf
    extern  fatorial    ; referencia a um rotulo externo

main:
    push    str_entrada_n
    call    printf
    add     esp, 4
    push    n
    push    str_tipo
    call    scanf
    add     esp, 8

    push    str_entrada_p
    call    printf
    add     esp, 4
    push    p
    push    str_tipo
    call    scanf
    add     esp, 8

    push    dword [n]           ; empilha o argumento
    call    fatorial            ; chama a sub-rotina
    add     esp, 4              ; despreza o argumento
    mov     dword [fat_n], eax  ; salva o retorno

    push    dword [p]           ; empilha o argumento
    call    fatorial            ; chama a sub-rotina
    add     esp, 4              ; despreza o argumento
    mov     dword [fat_p], eax  ; salva o retorno

    mov     eax, dword [n]
    mov     ebx, dword [p]
    sub     eax, ebx            ; n-p
    push    eax
    call    fatorial
    add     esp, 4
    mov     dword [fat_np], eax

    mov     eax, dword [fat_p]
    mov     ebx, dword [fat_np]
    xor     edx, edx
    mul     ebx
    mov     ebx, eax            ; salva o denominador p!(n-p)! em EBX

    mov     eax, dword [fat_n]
    xor     edx, edx
    div     ebx
    mov     dword [C], eax

    push    dword [C]
    push    str_saida
    call    printf
    add     esp, 8

    mov     ebx, 0
    mov     eax, 1
    int     80h

