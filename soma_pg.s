section .text
    global soma_pg

soma_pg:
    ; Entrada da sub-rotina
    push    ebp
    mov     ebp, esp

    ; int q_elevado_n
    sub     esp, 4  ; variavel local

    ; DEPOIS de reservar todas as variaveis locais necessarias,
    ; salva os registradores que deveriam ser preservados pela sub-rotina
    push    ebx
    push    esi
    push    edi

    mov     ecx, dword [ebp+16] ; 3o. argumento (n)
    mov     eax, 1
    xor     edx, edx
    mov     ebx, dword [ebp+12] ; 2o. argumento (q)
potencia:
    mul     ebx
    loop    potencia

    mov     dword [ebp-4], eax ; q_elevado_n = EAX

    xor     edx, edx
    mov     eax, dword [ebp+8] ; 1o. argumento (a1)
    dec     ebx ; EBX jah tinha a razao, decrementa
    div     ebx ; calcula a1/(q-1)

    xor     edx, edx
    mov     ebx, dword [ebp-4]
    dec     ebx ; q^n - 1
    mul     ebx ; EAX *= (q^n - 1)

    ; Saida da sub-rotina
    pop     edi
    pop     esi
    pop     ebx

    mov     esp, ebp    ; abandona as posicoes da pilha ocupadas pelas
                        ; variaveis locais
    pop     ebp
    ret
