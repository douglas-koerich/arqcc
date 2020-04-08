; Pseudo-codigo do algoritmo
; inicio
;   declare a, b, c, p: inteiro
;   leia a, b, c
;   p <- a + b + c
;   escreva p
; fim

section .text
    global main
    extern printf
    extern scanf

main:
    ; printf("Digite o 1o. lado do triangulo: ");
    push strlado1 ; passa como parametro o endereco (rotulo) da mensagem
    call printf
    add esp, 4 ; retira da pilha o parametro que foi passado (rotulo de 32 bits)

    ; scanf("%d", &a);
    ; ATENCAO: quando existe mais de um parametro, eles devem ser empilhados
    ; na ordem inversa, i.e., da direita para a esquerda!
    push a ; empilhando o &a = rotulo a
    push scanfint
    call scanf
    add esp, 8 ; foram empilhados 2 rotulos de 4 bytes cada

    push strlado2
    call printf
    add esp, 4

    push b
    push scanfint
    call scanf
    add esp, 8

    push strlado3
    call printf
    add esp, 4

    push c
    push scanfint
    call scanf
    add esp, 8
    
    ; p = a;
    ; mov p, a --> NAO EH VALIDA, porque ambos os operandos estao em memoria
    mov edx, dword [a] ; copia para EDX o *conteudo* do rotulo (da pos. memoria)
                       ; 'a', com tamanho de uma double-word (32 bits)
    mov dword [p], edx ; copia para o *conteudo* do rotulo 'p' o valor armazenado
                       ; em EDX

    ; p += b;
    ; add [p], [b] --> NAO EH VALIDA, porque ambos estao em memoria
    mov eax, dword [p] ; EAX (acumulador) vai armazenar o resultado da soma
    add eax, dword [b]
    mov dword [p], eax ; devolve o resultado para a memoria

    ; p += c;
    mov eax, dword [p]
    add eax, dword [c]
    mov dword [p], eax

    ; printf("O perimetro do triangulo eh %d\n", p);
    push dword [p] ; empilha o VALOR (nao o rotulo) para ser impresso
    push msgfinal
    call printf

    mov eax, 1 ; codigo da sys_exit (1) armazenado em EAX
    mov ebx, 0 ; EXIT_SUCCESS vale 0
    int 0x80   ; chama o S.O. Linux para encerrar o programa

section .data
; rotulos de posicoes de memoria para valores constantes
strlado1: db "Digite o 1o. lado do triangulo: ",0 ; necessario adicionar o '\0'
strlado2: db "Digite o 2o. lado: ",0
strlado3: db "Finalmente, o 3o. lado: ",0
scanfint: db "%d",0 ; tambem o scanf precisa ver uma string no formato em C,
                    ; isto eh, com um terminador nulo (,0)
msgfinal: db "O perimetro do triangulo eh %d",10,0 ; NAO incluir o \n na constante

section .bss
; rotulos das posicoes de memoria "reservadas" para o armazenamento
; de valores
a:  resd 1 ; reserva uma palavra "d"upla (32 bits) na memoria usando resd
b:  resd 1
c:  resd 1
p:  resd 1

