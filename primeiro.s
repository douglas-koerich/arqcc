section .text
    global main
    extern printf
main:
    push    msg         ; poe endereco msg na pilha pra chamar a funcao
    call    printf      ; chama a funcao printf() da biblioteca de C
    ;pop     eax        ; tira da pilha o endereco passado pra printf
    add     esp, 4      ; muda o registrador do topo da pilha para "esquecer" msg

    ; Instrucoes de saida do programa
    mov     eax, STDOUT
    mov     ebx, EXIT_SUCCESS
    int     80h

section .data
STDOUT:         equ 1   ; #define STDOUT 1
EXIT_SUCCESS:   equ 0   ; #define EXIT_SUCCESS 0
msg:    db  'Meu primeiro programa',10,0    ; adiciona 0 como terminador nulo
                                            ; (vou usar msg como uma string de C)

section .bss
