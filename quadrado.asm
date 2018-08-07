section .data
x:      dd  5   ; variavel global
msg:    db  'O quadrado de %d eh %d.',10,0

section .bss

section .text
    extern  printf
    global  main
;
;int x = 5;
;int main(void) {
;    int y;
;    y = quadrado(x);
;    printf("%d\n", y);
;    return EXIT_SUCCESS; // (0)
;}
main:
    push    dword [x]   ; poe na pilha o parametro de chamada para a "funcao"
                        ; i.e. subrotina /quadrado/
    call    quadrado
    add     esp, 4

    push    eax         ; sabemos que obedecemos 'a convencao de retornar o
                        ; valor pelo registrador EAX (segundo %d do printf)
    push    dword [x]   ; primeiro %d do printf
    push    msg         ; LEMBRE-SE, empilha do ultimo para o primeiro argumento
    call    printf      ; printf(msg, x, EAX)
    add     esp, 12

    mov     ebx, 0
    mov     eax, 1
    int     80h

;int quadrado(int x) {
;    int q;
;    q = x * x;
;    return q;
;}
quadrado:
    ; SEMPRE INICIA UMA SUBROTINA COM ESTE PAR DE INSTRUCOES!!!
    push    ebp         ; salva o EBP do quadro de subrotina anterior
    mov     ebp, esp

    ; "Definicao" da variavel local (int q) - simplesmente reserva uma DWORD
    ; na pilha
    sub     esp, 4      ; reserva um espaco na pilha

    xor     edx, edx
    mov     eax, dword [ebp+8]  ; EBP tem o endereco do antigo EBP; EBP+4 tem
                                ; o endereco de retorno na funcao main; o argumento
                                ; x esta na proxima DWORD da pilha (EBP+8)
    mov     ebx, eax
    mul     ebx         ; EAX = EAX * EBX (x * x)
    mov     dword [ebp-4], eax  ; a primeira (e unica) variavel local DWORD esta em EBP-4

    ; Retornando da "funcao"/subrotina...
    mov     eax, dword [ebp-4]

    add     esp, 4      ; remove variavel local

    ; SEMPRE TERMINA A SUBROTINA COM ESTA INSTRUCAO!!!
    pop     ebp         ; recupera o EBP do quadro de subrotina anterior ANTES DE VOLTAR
    ret

