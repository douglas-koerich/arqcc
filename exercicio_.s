; A subrotina abaixo implementa o mesmo algoritmo escrito
; em linguagem C como segue:
;
; int i=0, r=0;
; while (i<*tamanho) {
;     if (vetor[i] % x == 0) {
;         int j;
;         for (j=i; j<*tamanho-1; ++j) {
;             vetor[j] = vetor[j+1];
;         }
;         --(*tamanho);
;         ++r;
;     } else {
;         ++i;
;     }
; }
; return r;

section .text
    global rem_multiplos

rem_multiplos:
    push    ebp         ; par de instrucoes que sempre inicia uma entrada de
    mov     ebp, esp    ; subrotina em Assembly x86

    ; int i, r;
    sub     esp, 8      ; reserva espaco para variaveis locais 'i' e 'r',
                        ; ambas com 4 bytes cada
    ; int tam; // (extra)
    sub     esp, 4      ; tamanho do vetor que serah atualizado ao longo da
                        ; subrotina
    push    ebx         ; esses sao os registradores que toda subrotina em
    push    esi         ; Assembly x86 tem que salvar APOS alocar as suas
    push    edi         ; variaveis locais (se houver)

    ; ESI <- vetor
    mov     esi, dword [ebp+8]    ; salva em ESI o ENDERECO inicial do vetor,
                                  ; que foi recebido como 1o. parametro
    ; EBX <- tamanho (ponteiro)
    mov     ebx, dword [ebp+12]   ; salva em EBX o ENDERECO do tamanho, que foi
                                  ; recebido como 2o. parametro
    ; tam = *tamanho
    mov     edx, dword [ebx]
    mov     dword [ebp-12], edx ; inicializa variavel local 'tam'

    ; i=0, r=0;
    mov     dword [ebp-4], 0  ; inicializa variavel local 'i'
    mov     dword [ebp-8], 0  ; inicializa variavel local 'r'

inicio_laco_externo:
    ; while (i<*tamanho) { ...
    ; antes de entrar no laco, sempre faz o teste de controle
    mov     ecx, dword [ebp-4]  ; recupera o valor atual de 'i'
    cmp     ecx, dword [ebp-12] ; compara com o valor ATUALIZADO do tamanho
                                ; (na variavel local 'tam')
    jge     retorno     ; fim do laço

    xor     edx, edx            ; EDX <- 0
    mov     eax, dword [esi]    ; EAX <- vetor[i] (endereco ATUALIZADO contido em ESI)

    mov     ebx, dword [ebp+16] ; o valor de 'x' estah no 3o. parametro

    idiv    ebx         ; EDX <- vetor[i] % x

    ; vetor[i] % x == 0?
    cmp     edx, 0
    je      laco_interno

    ; else ++i;
    inc     ecx
    mov     dword [ebp-4], ecx

    ; ESI += sizeof(int) --> endereco do proximo elemento em 'vetor'
    add     esi, 4
    jmp     inicio_laco_externo

laco_interno:
    mov     ebx, dword [ebp-12] ; recupera o tamanho ATUALIZADO do vetor
    dec     ebx         ; EBX <- *tamanho-1

    ; for (j=i; ...
    mov     eax, ecx    ; EAX farah o papel da variavel local 'j'

    mov     edi, esi    ; EDI inicia com o endereco de vetor+i (que estah em ESI)

inicio_laco_interno:
    ; for(...; j<*tamanho-1; ...
    cmp     eax, ebx
    jge     fim_laco_interno

    mov     edx, dword [edi+4]  ; EDX <- vetor[j+1]
    mov     dword [edi], edx    ; vetor[j] <- EDX

    ; for (...; ...; ++j)
    inc     eax

    ; EDI += sizeof(int) --> endereco do proximo elemento em 'vetor'
    add     edi, 4
    jmp     inicio_laco_interno

fim_laco_interno:
    mov     dword [ebp-12], ebx ; atualiza (diminui) o tamanho do vetor
                                ; armazenado na variavel local 'tam'
    mov     eax, dword [ebp-8]
    inc     eax
    mov     dword [ebp-8], eax  ; incrementa o numero de elementos removidos
                                ; armazenado na variavel local 'r'
    jmp     inicio_laco_externo

retorno:
    ; EBX <- tamanho (ponteiro)
    mov     ebx, dword [ebp+12] ; salva em EBX o ENDERECO do tamanho, que foi
                                ; recebido como 2o. parametro
    mov     edx, dword [ebp-12] ; recupera o tamanho ATUALIZADO do vetor da
                                ; variavel local 'tam'
    mov     dword [ebx], edx    ; atualiza o valor do tamanho no ENDERECO da
                                ; variavel original
    mov     eax, dword [ebp-8] ; recupera o contador de removidos para EAX

    pop     edi         ; recupera o conteudo dos registradores empilhados
    pop     esi
    pop     ebx

    add     esp, 12     ; libera a porcao de pilha usada para as variaveis locais

    pop     ebp         ; par de instrucoes que sempre finaliza uma subrotina
    ret                 ; lembre-se: o retorno estah em EAX
