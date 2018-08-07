section .data
msg:    db  'Digite o sexo (M/F): ', 0
fmt:    db  ' %c',0 ; para o scanf
end:    db  'Fim do laco!',0

section .bss
sexo:   resb 1

section .text
    extern printf
    extern puts
    extern scanf
    global main

main:
    push    msg
    call    printf
    add     esp, 4

    push    sexo
    push    fmt
    call    scanf
    add     esp, 8

    mov     al, [sexo]  ; usa um registrador de 8 bits (parte inferior do EAX)
    cmp     al, 'M'
    je      fim
    cmp     al, 'm'
    je      fim
    cmp     al, 'F'
    je      fim
    cmp     al, 'f'
    je      fim
    jmp     main    ; aproveito o mesmo rotulo para indicar o inicio do laco do-while

fim:
    push    end
    call    puts
    add     esp, 4

    mov     ebx, 0
    mov     eax, 1
    int     80h

