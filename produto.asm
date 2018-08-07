%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ; printf("Digite o primeiro numero (a): ");
    PRINT_STRING pedido_a

    ; scanf("%d", &a);
    GET_DEC 4, a

    PRINT_STRING pedido_b
    GET_DEC 4, b

    mov     eax, [a]    ; le o CONTEUDO do endereco/rotulo de 'a' para o registrador EAX
    mov     ebx, [b]
    imul    ebx         ; multiplicacao de numeros COM sinal
    mov     [m], eax

    ; printf("O produto dos numeros eh %d.\n", m);
    PRINT_STRING resultado
    PRINT_DEC 4, m

    ;write your code here
    xor eax, eax
    ret
    
section .data
pedido_a:   db  'Digite o primeiro numero (a): ',0
pedido_b:   db  'Digite o segundo numero (b): ',0
resultado:  db  'O produto dos numeros eh ',10,0
ctle_tipo:  db  '%d',0

section .bss
a:  resd    1
b:  resd    1
m:  resd    1
