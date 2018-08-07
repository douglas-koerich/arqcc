section .text
    global main
    extern printf

main:
    mov  eax, MSG
    mov  ebx, FMT
    push eax    ; comeca a empilhar do ultimo...
    push ebx    ; ... para o primeiro parametro
    call printf ; chama a funcao (subrotina) de C
    add  esp, 8 ; devolve o topo (ESP) para a
                ; posicao original

    mov  eax, 1
    mov  ebx, 0
    int  80h

section .data

MSG:    db 'Hello',10,0 ; inclui o '\0' para printf
FMT:    db '%s',0 ; "%s" usado no printf

section .bss
