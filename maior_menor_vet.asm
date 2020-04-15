section .data
MAX: equ 5 ; #define MAX 5
msgent: db "Digite o proximo elemento do vetor: ",0
fmtent: db "%d",0
msgsai: db "O maior valor eh %d e o menor %d",10,0

section .text
    global main
    extern printf
    extern scanf

main:
    ; Contador de elementos
    mov ecx, MAX

    mov edi, vetor ; Copia para o registrador EDI o endereco/rotulo
                   ; do inicio do vetor na memoria
                   ; Em outras palavras, EDI = &vetor[0];

    ; Laco para o preenchimento do vetor...
proximo:
    push ecx    ; Salva na pilha os valores atuais de ECX e EDI que
    push edi    ; serao sobrescritos pela execucao da funcao 'printf'

    push msgent
    call printf
    add esp, 4

    pop edi     ; Recupera da pilha na sequencia inversa do armazenamento
    pop ecx

    pusha       ; Empilha (salva) TODOS os registradores

    ; scanf("%d", &vetor[i]);
    push edi       ; empilha o endereco do elemento (da posicao) da vez
                   ; dentro do vetor
    push fmtent    ; empilha o formato "%d" para chamar scanf
    call scanf
    add esp, 8

    popa        ; Recupera TODOS os registradores

    add edi, 4     ; ++i (salta os 4 bytes de um int na memoria)
                   ; essa eh a operacao que eh realizada por uma
                   ; aritmetica de ponteiro quando o tal ponteiro
                   ; eh do tipo int* (++p -> soma 4 ao valor de p)

    loop proximo

    ; Laco para identificar o maior e o menor numero
    mov ecx, MAX
    mov esi, vetor ; ESI eh usualmente utilizado quando o vetor eh
                   ; "fonte" de dado (EDI usado quando eh "destino")
proximo2:
    mov edx, dword [esi] ; ESI tem um endereco, [ESI] busca o valor
                         ; no endereco

    ; Verifica se estah no primeiro passo do laco (ECX ainda eh MAX)
    cmp ecx, MAX
    je primeiro_passo

    ; Valor atual do vetor (copiado para EDX) eh maior que 'maior'?
    cmp edx, dword [maior]
    jg atualiza_maior

    ; Valor atual do vetor eh menor que 'menor'?
    cmp edx, dword [menor]
    jl atualiza_menor
    jmp continua ; nao eh nem maior, nem menor, continua pelo vetor

primeiro_passo:
    mov dword [maior], edx  ; No primeiro passo do laco o (primeiro)
    mov dword [menor], edx  ; elemento do vetor eh o maior E o menor
    jmp continua

atualiza_maior:
    mov dword [maior], edx
    jmp continua

atualiza_menor:
    mov dword [menor], edx

continua:
    add esi, 4 ; ESI aponta para o proximo elemento no vetor

    loop proximo2

    push dword [menor]
    push dword [maior]
    push msgsai
    call printf
    add esp, 12

    mov ebx, 0
    mov eax, 1
    int 0x80

section .bss
; int vetor[MAX];
vetor: resd MAX ; reserva MAX (5) double-words na memoria, iniciando
                ; na posicao *rotulada* por 'vetor'
menor: resd 1
maior: resd 1
