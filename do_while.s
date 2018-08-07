section .text

; do {
;     printf("Aceita os termos do acordo (S/N)? ");
;     scanf(" %c", &opcao);
;     opcao = tolower(opcao);
; } while (opcao != 's' && opcao != 'N');

    global main
    extern printf
    extern scanf
    extern tolower  ; converte pra minuscula

main:
    push msg
    call printf
    add esp, 4

    push opcao
    push fmt
    call scanf
    add esp, 8

    ; push opcao (NAO FUNCIONA PQ push SOH EMPILHA 16 ou 32 BITS)
    xor eax, eax ; zera o registrador EAX
    mov al, byte [opcao]    ; copia para AL (byte mais baixo de EAX) um byte em *opcao
    push eax     ; agora sim, eh possivel empilhar...
    call tolower ; converte o caractere que estah em eax,
                 ; devolvendo o resultado no mesmo eax
    add esp, 4

    ; O caractere, sendo de 1 byte, estah na parte AL do registrador EAX
    cmp al, 's'
    je yes

    cmp al, 'n'
    je nein

    jmp main    ; volta para o inicio do "laco"

yes:
    push sim
    jmp imprime

nein:
    push nao

imprime:
    call printf
    add esp, 4

    mov ebx, 0
    mov eax, 1
    int 80h

section .data
msg: db 'Aceita os termos do acordo (S/N)? ',0
fmt: db ' %c',0
sim: db 'Voce concordou',10,0
nao: db 'Voce discordou',10,0

section .bss
opcao: resb 1

