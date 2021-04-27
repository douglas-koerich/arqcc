section .text ; define a parte do modulo Assembly relativo as instrucoes
    global main ; publica o rotulo 'main' pra ser chamado de outro modulo
    extern printf ; "importa" uma referencia externa a ser usada aqui    
main:
FORMUL:
    mov eax, [I] ; copia para EAX o _conteudo_ da posicao cujo rotulo eh I
    add eax, [J] ; soma ao valor atual de EAX o _conteudo_ da posicao J
    add eax, [K]
    mov [N], eax

    ; printf("O valor de N eh %d\n", N);
    ;                  ^             ^
    ;                  |             |
    push dword [N] ; ----------------+ ; dword [N] = os 32 bits que estao
                   ;   |                 contidos em N
    push STRING ; -----+ ; empilha na ordem INVERSA dos parametros
    call printf
    add esp, 8 ; limpa a pilha usada por [N] e STRING simplesmente
               ; adicionando ao registrador que indica o topo (ESP) a
               ; quantidade de bytes que foi ocupada por [N] (4 bytes)
               ; e o rotulo/endereco STRING (32 bits = 4 bytes)

    ; exit(EXIT_SUCCESS);
    mov ebx, EXIT_SUCCESS
    mov eax, EXIT_SYSCALL
    int 80h ; interrupcao do Linux para chamar uma funcao de sistema

section .data ; parte do modulo onde se reserva memoria para valores
              ; JAH inicializados (conhecidos)

; Note que dados em secoes ah parte do codigo acabam demonstrando que variaveis
; em assembly sao sempre globais

I:  dd  2 ; I eh o endereco onde reside uma palavra dupla (32 bits) igual a 2
J:  dd  3
K:  dd  4
N:  dd  0

STRING: db  "O valor de N eh %d",10,0 ; 10 = \n (codigo da tabela ASCII)
                                      ; 0 = terminador nulo necessario para C

; #define EXIT_SUCCESS 0
EXIT_SUCCESS: equ   0
EXIT_SYSCALL: equ   1 ; numero da chamada de sistema para exit() (v. tutorial)

section .bss ; reserva de memoria para dados NAO inicializados