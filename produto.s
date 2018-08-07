section .text
    global main
    extern printf
    extern scanf
main:
    ; printf("Digite o primeiro numero (a): ");
    push    pedido_a    ; coloca o endereco/rotulo da string a ser impressa por printf
    call    printf
    add     esp, 4      ; (esp+=4) "devolve" os 4 bytes usados por 'pedido_a' na pilha

    ; scanf("%d", &a);
    push    a           ; comeca empilhando o ultimo parametro (&a) --> note que 'a' em assembly eh o ENDERECO
    push    ctle_tipo   ; ... e vai empilhando no sentido inverso
    call    scanf
    add     esp, 8      ; "devolve" o espaco dos 2 parametros de 4 bytes que foram empilhados

    push    pedido_b
    call    printf
    add     esp, 4
    push    b
    push    ctle_tipo
    call    scanf
    add     esp, 8

    mov     eax, [a]    ; le o CONTEUDO do endereco/rotulo de 'a' para o registrador EAX
    mov     ebx, [b]
    imul    ebx         ; multiplicacao de numeros COM sinal
    mov     [m], eax

    ; printf("O produto dos numeros eh %d.\n", m);
    push    dword [m]   ; especifica o numero de bits (dword) que devem ser empilhados a partir do endereco 'm'
    push    resultado
    call    printf
    add     esp, 8

    mov     ebx, 0
    mov     eax, 1
    int     80h

section .data
pedido_a:   db  'Digite o primeiro numero (a): ',0
pedido_b:   db  'Digite o segundo numero (b): ',0
resultado:  db  'O produto dos numeros eh %d.',10,0
ctle_tipo:  db  '%d',0

section .bss
a:  resd    1
b:  resd    1
m:  resd    1
