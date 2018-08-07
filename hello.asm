section .data

MSG:    db 'Hello',10 ; const char* const MSG = "Hello\n"
STDOUT: equ 1 ; #define STDOUT 1

section .text
    global _start

_start:
    ; write(STDOUT, MSG, 6)
    mov eax, 4
    mov ebx, STDOUT
    mov ecx, MSG
    mov edx, 6
    int 80h

    ; exit(0) <=> return 0
    mov eax, 1
    mov ebx, 0
    int 80h

