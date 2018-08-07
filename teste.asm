%include "io.inc"

section .data
prompts: db 'Digite uma string para teste: ',0
promptc: db 'Digite um caracter para procurar: ',0
resulty: db 'O caracter foi encontrado!',0
resultn: db 'O caracter nao foi encontrado!',0
max: equ 64

section .bss
chr: resb 1      ; char chr
src: resb max    ; char src[max];
dst: resb max    ; char dst[max];

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    PRINT_STRING prompts
    NEWLINE
    GET_STRING src, 64
    
    mov edi, dst
    mov esi, src
    mov ecx, max
    rep movsb
    
    PRINT_STRING promptc
    NEWLINE
    GET_CHAR chr
    
    mov al, [chr]
    mov edi, dst
    mov ecx, max
    repnz scasb
    
    jz achou
    PRINT_STRING resultn
    jmp saida
    
achou:
    PRINT_STRING resulty

saida:
    xor eax, eax
    ret