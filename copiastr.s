section .data
SIZE:   equ 50 ; tamanho do vetor/string na memoria
str_in: db  'Digite uma palavra ou frase: ',0
str_out:db  'A frase foi copiada para {%s}.',10,0

section .bss
src:    resb    SIZE    ; um vetor de caracteres/bytes reservado na memoria
dest:   resb    SIZE    ; outro vetor de mesmo tamanho

section .text
    global  main
    extern  printf
    extern  gets

main:
    push    str_in
    call    printf
    add     esp, 4

    ; Em C: gets(src)
    push    src
    call    gets
    add     esp, 4

    ; Calcula o tamanho da string
    mov     esi, 0      ; zera o registrador de deslocamento
    mov     ebx, src    ; salva em EBX o endereco inicial da string 'str'
proximo:
    mov     al, byte [ebx+esi] ; copia o byte da vez para AL
    cmp     al, 0       ; encontrei o terminador nulo?
    je      copia
    inc     esi
    jmp     proximo

copia:
    mov     ecx, esi    ; no fim do laco acima, ESI acabou ficando com a
                        ; contagem de caracteres VALIDOS da string
    mov     edx, dest   ; salva em EDX o endereco inicial da string 'dest'
    mov     edi, 0      ; zera o outro registrador de deslocamento
    mov     esi, 0      ; zera novamente o deslocamento em 'str'
inicio_laco:
                        ; NOTE QUE EBX *AINDA* TEM O ENDERECO INICIAL DE str
    ;mov    byte [edx+edi], byte [ebx+esi] ; nao pode acessar 2 posicoes
                                           ; de memoria no mesmo MOV
    mov     al, byte [ebx+esi]
    mov     byte [edx+edi], al
    inc     edi
    inc     esi
    loop    inicio_laco ; decrementa ECX e salta para 'inicio_laco' se > 0

    ; Mesmo se o vetor-variavel global 'dest' estah preenchido com 0s,
    ; vamos copiar o terminador nulo que ficou de fora do laco acima
    mov     byte [edx+edi], 0

    push    dest
    push    str_out
    call    printf
    add     esp, 8

    mov     ebx, 0
    mov     eax, 1
    int     80h
