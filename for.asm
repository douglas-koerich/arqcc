section .data
numero: db  '%d',10,0

section .bss

section .text
    extern printf
    global main

;int main(void) {
;    int i;
;    for (i=1; i<=10; ++i) {
;        printf("%d\n", i);
;    }
;    return 0;
;}

main:
    mov     eax, 1  ; inicializa EAX com o primeiro valor a ser impresso <=> int i=1;
    mov     ecx, 10 ; numero de vezes que o laco serah executado

inicio:
    ; TODA VEZ QUE UMA ROTINA (FUNCAO) EH CHAMADA, NADA SE PODE AFIRMAR SOBRE O QUE ELA
    ; FAZ COM OS REGISTRADORES
    ; Registradores NAO sao como as "variaveis locais" na linguagem C; sendo GLOBAIS, uma
    ; funcao chamada por voce PROVAVELMENTE vai alterar os valores que voce pos nos registradores
    ; Sendo assim, devo salvar NA PILHA (memoria) os registradores EAX e ECX usados no laco
    push    eax
    push    ecx

    ; Esses proximos PUSHes sao aqueles usados pelo printf
                    ; ao inves de empilhar o valor de uma variavel, esse valor estah num registrador
    push    eax     ; poe na pilha o VALOR armazenado em EAX (sem colchetes pq eh um registrador)
    push    numero  ; poe o endereco da string (como pede o primeiro parametro de printf)
    call    printf
    add     esp, 8

    ; RECUPERA OS VALORES DOS REGISTRADORES QUE FORAM SALVOS NA PILHA
    pop     ecx     ; o ultimo empilhado, o primeiro desempilhado
    pop     eax

    inc     eax     ; incrementa o valor de EAX (equivalente ao ++i no laco for)
    loop    inicio  ; volta para o rotulo 'inicio' se ECX > 0 (uso implicito do ECX pela instrucao LOOP
            
    ; Quando ECX = 0, nao volta para 'inicio', continua o programa (que agora vai terminar))
    mov     ebx, 0
    mov     eax, 1
    int     80h

