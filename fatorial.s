section .text
    global  fatorial    ; publica o rotulo 'fatorial' pra ser chamado de
                        ; outro .s ou ateh um arquivo-fonte .c

    ; Em C: int fatorial(int);
fatorial:
    ; Sempre, em toda entrada de sub-rotina, faz o mesmo
    ; passo de salvar o EBP antigo e atualizar com ESP
    push    ebp
    mov     ebp, esp

    mov     ecx, dword [ebp+8] ; copia para ECX o valor do PRIMEIRO (e unico)
                               ; argumento da sub-rotina
    xor     edx, edx
    mov     eax, 1
multiplica:
    mul     ecx                ; ECX terah n, n-1, n-2, ..., 2, 1
    loop    multiplica

    mov     esp, ebp
    pop     ebp

    ret                        ; retorno da funcao SEMPRE por EAX

