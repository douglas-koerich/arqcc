%include "io.inc"

section .data
LIMITE: equ 50
TAM: equ 5

section .bss
vet:    resd    TAM

section .text
    global main
    extern printf
    extern putchar
    extern rand

main:
    mov ebp, esp; for correct debugging
    mov ecx, TAM
    mov edi, 0 ; indice inicial do vetor

inicio_r:
    push ecx
    push edi ; salva os registradores que serao alterados por rand()

    call rand ; numero pseudo-aleatorio eh retornado em EAX

    pop edi
    pop ecx ; retira da pilha na ordem inversa da insercao (senao vai trocar
            ; os valores entre eles!)

    xor edx, edx
    mov ebx, LIMITE
    div ebx ; divide EAX (implicito) por EBX

    mov dword [vet+edi], edx ; guarda o resto (0-49) no vetor
                             ; edi eh usado como indice

    add edi, 4  ; incrementa pelo tamanho do tipo do "vetor" (++indice)

    loop inicio_r ; volta para gerar o proximo numero

    mov ecx, TAM
    mov edi, 0

inicio_p:
    push ecx
    push edi

    PRINT_DEC 4, [vet+edi]
    jmp nova_linha
    
meio:
    jmp inicio_p

nova_linha:
    NEWLINE

    pop edi
    pop ecx

    add edi, 4  ; incrementa pelo tamanho do tipo do "vetor" (++indice)

    loop meio

    mov ebx, 10 ; '\n'
    push ebx
    call putchar
    add esp, 4

    mov ebx, 0
    mov eax, 1
    int 80h

