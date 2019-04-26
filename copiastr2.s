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
    mov     ecx, esi

    mov     edi, dest   ; nesta segunda versao, os registradores EDI e ESI
                        ; iniciarao com os ENDERECOS das strings
    mov     esi, src
; ###################################################################
; VERSAO (2) AINDA USANDO UM LACO DE FORMA EXPLICITA (C/ INSTR. loop)
; inicio_laco:
    ; ***************************************************************
    ; VERSAO (1) BASEADA NA COPIA USANDO INSTRUCOES DE ACESSO A VETOR
    ; NA MEMORIA
    ; mov     al, byte [esi]
    ; mov     byte [edi], al
    ; inc     edi
    ; inc     esi
    ; ***************************************************************
;   movsb ; esta UNICA instrucao faz o mesmo que as 4 (QUATRO!)
          ; anteriores comentadas acima
;
;   loop    inicio_laco ; decrementa ECX e salta para 'inicio_laco' se > 0
; ####################################################################

    ; Instrucao que executa um laco e uma movimentacao de string completa
    ; de uma soh vez
    rep movsb

    ; Mesmo se o vetor-variavel global 'dest' estah preenchido com 0s,
    ; vamos copiar o terminador nulo que ficou de fora do laco acima
    mov     byte [edi], 0

    push    dest
    push    str_out
    call    printf
    add     esp, 8

    mov     ebx, 0
    mov     eax, 1
    int     80h
