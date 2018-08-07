; Escreva um programa que leia um numero inteiro e salve num vetor
; os proximos 20 numeros pares maiores que o numero; em seguida, imprima
; o conteudo do vetor

section .data
msg_in:     db 'Digite um numero: ',0
msg_out:    db '%d',10,0
formato:    db '%d',0
TAMANHO:    equ 20  ; equivale a #define TAMANHO 20

section .bss
numero:     resd 1
vetor:      resd TAMANHO    ; similar a int vetor[TAMANHO]

section .text
    global main
    extern printf
    extern scanf

main:
    ; Instrucoes (com chamadas a C) para leitura do numero
    push    msg_in
    call    printf
    add     esp, 4
    push    numero
    push    formato
    call    scanf

    ; Armazena em EBX o valor (inicial) do numero
    mov     ebx, [numero]   ; colchetes usados para ir ao rotulo e buscar o valor armazenado
    mov     ecx, TAMANHO    ; numero de pares que vai gerar, maiores que o valor

    ; Armazena em EDI o endereco inicial do vetor (&vetor[0], ou soh o nome 'vetor', como em C)
    mov     edi, vetor

de_novo:    ; marca o inicio do bloco de codigo do laco ({)
    ; Testa um novo numero seguinte ao valor inicial
    inc     ebx

    ; Prepara os registradores pra fazer o teste se eh par
    mov     eax, ebx
    xor     edx, edx

    ; Durante a divisao vou precisar salvar ECX...
    push    ecx ; como nao consegue chamar DIV com o valor constante 2,
                ; vai precisar do ECX (outros ja estao ocupados); assim,
                ; precisa "salvar" o valor do registrador (i.e., o contador)
    mov     ecx, 2
    div     ecx ; quociente em EAX, resto em EDX
    pop     ecx ; recupera o contador (do laco)

    cmp     edx, 0  ; testa o resto da divisao por 2
    jne     de_novo ; repare: como nao vai passar por LOOP, nao vai contar!

    ; Sendo um numero par, vou salvar o numero que estah em EBX no vetor
    mov     dword [edi], ebx    ; *edi = ebx
    add     edi, 4  ; equivale a incrementar o indice do vetor (que eh de inteiros->tamanhos de 4 bytes)
                    ; CUIDADO! Nao eh ++edi, porque em assembly estamos orientados a bytes

    loop    de_novo ; isso vai contar o numero impresso entre os 20...

    ; Restaura o inicio do vetor para EDI...
    mov     edi, vetor
    mov     ecx, TAMANHO    ; vou comecar um novo laco...
print_vetor:
    pusha   ; salva TODOS os registradores na pilha! (printf vai usar todos!)

    push    dword [edi]
    push    msg_out
    call    printf
    add     esp, 8

    popa    ; recupera TODOS os registradores depois de chamar printf()

    add     edi, 4
    loop    print_vetor

    mov     ebx, 0
    mov     eax, 1
    int     80h

