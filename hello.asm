section .text

global  _start

_start: mov eax, WRITE
        mov ebx, STDOUT
        mov ecx, contents
        mov edx, length
        int 80h

        mov ebx, SUCCESS
        mov eax, EXIT
        int 80h

section .data

contents:   db  "Hello, world!",10
length:     equ $-contents

EXIT:       equ 1
WRITE:      equ 4
STDOUT:     equ 1
SUCCESS:    equ 0

section .bss