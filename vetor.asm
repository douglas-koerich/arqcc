%include "io.inc"

section .data
TAM: equ 5    ; #define TAM 5

prnvet: db 'Valores no vetor: ',0
prnmed: db 'Media dos valores: ',0

section .bss
vetor: resd TAM    ; int vetor[TAM];
r: resd 1          ; int r;

section .text
global CMAIN
extern srand
extern rand
extern time
; int main()
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    ; srand(time(0));
    xor eax, eax
    push eax
    call time        ; time(0), retorna em EAX
    add esp, 4
    push eax
    call srand       ; srand(retorno de time(0))
    add esp, 4
    
    mov ecx, TAM
    mov edi, vetor
novo:
    pushad    ; salva registradores antes de rand()
    
    ; r = rand() % 100;
    call rand
    xor edx, edx
    mov ebx, 100
    idiv ebx    ; EAX = EAX / 100, EDX = EAX % 100 
    mov [r], edx
    
    popad

    mov eax, [r]
    stosd
    loop novo
    
    PRINT_STRING prnvet
    xor eax, eax
    mov ebx, vetor    ; lea ebx, [vetor]
    mov ecx, TAM
    mov esi, 0
laco:
    mov edx, [ebx+esi]; modo de enderecamento base+deslocamento
    add eax, edx      ; acumulando o somatorio
    add esi, 4        ; pula para proximo int
    jmp print_dec
longe:                ; rotulo auxiliar para alcancar 'laco'
    jmp laco
print_dec:
    PRINT_DEC 4, edx  ; imprime o valor
    jmp print_chr
perto:
    jmp longe         ; rotulo auxiliar para alcancar 'laco'
print_chr:
    PRINT_CHAR 20h    ; imprime um espaco
    loop perto        ; como 'laco' esta "longe" na memoria, uso
                      ; rotulos de "escala"
    
    xor edx, edx
    mov ebx, TAM
    idiv ebx
    NEWLINE
    PRINT_STRING prnmed
    PRINT_DEC 4, eax
    ; return 0;
    xor eax, eax
    ret