; declare total, notas : inteiro
; inicio
;   leia total
;   notas <- total / 100
;   total <- resto(total, 100)
;   escreva notas
;   notas <- total / 50
;   total <- resto(total, 50)
;   ...
;   notas <- total / 2
;   escreva notas
;   notas <- total % 2
;   escreva notas
; fim

section .text
    extern printf
    extern scanf
    global main

%macro PRINT_NOTAS 0
    push    edx         ; SALVA o EDX que vai ser recuperado depois na pilha, pra que nao se
                        ; perca o resto da divisao feita na instrucao anterior
    push    eax         ; O quociente da divisao estah em EAX (o resto em EDX)
    push    ebx         ; O divisor, que eh o valor de face da nota
    push    str_notas
    call    printf      ; Esse printf vai modificar o EDX, com certeza!, por isso o empilhamos
    add     esp, 12
    pop     edx         ; RECUPERA o resto que foi salvo na pilha
                        ; (pela instrucao a seguir, deduz-se que poderia fazer: pop eax)
%endmacro

%macro PRINT_NOTAS_N 1
    mov     eax, edx
    xor     edx, edx
    mov     ebx, %1
    div     ebx
    PRINT_NOTAS
%endmacro

main:
    push    str_total   ; Source = str_total (onde estah o argumento/parametro da subrotina)
    call    printf      ; Chama a subrotina (funcao em C)
    add     esp, 4      ; Retorna o registrador de topo da pilha para a posicao anterior
                        ; (o incremento/add eh pelo tamanho/comprimento do rotulo empilhado)
                        ; OBS.: Na pratica, isso significa ignorar o que foi empilhado

    ; Quando uma subrotina (funcao) tem mais de um argumento/parametro, comeca empilhando
    ; do ultimo para o primeiro (ordem inversa)
    push    total       ; Em assembly, "nomes de variaveis" sao rotulos, i.e., enderecos;
                        ; assim, empilhando /total/ significa empilhar o endereco daquela
                        ; posicao de memoria
    push    str_tipo
    call    scanf
    add     esp, 8      ; "Descarta" 2 parametros de 4 bytes cada, empilhados para o scanf

    mov     eax, [total]; Copia para o registrador EAX o _conteudo_ do rotulo /total/
                        ; [total] em assembly equivale a *total em C (sendo total um endereco)
    mov     edx, 0      ; Zera o EDX porque ele eh usado como MSD (most-significant-dword)
                        ; do dividendo (v. instrucao DIV na pagina de referencia)
                        ; Outra maneira de zerar o EDX eh xor edx, edx (OU-EXCLUSIVO nos bits)
    mov     ebx, 100    ; A instrucao DIV nao aceita um operando imediato
    div     ebx

    ;push    edx         ; SALVA o EDX que vai ser recuperado depois na pilha, pra que nao se
    ;                    ; perca o resto da divisao feita na instrucao anterior

    ;push    eax         ; O quociente da divisao estah em EAX (o resto em EDX)
    ;push    ebx         ; O divisor, que eh o valor de face da nota
    ;push    str_notas
    ;call    printf      ; Esse printf vai modificar o EDX, com certeza!, por isso o empilhamos
    ;add     esp, 12

    ;pop     edx         ; RECUPERA o resto que foi salvo na pilha
    ;                    ; (pela instrucao a seguir, deduz-se que poderia fazer: pop eax)
    PRINT_NOTAS

    mov     eax, edx    ; Copia para EAX (proximo dividendo) o valor em EDX (resto da divisao
                        ; anterior), pra ser dividido pelo valor de nota seguinte
    xor     edx, edx    ; Zera o EDX, do contrario vai "contaminar" a divisao seguinte
    mov     ebx, 50
    div     ebx
    PRINT_NOTAS         ; Uso de macro (precursora dos comandos de linguagens de alto nivel)

    ;mov     eax, edx
    ;xor     edx, edx
    ;mov     ebx, 20
    ;div     ebx
    ;PRINT_NOTAS
    PRINT_NOTAS_N 20

    ;mov     eax, edx
    ;xor     edx, edx
    ;mov     ebx, 10
    ;div     ebx
    ;PRINT_NOTAS
    PRINT_NOTAS_N 10

    ;mov     eax, edx
    ;xor     edx, edx
    ;mov     ebx, 5
    ;div     ebx
    ;PRINT_NOTAS
    PRINT_NOTAS_N 5

    ;mov     eax, edx
    ;xor     edx, edx
    ;mov     ebx, 2
    ;div     ebx
    ;PRINT_NOTAS
    PRINT_NOTAS_N 2

    mov     ebx, 0      ; 0 = EXIT_SUCCESS
    mov     eax, 1      ; 1 = exit (return)
    int     0x80        ; chama system-call do Linux pra encerrar o programa

section .data
str_total:  db  'Digite o valor total (inteiro): ',0    ; 0 para terminar a string p/ printf
str_tipo:   db  '%d',0
str_notas:  db  'O numero de notas de %d eh %d.',10,0   ; 10 eh o \n que nao existe em assembly

section .bss
total:  resd    1 ; // int total;

