%include "io.inc"

section .data
msg1:   db 'Digite quantos numeros vai ler: ',0
msg2:   db 'Digite o proximo numero: ',0
format: db '%u',0
msg3:   db 'Maior = %u, menor = %u, media = %u',10,0

section .bss
qtos_numeros: resd 1
menor:  resd 1
maior:  resd 1
media:  resd 1
numero: resd 1


section .text
    global main

main:
    mov ebp, esp; for correct debugging
    PRINT_STRING msg1
    GET_UDEC 4, qtos_numeros

    mov dword [media], 0
    mov ecx, dword [qtos_numeros]
inicio:
    ; inicio do bloco do laco for
    PRINT_STRING msg2

    GET_UDEC 4, numero

    mov edx, dword [qtos_numeros]
    cmp ecx, edx    ; verifica se eh a primeira passagem do laco
    je primeiro_round

    ; else
    ; cmp dword [numero], dword [maior] (nao eh possivel comparar dois operandos de memoria)
    mov eax, dword [numero]
    mov ebx, dword [maior]
    cmp eax, ebx    ; numero (em EAX) > maior (em EBX)?
    ja num_maior

    mov ebx, dword [menor]
    cmp eax, ebx    ; numero (em EAX) < menor (em EBX)?
    jb num_menor

    jmp soma_media  ; nenhum dos dois, pula pra somar na media

inter:
    jmp inicio      ; ponto de salto intermediario (para loop "alcancar" inicio)

num_maior:
    mov dword [maior], eax  ; maior = EAX (que contem o numero)
    jmp soma_media

num_menor:
    mov dword [menor], eax  ; menor = EAX (que contem o numero)
    jmp soma_media

primeiro_round: ; if (...)
    ; mov dword [maior], dword [numero] (nao eh possivel ler dois operandos de memoria)
    mov eax, dword [numero]
    mov dword [maior], eax
    mov dword [menor], eax

soma_media:
    mov ebx, dword [media]
    add ebx, eax ; media (em EBX) += numero (em EAX)
    mov dword [media], ebx

    loop inter ; testa ECX > 0, decrementando-o

    ; esta proxima instrucao eh a seguinte apos o laco 'for'
    xor edx, edx
    mov eax, dword [media]
    mov ebx, dword [qtos_numeros]
    div ebx
    mov dword [media], eax

    PRINT_UDEC 4, maior
    NEWLINE
    PRINT_UDEC 4, menor
    NEWLINE
    PRINT_UDEC 4, media
    NEWLINE

    mov ebx, 0
    mov eax, 1
    int 80h 
