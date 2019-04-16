section .text
    global main
    extern printf
    extern scanf

%macro READ_VALUE 3 ; macro com 3 argumentos ("parametros") de entrada
    push    %1      ; empilha primeiro parametro da macro
    call    printf
    add     esp, 4
    push    %3      ; empilha o terceito parametro...
    push    %2      ; ... e depois o segundo
    call    scanf
    add     esp, 8
%endmacro

main:
    READ_VALUE  str_n1, str_tipo_i, num1 ; com 2+ parametros, separa com virgula
    READ_VALUE  str_n2, str_tipo_i, num2
    READ_VALUE  str_op, str_tipo_c, oper

    mov     eax, [num1]     ; carrega o CONTEUDO de num1 para o registrador EAX
    mov     ebx, [num2]
    mov     cl, byte [oper] ; carrega um BYTE do CONTEUDO de oper para o registrador CL

    cmp     cl, '+'         ; teste do conteudo (byte/caractere) em CL
    je      soma
    cmp     cl, '-'
    je      subtracao
    cmp     cl, '*'
    je      multiplicacao
    cmp     cl, '/'
    je      divisao

    push    str_inv         ; se nao saltou acima (para uma operacao), imprime INVALIDA
    call    printf
    add     esp, 4
    jmp     fim             ; nada mais a fazer, vai para o termino do programa

soma:
    add     eax, ebx        ; executa a operacao em questao...
    jmp     salva           ; ... e salta para o armazenamento do resultado na variavel

subtracao:
    sub     eax, ebx
    jmp     salva

multiplicacao:
    imul    ebx
    jmp     salva

divisao:
    xor     edx, edx        ; necessario limpar o EDX quando se faz a divisao
    idiv    ebx

salva:
    mov     [res], eax      ; salva o resultado da operacao na variavel em memoria

    push    dword [res]     ; empilha o CONTEUDO da variavel (diferente do que fazemos pro scanf)
    push    str_res
    call    printf
    add     esp, 8

fim:
    mov     ebx, 0
    mov     eax, 1
    int     80h

section .data
str_n1:     db  'Digite o primeiro numero: ',0
str_n2:     db  'Agora, digite o segundo: ',0
str_tipo_i: db  '%d',0
str_op:     db  'Escolha a operacao pelo simbolo (+,-,*,/): ',0
str_tipo_c: db  ' %c',0 ; usamos o truque do espaco-em-branco antes do %c pra limpar o teclado
str_res:    db  'O resultado eh %d.',10,0
str_inv:    db  'OPERACAO INVALIDA',10,0

section .bss
num1:   resd    1
num2:   resd    1
oper:   resb    1   ; note que eh resB (de "byte") aqui (no meu caso/na minha solucao...)
res:    resd    1

