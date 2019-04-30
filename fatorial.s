section .text
    global  fatorial    ; publica o rotulo 'fatorial' pra ser chamado de
                        ; outro .s ou ateh um arquivo-fonte .c

    ; Em C: int fatorial(int);
fatorial:
    ; Sempre, em toda entrada de sub-rotina, faz o mesmo
    ; passo de salvar o EBP antigo e atualizar com ESP
    push    ebp
    mov     ebp, esp

    ; Se esta sub-rotina for chamada de um código-fonte em C, o compilador
    ; daquela linguagem assumira como verdadeiro que:
    ; * os registradores EAX, ECX e EDX podem ser sobrescritos pela sub-rotina
    ; * os registradores EBX, EDI e ESI serao preservados pela sub-rotina
    push    ebx ; NESTA SUB-ROTINA, isto eh um "preciosismo", jah que ela NAO
    push    esi ; estah utilizando nenhum dos registradores que deveriam ser
    push    edi ; preservados (assim poderiamos economizar esses PUSHs e seus POPs)

    mov     ecx, dword [ebp+8] ; copia para ECX o valor do PRIMEIRO (e unico)
                               ; argumento da sub-rotina
    xor     edx, edx
    mov     eax, 1
multiplica:
    mul     ecx                ; ECX terah n, n-1, n-2, ..., 2, 1
    loop    multiplica

    ; Pronto pra sair da sub-rotina:
    pop     edi ; registradores de destino na ordem INVERSA da que foi usada
    pop     esi ; nos PUSHs da entrada da sub-rotina
    pop     ebx

    mov     esp, ebp
    pop     ebp

    ret                        ; retorno da funcao SEMPRE por EAX

