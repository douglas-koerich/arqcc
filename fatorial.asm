%include "io.inc"

section .data
pednum: db 'Digite o numero: ',0
visfat: db 'O fatorial eh ',0

section .bss
num: resd 1    ; int num;
fat: resd 1    ; int fat;

section .text
global CMAIN
; int main()
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    ; printf("Digite o numero: ");
    PRINT_STRING pednum
    
    ; scanf("%d", &num);
    GET_DEC 4, num    ; 4 -> numero de bytes
    
    ; for (i=num, fat=1; i>0; --i)
    ;    fat *= i;
    mov    eax, 1    ; EAX eh o ACUMULADOR (fat)
    mov    ecx, [num]; i = num;
    xor    edx, edx  ; EDX eh envolvido no MUL
multiplica:    
    mul    ecx       ; (EDX:)EAX=EAX*ECX (fat=fat*i)
    loop   multiplica; Decrementa e testa ECX (--i>0?)
    
    mov    [fat], eax
    
    ; printf("O fatorial eh %d\n", fat);
    PRINT_STRING visfat
    PRINT_DEC 4, fat
    NEWLINE
    
    ; return 0;
    xor eax, eax
    ret