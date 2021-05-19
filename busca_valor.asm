section .text
    global busca_valor

busca_valor:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    ; Como o vetor passado eh uma sequencia de int's (DWORDs),
    ; entao a instrucao SCASD pode buscar o valor que estiver em
    ; EAX a partir do inicio do vetor que eh inicialmente armazenado
    ; em EDI
    mov eax, [ebp+8] ; copia 'x' para EAX a fim de ser usado na comparacao
    mov edi, [ebp+12] ; poe EDI no inicio do vetor de inteiros a ser varrido
    mov ecx, [ebp+16] ; define o alcance das comparacoes

    repne scasd ; REPNE: repita instrucao enquanto EAX diferente do ponto em EDI
                ; SCASD: compara EAX com EDI, marcando flag de igualdade quando 
                ; "dah match", o que interrompe REPNE

    mov eax, 0 ; eax = NULL (para o caso de nao encontrado)

    ; Encontrou?
    cmp ecx, 0
    jz fim_subrotina

    mov eax, edi ; salva em eax o ENDERECO que estah em edi que permaneceu
                 ; quando repne foi interrompido

fim_subrotina:
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp

    ret ; eax terah o endereco (edi se interrompeu, ou 0 se ecx == 0)
