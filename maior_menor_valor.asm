section .text
    global maior_menor_valor

maior_menor_valor:
    push ebp
    mov ebp, esp
    ; se houver variaveis locais estarao reservadas aqui...
    push ebx
    push esi
    push edi

    ; indice <- 0
    mov ebx, [ebp+8] ; 1o. parametro da funcao: endereco inicial do vetor
    mov esi, 0 ; deslocamento em BYTES (nao em num. de elementos) no vetor

    ; contador <- TAM
    mov ecx, [ebp+12] ; 2o. parametro da funcao

    ; enquanto contador > 0 faca
inicio_laco:
    ;   se contador = TAM entao
    cmp esi, 0 ; mais facil do que fazer cmp ecx, [ebp+12] <- leitura de memoria
    jne nao_eh_primeiro_elemento
    ;     maior <- vetor[0]
    mov eax, [ebx]  ; eax vai conter o maior valor
    ;     menor <- vetor[0]
    mov edx, eax    ; edx vai conter o menor valor
    jmp fim_se
    ;   senao
nao_eh_primeiro_elemento:
    ;     se maior < vetor[indice] entao
    cmp eax, [ebx+esi] ; maior < *(vetor+indice)
    jae nao_troca_maior
    ;       maior <- vetor[indice]
    mov eax, [ebx+esi]
    ;     fim-se
nao_troca_maior:
    ;     se menor > vetor[indice] entao
    cmp edx, [ebx+esi] ; menor > *(vetor+indice)
    jbe fim_se
    ;       menor <- vetor[indice]
    mov edx, [ebx+esi]
    ;     fim-se
    ;   fim-se
fim_se:
    ;   indice <- indice + 1
    add esi, 4 ; salta no vetor de 4 em 4 bytes (tamanho de int)

    ;   contador <- contador - 1
    ; fim-enquanto
    loop inicio_laco

    ; recupera o endereco onde vai guardar o maior valor
    mov ebx, [ebp+20] ; salva em ebx o ENDERECO que eh o 4o. parametro
    mov [ebx], eax ; salva eax no CONTEUDO do endereco que esta em ebx

    ; idem para onde vai guardar o menor valor
    mov ebx, [ebp+16] ; ENDERECO do menor eh o 3o. parametro
    mov [ebx], edx

    pop edi
    pop esi
    pop ebx
    mov esp, ebp ; limpa as variaveis locais por tabela
    pop ebp

    ret
