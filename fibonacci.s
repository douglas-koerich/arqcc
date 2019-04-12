section .bss
n:  resd    1   ; int n;

section .data
str_entrada:    db  'Digite o valor de n: ',0
str_tipo:       db  '%d',0
str_saida:      db  'f(%d) = %d',10,0

section .text
    global main
    extern printf
    extern scanf

;int main() {
main:
    ; do {
    ;     printf("Digite o valor de n: ");
    ;     scanf("%d", &n);
    ; } while (n < 0);
    push    str_entrada
    call    printf
    add     esp, 4

    push    n
    push    str_tipo
    call    scanf
    add     esp, 8

    mov     eax, [n]
    cmp     eax, 0
    jl      main

    ; if (n < 2) {
    cmp     eax, 2
    jge     calcula_fib ; salta para o else
        ; printf("f(%d) = %d\n", n, n);
    push    eax
    push    eax
    push    str_saida
    call    printf
    add     esp, 12
    jmp     fim

calcula_fib: ; eh o else do teste
    ; } else {
        ; int fn_2 = 0;
    mov     ebx, 0 ; EBX serah o fn_2
        ; int fn_1 = 1;
    mov     edx, 1
        ; int f; (vou usar o registrador EAX)

        ; O laco 'for' precisa de uma variavel 'i' de controle
        ; int i;
        ; Em assembly, esse controle fica normalmente a cargo do registrador ECX
    mov     ecx, [n]
    dec     ecx ; o numero de iteracoes do laco eh n-(2)+1 = n-1

        ; for (i = 2; i <= n; ++i) { OU
        ; for (i = n-1; i > 0; --i) { // por isso decrementamos o ECX antes do laco
inicio_for:
            ; f = fn_1 + fn_2;
    mov     eax, ebx    ; f = fn_2
    add     eax, edx    ; f += fn_1

            ; fn_2 = fn_1;
    mov     ebx, edx

            ; fn_1 = f;
    mov     edx, eax
        ; }
    loop    inicio_for ; a instrucao LOOP decrementa ECX e testa se o mesmo eh zero;
                       ; se nao for zero ainda, salta para o rotulo indicado

        ; printf("f(%d) = %d\n", n, f);
    push    eax ; EAX tem a soma final (numero de Fibonacci)
    push    dword [n]
    push    str_saida
    call    printf
    add     esp, 12
    ; }
fim:
    ; return 0;
    mov     ebx, 0
    mov     eax, 1
    int     80h
; }

