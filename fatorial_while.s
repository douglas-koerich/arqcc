; unsigned n, i, f;
; int main() {
;   printf("Digite n: ");
;   scanf("%u", &n);
;   f = 1;
;   i = 1;
;   while (i > 0) {
;       f *= i;
;       --i;
;   }
;   printf("O fatorial eh %u.\n", f);
; }

section .text
    global  main
    extern  printf
    extern  scanf
main:
    push    prompt
    call    printf
    add     esp, 4
    push    n
    push    format
    call    scanf
    add     esp, 8

    mov     eax, 1      ; f = 1
    mov     ebx, [n]    ; i = n
teste:
    cmp     ebx, 0      ; i <?> 0
    je      print
    mul     ebx
    dec     ebx
    jmp     teste

print:
    push    eax
    push    result
    call    printf
    add     esp, 8

    mov     ebx, 0
    mov     eax, 1
    int     80h

section .data
prompt:     db      'Digite n: ',0
format:     db      '%u',0
result:     db      'O fatorial eh %u.',10,0

section .bss
n:          resd    1
