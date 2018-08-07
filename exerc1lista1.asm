%include "io.inc"

; area de codigo do programa
section .text
    global  main    ; publica o rotulo main() como se fosse um programa em C

main:
    mov ebp, esp; for correct debugging
    PRINT_STRING msg_digite
    NEWLINE
    GET_UDEC 4, total

    mov     edx, 0      ; zera a MSD (most-significant double-word) do dividendo
    mov     eax, [total]; '[total]' em Assembly equivale a '*total' em C
    mov     ebx, HORA_CHEIA ; a instrucao DIV nao aceita uma constante como Op
    div     ebx

    mov     [hora], eax     ; quociente
    mov     [total], edx    ; resto

    xor     edx, edx    ; preferivel do que mov edx, 0 (mais rapido em ULA)
    mov     eax, [total]; carregando novamente o dividendo
    mov     ebx, MIN_CHEIO
    div     ebx

    mov     [min], eax
    mov     [sec], edx

    PRINT_UDEC 4, hora
    NEWLINE
    PRINT_UDEC 4, min
    NEWLINE
    PRINT_UDEC 4, sec
    NEWLINE

    mov     ebx, 0
    mov     eax, 1
    int     80h

;-------------------------------------------------------------------------------
; area de constantes e outros dados inicializados
section .data

msg_digite: db 'Digite o total em segundos: ',0 ; nao esquecer o ,0 (equiv. \0)
msg_final:  db '%02d:%02d:%02d',10,0 ; aqui o ,10 significa usar o \n no final
cod_scanf:  db '%d',0
HORA_CHEIA: equ 3600 ; #define HORA_CHEIA 3600
MIN_CHEIO:  equ 60

;-------------------------------------------------------------------------------
; area de variaveis globais nao inicializadas
section .bss

; unsigned total;
total:  resd 1  ; REServa uma (1) Double-word (resd) para um numero de 32 bits
hora:   resd 1
min:    resd 1
sec:    resd 1