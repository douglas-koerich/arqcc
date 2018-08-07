%include "io.inc"

section .data
in_a:    db    'Digite o valor do dividendo (numerador): ',0
in_b:    db    'Digite o valor do divisor (denominador): ',0
;tipo:    db    '%d',0    ; para uso pelo scanf
;out_c:   db    'O quociente (inteiro) vale %d.',10,0
out_c:   db    'O quociente (inteiro) vale ',0
erro:    db    'Nao posso dividir por zero!',0
eh_div:  db    'O dividendo eh divisivel pelo divisor.',0
nao_eh:  db    'O dividendo NAO eh divisivel pelo divisor.',0

section .bss
a:    resd    1
b:    resd    1
c:    resd    1

section .text
global CMAIN
    ; global main
    ; extern puts
    ; extern printf
    ; extern scanf
CMAIN:
    mov ebp, esp; for correct debugging
;main:
    ; push in_a
    ; call printf
    ; add esp, 4
    PRINT_STRING in_a
    
    ; push a
    ; push tipo
    ; call scanf
    ; add esp, 8
    GET_DEC 4, a
    
    ; push in_b
    ; call printf
    ; add esp, 4
    PRINT_STRING in_b
    
    ; push b
    ; push tipo
    ; call scanf
    ; add esp, 8
    GET_DEC 4, b
    
    mov eax, [a]    ; carrega o dividendo (numerador) em EAX
    xor edx, edx    ; zera (limpa) o registrador EDX (parte "maior" do dividendo)
    mov ebx, [b]    ; carrega o divisor (numerador) em EBX
    
    cmp ebx, 0      ; teste do valor do divisor, agora em EBX
    je zero         ; salta para instrucao apontada por 'zero' se for igual
    idiv ebx        ; divide (EDX)EAX/EBX, pondo o quociente em EAX e o resto em EDX
    mov [c], eax
    
    ; push dword [c]
    ; push out_c
    ; call printf
    ; add esp, 8
    PRINT_STRING out_c
    PRINT_DEC 4, c
    NEWLINE
    
    ; Para verificar se A eh divisivel por B, verifico o resto da divisao
    ; (que ficou no registrador EDX) - se for divisivel, EDX contem 0 (zero)
    cmp edx, 0
    jz eh_divisivel
    ; push nao_eh
    ; call puts
    ; add esp, 4
    PRINT_STRING nao_eh
    NEWLINE
    jmp fim        ; evita que se execute os 'elses' dos testes acima
    
eh_divisivel:
    ; push eh_div
    ; call puts
    ; add esp, 4
    PRINT_STRING eh_div
    NEWLINE
    jmp fim
    
zero:
    ; push erro
    ; call puts
    ; add esp, 4
    PRINT_STRING erro
    NEWLINE
    
fim:
    ;write your code here
    xor eax, eax
    ret