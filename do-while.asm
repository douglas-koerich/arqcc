section .text
    global main
    extern printf
    extern scanf

main:
    push msg_pedido
    call printf
    add esp, 4

    push resposta
    push percent_c
    call scanf
    add esp, 8

                            ; +--------+----+----+
    mov al, byte [resposta] ; |        | AH | AL |
                            ; +--------+----+----+
                            ; |        |    AX   |
                            ; +--------+----+----+
                            ; |        EAX       |
                            ; +--------+----+----+
    cmp al, 'S'
    je ok

    cmp al, 'N'
    je nok

    jmp main ; salta para o inicio do programa
ok:
    push msg_ok
    jmp imprime
nok:
    push msg_nok
imprime:
    call printf
    add esp, 4

    mov ebx, 0
    mov eax, 1
    int 80h

section .data

msg_pedido: db "Voce concorda (S/N)? ",0
percent_c:  db " %c",0
msg_ok:     db "OK!",10,0
msg_nok:    db "NOK.",10,0

section .bss

resposta:   resb 1