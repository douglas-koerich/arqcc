%include "io.inc"

section .data
entnum:  db "Digite um numero inteiro e positivo: ",0
sainum1: db "O fatorial de ",0
sainum2: db " eh ",0

section .bss
num: resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    ;push entnum
    ;call printf
    ;add esp, 4
    PRINT_STRING entnum
    NEWLINE
    
    ;push num
    ;push fmtent
    ;call scanf
    ;add esp, 8
    GET_UDEC 4, num
    
    push dword [num]
    call fatorial
    add esp, 4 ; tira o valor de num da pilha
    
    ;push eax
    ;push dword [num]
    ;push sainum
    ;call printf
    ;add esp, 12
    PRINT_STRING sainum1
    PRINT_UDEC 4, num
    PRINT_STRING sainum2
    PRINT_UDEC 4, eax ; retorno da subrotina estah em EAX
    
    xor eax, eax ; = mov eax, 0
    ret
    
fatorial: ; Copia da subrotina como estah em fatorial_sub32.asm
    push ebp
    mov ebp, esp
    
    push ebx
    push esi
    push edi
    
    mov ecx, dword [ebp+8]
    mov eax, 1
continua:
    mul ecx
    loop continua
    
    pop edi
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    
    ret