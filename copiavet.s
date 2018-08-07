section .data
prnnmb: db  '%d ',0
LIMITE: equ 50
TAM: equ 5

section .bss
vet1:    resd    TAM
vet2:    resd    TAM

section .text
    global main
    extern printf
    extern putchar
    extern rand

main:
    mov ecx, TAM
    mov edi, vet1

inicio_r: ; laco para preencher o vetor 'vet1'
    push ecx
    push edi

    call rand

    pop edi
    pop ecx

    xor edx, edx
    mov ebx, LIMITE
    div ebx

    mov dword [edi], edx ; salva em 'vet1' o novo numero pseudo-aleatorio

    add edi, 4

    loop inicio_r

    mov ecx, TAM
    mov esi, vet1   ; endereco de origem (Source) em 'vet1'
    mov edi, vet2   ; endereco de destino (Destination) em 'vet2'

; inicio_c:
;    mov eax, dword [esi] ; copia para EAX o (proximo) numero em 'vet1'
;    mov dword [edi], eax ; copia EAX para 'vet2'

;    add esi, 4
;    add edi, 4  ; "caminha" com os enderecos para o proximo numero nos vetores

;    loop inicio_c
    cld       ; Limpa DF (direction flag) fazendo com que ESI/EDI sejam incrementados
    rep movsd ; REPeat (repita) MOVSD (copia de uma double-word de ESI para EDI)

    mov ecx, TAM
    mov esi, vet2   ; vou imprimir o vetor 'vet2' (copia)

inicio_p:
    push ecx
    push esi

    push dword [esi]
    push prnnmb
    call printf
    add esp, 8

    pop esi
    pop ecx

    add esi, 4

    loop inicio_p

    mov ebx, 10 ; '\n'
    push ebx
    call putchar
    add esp, 4

    mov ebx, 0
    mov eax, 1
    int 80h

