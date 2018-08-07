section .text
    global main
    extern printf
    extern scanf

%macro  PRINTF_1 1 ; um parametro para a macro
    push %1 ; empilha o primeiro (e unico) parametro da macro
    call printf
    add esp, 4
%endmacro

%macro  SCANF_1 2 ; dois parametros para a macro
    push %2
    push %1
    call scanf
    add esp, 8
%endmacro

%macro  PRINTF_2 2
    push %2
    push %1
    call printf
    add esp, 8
%endmacro

main:
    ; push pede1
    ; call printf
    ; add esp, 4
    PRINTF_1 pede1

    ; push num1
    ; push fnum
    ; call scanf
    ; add esp, 8
    SCANF_1 fnum, num1

    ; push pede2
    ; call printf
    ; add esp, 4
    PRINTF_1 pede2

    ; push num2
    ; push fnum
    ; call scanf
    ; add esp, 8
    SCANF_1 fnum, num2

    mov eax, dword [num1]
    mov ebx, dword [num2]
    sub eax, ebx

    ; push eax
    ; push menos
    ; call printf
    ; add esp, 8
    PRINTF_2 menos, eax

    mov ebx, 0
    mov eax, 1
    int 80h

section .data
pede1:  db  'Digite o primeiro numero: ',0
pede2:  db  'Digite o segundo numero: ',0
fnum:   db  '%d',0
menos:  db  'A diferenca entre o primeiro e o segundo eh %d',10,0

section .bss
num1:    resd    1
num2:    resd    1
