section .text
    global fatorial

fatorial:
    ; INICIO DO GRUPO DE INSTRUCOES QUE DEVE ESTAR PRESENTE EM TODA
    ; ENTRADA DE SUB-ROTINA
    push ebp        ; empilha os 32 bits (4 bytes) do registrador EBP
    mov ebp, esp    ; salva o topo da pilha no momento da entrada na
                    ; sub-rotina

    push ebx        ; o conteudo dos registradores EBX, ESI e EDI
    push esi        ; *deve* ser salvo (preservado) por uma subrotina;
    push edi        ; os demais sao livres para serem alterados
    ; FIM DO GRUPO DE INSTRUCOES DE ENTRADA

    mov ecx, dword [ebp+8] ; +8? EBP tem o endereco na pilha do EBP
                           ; antigo, com 4 bytes. EBP+4 eh a localizacao
                           ; do endereco de retorno que foi empilhado
                           ; pela propria instrucao CALL. EBP+8 eh a
                           ; localizacao do primeiro argumento que foi
                           ; empilhado pela funcao que chamou esta
                           ; sub-rotina
    mov eax, 1
continua:
    mul ecx
    loop continua

    ; INICIO DO GRUPO DE INSTRUCOES QUE DEVE ESTAR PRESENTE EM TODA
    ; SAIDA DE SUB-ROTINA
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ; FIM DO GRUPO DE INSTRUCOES DE SAIDA

    ret ; retorna ao endereco empilhado por CALL

section .data

section .bss
