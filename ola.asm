section .text ; secao de codigo do seu programa/modulo
    extern printf ; declaracao de um ROTULO externo a este modulo
    global main   ; publicacao do ROTULO 'main' para outros modulos

main: ; equivalente ah funcao main() de um programa em C
    
    ; printf("Ola\n");
    push string ; empilha o parametro (string) que sera usada em printf
    call printf ; chama a funcao 'printf' da biblioteca de C
    add esp, 4 ; a pilha cresce "para baixo" na memoria, portanto o
               ; 'push' DIMINUIU o valor do registrador ESP de um valor
               ; correspondente ao tamanho do rotulo (32 bits = 4 bytes).
               ; Entao, aqui estamos "devolvendo" esses 4 bytes para a pilha,
               ; como se fosse um 'pop', AUMENTANDO (incrementando)
               ; o registrador ESP do mesmo valor

    ; return 0
    mov eax, 1 ; v. sys_exit na tabela de system calls do Linux
    mov ebx, 0 ; o valor 0 (zero) que eh retornado na saida do programa
    int 0x80   ; chamada a system call do S.O. (Linux)

section .data ; secao de constantes do seu programa

string: db "Ola",10,0 ; define um conjunto de bytes (db), que contem
                      ; uma sequencia de caracteres SEGUIDA pelo
                      ; codigo ASCII do \n (que eh C, nao assembly!)
                      ; e do codigo do terminador NULO (porque o
                      ; printf presume que esse terminador estarah
                      ; no fim da sequencia

section .bss  ; secao de alocacao de memoria para "variaveis"
              ; em assembly todas as variaveis sao GLOBAIS


