section .text
    ; publica rotulo da subrotina (funcao) visivel externamente
    global pot

pot:
    ; primeiras instrucoes de toda entrada em subrotina
    push ebp
    mov ebp, esp

    ; "cria" (reserva na pilha) as "variaveis locais" (sem rotulos!)
    sub esp, 4 ; 4 bytes para 'p' (ocupar = diminuir o endereco do topo)

    ; apos reservar espaco na pilha para as "variaveis locais",
    ; a convencao de chamada da linguagem C determina que os
    ; registradores EBX, ESI e EDI tenham seus conteudos
    ; preservados pela funcao/subrotina chamada
    push ebx
    push esi
    push edi

    mov eax, dword [ebp+12] ; ebp+12 eh o segundo parametro (e)
    cmp eax, 0              ; if (e == 0)
    je  p_igual_a_1

    dec eax  ; calcula o 'e - 1' para nova chamada a 'pot'
    push eax ; 2o. parametro para chamada recursiva (e-1)
    push dword [ebp+8] ; 1o. parametro para chamada recursiva
    call pot ; chamada recursiva a subrotina 'pot'
    add esp, 8  ; eh para essa instrucao que call poe o
                ; endereco de retorno na pilha quando chama
    mov ecx, dword [ebp+8] ; recupera 'b' para multiplicar
    imul ecx ; multiplica 'b' pelo retorno de 'pot' que veio em EAX
    mov dword [ebp-4], eax ; produto da multiplicacao salvo em 'p'
    jmp retorno

p_igual_a_1:
    mov dword [ebp-4], 1

retorno:
    ; antes de liberar o espaco das "variaveis locais" (destrui-las!)
    ; deve recuperar o conteudo dos registradores salvos que
    ; estao depois dessas variaveis na pilha
    pop edi
    pop esi
    pop ebx

    ; copia da variavel local para EAX que eh o registrador de retorno
    mov eax, dword [ebp-4]

    ; destroi a variavel local
    add esp, 4

    ; ultimas instrucoes de toda saida de subrotina
    pop ebp
    ret

