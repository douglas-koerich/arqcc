section .text
    global main
    extern printf
    extern putchar  ; desafio: substitua pela syscall correspondente
main:
    mov     ecx, TAM        ; contador de percurso do vetor (equivale ao 'i')
    mov     edi, vetor      ; endereco inicial do destino em EDI
    mov     esi, fibonacci  ; endereco inicial da origem em ESI

; inicio_copia:
;     mov     eax, dword [esi]
;     mov     dword [edi], eax
;     add     esi, 4          ; vai para o proximo elemento (com 4 bytes) no vetor de origem
;     add     edi, 4          ; idem para o endereco do proximo elemento no vetor de destino
;     loop    inicio_copia
    cld                     ; garante que ESI e EDI serao INcrementados durante a copia
    rep     movsd

    mov     ecx, TAM
    mov     esi, vetor

inicio_impressao:
    push    ecx             ; empilhar os valores desses registradores eh necessario
    push    esi             ; para nao perde-los, uma vez que a chamada a 'printf' vai
                            ; muito provavelmente ocupar os mesmos (e destruir seu conteudo)
    push    dword [esi]
    push    fmt_printf
    call    printf
    add     esp, 8

    pop     esi         ; aqui eh necessario usar pop (e nao 'add esp...') pra ter de volta
    pop     ecx         ; os valores empilhados - repare que estao na ordem INVERSA do push

    add     esi, 4
    loop    inicio_impressao

    ; push    10 (nao eh possivel empilhar uma constante)
    mov     eax, 10
    push    eax
    call    putchar
    add     esp, 4

    mov     ebx, 0
    mov     eax, 1
    int     80h

section .data
; Variaveis globais inicializadas sao definidas no .data
TAM:        equ 8
fibonacci:  dd  1,2,3,5,8,13,21,34  ; conteudo inicial do "vetor"
fmt_printf: db  '%d ',0

section .bss
vetor:      resd    TAM
