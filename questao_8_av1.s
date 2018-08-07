section .text
    global main
    extern printf
main:
    mov eax, 16h
    xor ebx, ebx
    mov ecx, 5
l:
    mov edx, eax
    and edx, 40h
    jz  m
    mov bl, byte [a]
    jmp n
m:
    mov bl, byte [b]
n:
    mul ebx
    loop l
    push ebx
    push eax
    push fmt
    call printf
    add esp, 12

    mov ebx, 0
    mov eax, 1
    int 80h

section .data
a:      db 3
b:      db 5
fmt:    db 'AX = %d, BL = %d',10,0

