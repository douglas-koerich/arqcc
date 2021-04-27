%include "io.inc"

section .text ; define a parte do modulo Assembly relativo as instrucoes
    global CMAIN ; publica o rotulo 'main' pra ser chamado de outro modulo
CMAIN:
    mov ebp, esp; for correct debugging
FORMUL:
    mov eax, [I] ; copia para EAX o _conteudo_ da posicao cujo rotulo eh I
    add eax, [J] ; soma ao valor atual de EAX o _conteudo_ da posicao J
    add eax, [K]
    mov [N], eax

    PRINT_STRING STRING
    PRINT_DEC 4, N
    NEWLINE

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

STRING: db  "O valor de N eh ",0 ; 0 = terminador nulo necessario para C

; #define EXIT_SUCCESS 0
EXIT_SUCCESS: equ   0
EXIT_SYSCALL: equ   1 ; numero da chamada de sistema para exit() (v. tutorial)

section .bss ; reserva de memoria para dados NAO inicializados