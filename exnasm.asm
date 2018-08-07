%include "io.inc"

section .data
prompt: db    'Digite o numero de lados (N): ',0
msg:    db    'O numero de diagonais (D) eh ',0

section .bss
var_N:  resd  1
var_D:  resd  1

section .text
global CMAIN
CMAIN:
    ;write your code here
    PRINT_STRING prompt
    NEWLINE
    GET_UDEC 4, var_N
    mov eax, [var_N]
    sub eax, 3
    mov ebx, [var_N]
    mul ebx
    mov ebx, 2
    div ebx
    mov [var_D], eax
    PRINT_STRING msg
    PRINT_UDEC 4, var_D
    NEWLINE
    xor eax, eax
    ret