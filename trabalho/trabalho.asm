section .data
UM:     equ 10000000b
infmt:  db  '%f',0


section .bss
float:  resd    1

section .text
    extern printf
    extern scanf
    global __in__
    global __out__
    global __sum__
    global __inc__
    global __sub__
    global __dec__
    global __mul__
    global __div__
    global __pow__

__in__:
    push ebp
    mov ebp, esp

    push float
    push fmt
    call scanf
    add esp, 8

    mov ebx, [int]
    sal ebx, 7

    pop ebp
    ret

__out__:
    push ebp
    mov ebp, esp

    pop ebp
    ret

__sum__:
    push ebp
    mov ebp, esp

    mov eax, dword[ebp+8]
    mov ebx, dword[ebp+12]

    add eax, ebx

    pop ebp
    ret

__inc__:
    push ebp
    mov ebp, esp

    mov ebx, dword[ebp+8]
    xor eax, eax
    mov ax, word[ebx]

    add ax, UM
    mov word[ebx], ax

    pop ebp
    ret

__sub__:
    push ebp
    mov ebp, esp

    mov eax, dword[ebp+8]
    mov ebx, dword[ebp+12]

    sub eax, ebx

    pop ebp
    ret

__dec__:
    push ebp
    mov ebp, esp

    mov ebx, dword[ebp+8]
    xor eax, eax
    mov ax, word[ebx]

    sub ax, UM
    mov word[ebx], ax

    pop ebp
    ret

__mul__:
    push ebp
    mov ebp, esp

    xor edx, edx
    mov eax, dword[ebp+8]
    mov ebx, dword[ebp+12]

    imul ebx
    sal edx, 16
    or eax, edx
    sar eax, 7
    and eax, 0xffff

    pop ebp
    ret

__div__:
    push ebp
    mov ebp, esp

    xor edx, edx
    mov eax, dword[ebp+8]
    sal eax, 7
    mov ebx, dword[ebp+12]

    idiv ebx
    sal edx, 16
    or eax, edx

    pop ebp
    ret

__pow__:
    push ebp
    mov ebp, esp

    mov ebx, dword[ebp+8]
    mov ecx, dword[ebp+12]

    mov eax, UM
    cmp ecx, 0
    je  fim
    xor edx, edx
laco:
    imul ebx
    sal edx, 16
    or eax, edx
    sar eax, 7
    and eax, 0xffff
    loop laco
fim:
    pop ebp
    ret
