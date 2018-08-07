%include "io.inc"

section .text
    extern printf
    extern scanf
global CMAIN
CMAIN:
    mov ebp, esp
    ;write your code here
    ; Leitura do valor total em segundos
    ;push    msg_in
    ;call    printf
    ;add     esp, 4
    PRINT_STRING msg_in
    
    ;push    total
    ;push    fmt_in
    ;call    scanf
    ;add     esp, 8
    GET_UDEC 4, total

    ; Toda operacao de divisao envolve AMBOS edx:eax, portanto se o valor
    ; cabe soh em EAX, entao EDX deve ser zerado (para que o "lixo" nao
    ; influencie no resultado da divisao)
    mov     edx, 0
    mov     eax, [total]
    mov     ebx, 3600   ; precisa mover para registrador a fim de usar DIV
    div     ebx         ; EAX = total / 3600 (quociente)
                        ; EDX = total % 3600 (resto)
    mov     [horas], eax

    mov     eax, edx    ; poe em EAX o resto que vai ser dividido por 60
    mov     edx, 0      ; limpa edx novamente
    xor     edx, edx    ; uma limpeza (zerar) mais rapida!
    mov     ebx, 60
    div     ebx
    mov     [minutos], eax
    mov     [segundos], edx

    ;push    dword [segundos]
    ;push    dword [minutos]
    ;push    dword [horas]
    ;push    dword [total]
    ;push    msg_out
    ;call    printf
    ;add     esp, 20
    NEWLINE
    PRINT_UDEC 4, total
    PRINT_STRING msg_out
    PRINT_UDEC 4, horas
    PRINT_CHAR ':'
    PRINT_UDEC 4, minutos
    PRINT_CHAR ':'
    PRINT_UDEC 4, segundos
    NEWLINE

    xor eax, eax
    ret
    
section .data
msg_in:     db  'Digite o total de segundos: ',0
;msg_out:    db  '%d segundos equivalem a %02d:%02d:%02d.',10,0
msg_out:    db  ' segundos equivalem a ',0
fmt_in:     db  '%d',0

section .bss
total:      resd    1
horas:      resd    1
minutos:    resd    1
segundos:   resd    1

