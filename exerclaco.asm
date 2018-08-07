; Escreva um programa que leia um numero inteiro e imprima
; os proximos 20 numeros pares maiores que o numero

section .data
msg_in:     db 'Digite um numero: ',0
msg_out:    db '%d',10,0
formato:    db '%d',0

section .bss
numero:     resd 1

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
    mov     ecx, 20 ; numero de pares que vai gerar, maiores que o valor

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

    pusha   ; salva TODOS os registradores na pilha! (printf vai usar todos!)
    push    ebx
    push    msg_out
    call    printf
    add     esp, 8

    popa    ; recupera TODOS os registradores depois de chamar printf()
    loop    de_novo ; isso vai contar o numero impresso entre os 20...

    mov     ebx, 0
    mov     eax, 1
    int     80h

