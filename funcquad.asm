section .text
    global  quadrado

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

