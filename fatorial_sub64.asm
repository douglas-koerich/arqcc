section .text
    global fatorial

fatorial:
    mov rcx, rdi
    mov rax, 1
continua:
    mul rcx
    loop continua

    ret

section .data

section .bss
